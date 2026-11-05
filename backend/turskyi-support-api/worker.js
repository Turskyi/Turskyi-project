/**
 * @fileoverview Cloudflare Worker for turskyi.com
 * Deploy copy for Cloudflare Worker: turskyi-support-api
 *
 * Endpoints:
 * - POST /support : Sends support emails using Resend.
 * - GET /health   : Checks URL availability.
 * - GET /ranking  : Aggregates lifetime download/user statistics across iOS, Android, and Web.
 */
export default {
  async fetch(request, env) {
    const requestOrigin = request.headers.get('Origin') || '';
    const rawAllowedOrigins =
      env.ALLOWED_ORIGIN || 'https://turskyi.com,https://turskyi.github.io';
    const allowedOrigins = rawAllowedOrigins.split(',').map((o) => o.trim());

    const isAllowed =
      allowedOrigins.includes(requestOrigin) ||
      requestOrigin.startsWith('http://localhost:') ||
      requestOrigin.startsWith('http://127.0.0.1:');

    const corsHeaders = {
      'Access-Control-Allow-Origin': isAllowed
        ? requestOrigin
        : 'https://turskyi.com',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type',
      'Vary': 'Origin',
    };

    // Handle browser CORS preflight
    if (request.method === 'OPTIONS') {
      return new Response(null, { headers: corsHeaders, status: 204 });
    }

    const url = new URL(request.url);

    try {
      // 1. Support Email Endpoint (/support)
      if (url.pathname === '/support' && request.method === 'POST') {
        const body = await request.json();
        const { name, email, message } = body || {};

        if (!name || !email || !message) {
          return new Response(
            JSON.stringify({ error: 'Name, email, and message are required.' }),
            {
              status: 400,
              headers: { ...corsHeaders, 'Content-Type': 'application/json' },
            },
          );
        }

        const adminRes = await fetch('https://api.resend.com/emails', {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${env.RESEND_API_KEY}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            from: 'Do Not Reply Turskyi <no-reply@turskyi.com>',
            to: ['support@turskyi.com'],
            subject: 'New Message Received from Turskyi',
            text: `New support message received:\n\nEmail: ${email}\nName: ${name}\n\nMessage:\n${message}`,
          }),
        });

        if (!adminRes.ok) {
          const errorText = await adminRes.text();
          return new Response(
            JSON.stringify({
              error: 'Failed to send support email',
              details: errorText,
            }),
            {
              status: adminRes.status,
              headers: { ...corsHeaders, 'Content-Type': 'application/json' },
            },
          );
        }

        await fetch('https://api.resend.com/emails', {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${env.RESEND_API_KEY}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            from: 'Do Not Reply Turskyi <no-reply@turskyi.com>',
            to: [email],
            subject: 'Thank You! Your Support Message Has Been Sent to Turskyi',
            text: `Thank you for reaching out to us!\n
            Your support message has been received and will be reviewed
            promptly.\n
            We appreciate your feedback and will get back to you soon.\n\n
            Best regards,\nThe Turskyi Team.`,
          }),
        });

        return new Response(
          JSON.stringify({ success: true, message: 'Email sent successfully' }),
          {
            status: 200,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' },
          },
        );
      }

      // 2. URL Health Check Endpoint (/health)
      if (url.pathname === '/health' && request.method === 'GET') {
        const targetUrl = url.searchParams.get('url');
        if (!targetUrl) {
          return new Response(
            JSON.stringify({ error: "Missing 'url' query parameter" }),
            {
              status: 400,
              headers: { ...corsHeaders, 'Content-Type': 'application/json' },
            },
          );
        }

        try {
          const headRes = await fetch(targetUrl, {
            method: 'HEAD',
            redirect: 'follow',
          });
          return new Response(
            JSON.stringify({
              available: headRes.ok,
              statusCode: headRes.status,
            }),
            {
              status: 200,
              headers: { ...corsHeaders, 'Content-Type': 'application/json' },
            },
          );
        } catch (err) {
          return new Response(
            JSON.stringify({ available: false, error: err.message }),
            {
              status: 200,
              headers: { ...corsHeaders, 'Content-Type': 'application/json' },
            },
          );
        }
      }

      // 3. Ranking Endpoint (/ranking)
      if (url.pathname === '/ranking' && request.method === 'GET') {
        const subrequestsRef = { count: 0 };
        const debugLogs = [];

        // Parse environment maps safely
        const gaPropertyMap = parseJsonSafe(
          env.GA_PROPERTY_MAP,
          defaultGaPropertyMap
        );
        const appMetadataMap = parseJsonSafe(
          env.APP_METADATA_MAP,
          defaultAppMetadataMap
        );

        // Run data providers in parallel
        const [googleTokenResult, ascSalesResult] = await Promise.allSettled([
          getGoogleAccessToken(
            env.GA_SERVICE_ACCOUNT_JSON,
            subrequestsRef,
            debugLogs
          ),
          fetchAscSales(env, subrequestsRef, debugLogs),
        ]);

        const googleAccessToken =
          googleTokenResult.status === 'fulfilled'
            ? googleTokenResult.value
            : null;
        const ascSalesByAppleId =
          ascSalesResult.status === 'fulfilled' ? ascSalesResult.value : {};

        // Collect all unique GA4 property IDs to avoid duplicate calls
        const uniquePropertyIds = new Set();
        for (const appId of Object.keys(appMetadataMap)) {
          const gaProps = gaPropertyMap[appId] || {};
          if (gaProps.web) uniquePropertiesAdd(uniquePropertyIds, gaProps.web);
          if (gaProps.android)
            uniquePropertiesAdd(uniquePropertyIds, gaProps.android);
        }

        // Fetch GA4 data and Play Developer Reporting API data in parallel
        const gaDataMap = {};
        const playInstallsMap = {};

        if (googleAccessToken) {
          const gaFetches = Array.from(uniquePropertyIds).map(async (propId) => {
            const stats = await fetchGA4Data(
              googleAccessToken,
              propId,
              subrequestsRef,
              debugLogs
            );
            gaDataMap[propId] = stats;
          });

          const playFetches = Object.values(appMetadataMap).map(async (metadata) => {
            if (metadata.androidPackage) {
              const installs = await fetchGooglePlayReportingApiInstalls(
                googleAccessToken,
                metadata.androidPackage,
                subrequestsRef,
                debugLogs
              );
              playInstallsMap[metadata.androidPackage] = installs;
            }
          });

          await Promise.allSettled([...gaFetches, ...playFetches]);
        }

        // Unique apps from metadata map
        const appIds = Object.keys(appMetadataMap);

        const appResults = await Promise.allSettled(
          appIds.map(async (appId) => {
            const metadata = appMetadataMap[appId] || {};
            const gaProps = gaPropertyMap[appId] || {};

            let webUsers = 0;
            let androidUsers = 0;
            let iosUsers = 0;

            if (gaProps.web && gaDataMap[gaProps.web]) {
              webUsers += gaDataMap[gaProps.web].web || 0;
            }
            if (gaProps.android && gaDataMap[gaProps.android]) {
              androidUsers += gaDataMap[gaProps.android].android || 0;
            }

            // Check Google Play Developer Reporting API installs
            if (
              metadata.androidPackage &&
              playInstallsMap[metadata.androidPackage] !== null &&
              playInstallsMap[metadata.androidPackage] !== undefined
            ) {
              const playInstalls = playInstallsMap[metadata.androidPackage];
              if (playInstalls > 0) {
                androidUsers = Math.max(androidUsers, playInstalls);
              }
            }

            // Check App Store Connect sales for iOS (match by appleId, androidPackage, or appId)
            const ascKeys = [metadata.appleId, metadata.androidPackage, appId].filter(Boolean);
            for (const key of ascKeys) {
              if (ascSalesByAppleId[key]) {
                iosUsers = Math.max(iosUsers, ascSalesByAppleId[key]);
                break;
              }
            }

            const total = iosUsers + androidUsers + webUsers;

            return {
              id: appId,
              total,
              ios: iosUsers,
              android: androidUsers,
              web: webUsers,
            };
          })
        );

        const apps = appResults
          .filter((r) => r.status === 'fulfilled')
          .map((r) => r.value)
          .sort((a, b) => b.total - a.total);

        const rankingResponse = {
          updatedAt: new Date().toISOString(),
          subrequestsCount: subrequestsRef.count,
          apps,
          status: {
            googleAuth:
              googleTokenResult.status === 'fulfilled' &&
              googleAccessToken !== null,
            ascSales: ascSalesResult.status === 'fulfilled',
          },
          debugLogs: debugLogs.slice(0, 30),
        };

        return new Response(JSON.stringify(rankingResponse), {
          status: 200,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }

      return new Response(JSON.stringify({ error: 'Endpoint not found' }), {
        status: 404,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    } catch (err) {
      return new Response(
        JSON.stringify({
          error: 'Internal Server Error',
          details: err.message,
        }),
        {
          status: 500,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        },
      );
    }
  },
};

// --- Helper Functions & Fallback Configurations ---

function uniquePropertiesAdd(set, prop) {
  if (prop) set.add(prop);
}

function parseJsonSafe(jsonStr, fallback) {
  if (!jsonStr) return fallback;
  try {
    return typeof jsonStr === 'string' ? JSON.parse(jsonStr) : jsonStr;
  } catch (_) {
    return fallback;
  }
}

function base64url(strOrBuffer) {
  let base64;
  if (typeof strOrBuffer === 'string') {
    base64 = btoa(strOrBuffer);
  } else {
    let binary = '';
    const bytes = new Uint8Array(strOrBuffer);
    for (let i = 0; i < bytes.byteLength; i++) {
      binary += String.fromCharCode(bytes[i]);
    }
    base64 = btoa(binary);
  }
  return base64.replace(/=/g, '').replace(/\+/g, '-').replace(/\//g, '_');
}

async function getGoogleAccessToken(saJson, subrequestsRef, debugLogs) {
  if (!saJson) {
    debugLogs.push('GA_SERVICE_ACCOUNT_JSON missing');
    return null;
  }
  const sa =
    typeof saJson === 'string' ? parseJsonSafe(saJson, null) : saJson;
  if (!sa || !sa.private_key || !sa.client_email) {
    debugLogs.push('GA_SERVICE_ACCOUNT_JSON invalid format');
    return null;
  }

  try {
    const pem = sa.private_key;
    const pemHeader = '-----BEGIN PRIVATE KEY-----';
    const pemFooter = '-----END PRIVATE KEY-----';
    const pemContents = pem
      .replace(pemHeader, '')
      .replace(pemFooter, '')
      .replace(/\s/g, '');
    const binaryDer = Uint8Array.from(atob(pemContents), (c) =>
      c.charCodeAt(0)
    );

    const key = await crypto.subtle.importKey(
      'pkcs8',
      binaryDer.buffer,
      { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' },
      false,
      ['sign']
    );

    const now = Math.floor(Date.now() / 1000);
    const header = { alg: 'RS256', typ: 'JWT' };
    const claimSet = {
      iss: sa.client_email,
      scope:
        'https://www.googleapis.com/auth/analytics.readonly https://www.googleapis.com/auth/playdeveloperreporting',
      aud: 'https://oauth2.googleapis.com/token',
      exp: now + 3600,
      iat: now,
    };

    const unsignedJwt = `${base64url(JSON.stringify(header))}.${base64url(
      JSON.stringify(claimSet)
    )}`;

    const signature = await crypto.subtle.sign(
      'RSASSA-PKCS1-v1_5',
      key,
      new TextEncoder().encode(unsignedJwt)
    );

    const jwt = `${unsignedJwt}.${base64url(signature)}`;

    subrequestsRef.count++;
    const tokenRes = await fetch('https://oauth2.googleapis.com/token', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({
        grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        assertion: jwt,
      }),
    });

    if (!tokenRes.ok) {
      const errText = await tokenRes.text();
      debugLogs.push(`Google token error: ${tokenRes.status} ${errText}`);
      return null;
    }
    const tokenData = await tokenRes.json();
    return tokenData.access_token || null;
  } catch (e) {
    debugLogs.push(`Google token exception: ${e.message}`);
    return null;
  }
}

async function getAscJwt(env) {
  const pem = env.ASC_PRIVATE_KEY;
  const keyId = env.ASC_KEY_ID;
  const issuerId = env.ASC_ISSUER_ID;
  if (!pem || !keyId || !issuerId) return null;

  const pemHeader = '-----BEGIN PRIVATE KEY-----';
  const pemFooter = '-----END PRIVATE KEY-----';
  const pemContents = pem
    .replace(pemHeader, '')
    .replace(pemFooter, '')
    .replace(/\s/g, '');
  const binaryDer = Uint8Array.from(atob(pemContents), (c) =>
    c.charCodeAt(0)
  );

  const key = await crypto.subtle.importKey(
    'pkcs8',
    binaryDer.buffer,
    { name: 'ECDSA', namedCurve: 'P-256' },
    false,
    ['sign']
  );

  const now = Math.floor(Date.now() / 1000);
  const header = { alg: 'ES256', kid: keyId, typ: 'JWT' };
  const payload = {
    iss: issuerId,
    iat: now,
    exp: now + 1200,
    aud: 'appstoreconnect-v1',
  };

  const unsignedToken = `${base64url(JSON.stringify(header))}.${base64url(
    JSON.stringify(payload)
  )}`;

  const derSig = await crypto.subtle.sign(
    { name: 'ECDSA', hash: { name: 'SHA-256' } },
    key,
    new TextEncoder().encode(unsignedToken)
  );

  return `${unsignedToken}.${base64url(derSig)}`;
}

async function fetchAscSales(env, subrequestsRef, debugLogs) {
  const jwt = await getAscJwt(env);
  if (!jwt || !env.ASC_VENDOR_NUMBER) {
    debugLogs.push('ASC credentials missing');
    return {};
  }

  const salesMap = {};
  const currentYear = new Date().getFullYear();
  const startYear = 2025;

  // Fetch yearly reports (2025)
  for (let year = startYear; year < currentYear; year++) {
    try {
      subrequestsRef.count++;
      const url = `https://api.appstoreconnect.apple.com/v1/salesReports?filter[reportType]=SALES&filter[reportSubType]=SUMMARY&filter[frequency]=YEARLY&filter[vendorNumber]=${env.ASC_VENDOR_NUMBER}&filter[reportDate]=${year}`;
      const res = await fetch(url, {
        headers: {
          Authorization: `Bearer ${jwt}`,
          'Accept': 'application/a-gzip',
        },
      });
      if (res.ok && res.body) {
        const ds = new DecompressionStream('gzip');
        const text = await new Response(res.body.pipeThrough(ds)).text();
        parseAscTsv(text, salesMap, debugLogs);
      } else {
        const errText = await res.text();
        debugLogs.push(`ASC yearly ${year} error: ${res.status} ${errText}`);
      }
    } catch (e) {
      debugLogs.push(`ASC yearly ${year} exception: ${e.message}`);
    }
  }

  // Fetch recent completed month of current year
  const currentMonth = new Date().getMonth() + 1;
  if (currentMonth > 1) {
    const prevMonthNum = currentMonth - 1;
    const monthStr = `${currentYear}-${String(prevMonthNum).padStart(2, '0')}`;
    try {
      subrequestsRef.count++;
      const url = `https://api.appstoreconnect.apple.com/v1/salesReports?filter[reportType]=SALES&filter[reportSubType]=SUMMARY&filter[frequency]=MONTHLY&filter[vendorNumber]=${env.ASC_VENDOR_NUMBER}&filter[reportDate]=${monthStr}`;
      const res = await fetch(url, {
        headers: {
          Authorization: `Bearer ${jwt}`,
          'Accept': 'application/a-gzip',
        },
      });
      if (res.ok && res.body) {
        const ds = new DecompressionStream('gzip');
        const text = await new Response(res.body.pipeThrough(ds)).text();
        parseAscTsv(text, salesMap, debugLogs);
      }
    } catch (e) {
      debugLogs.push(`ASC monthly exception: ${e.message}`);
    }
  }

  debugLogs.push(`ASC sales keys found: ${Object.keys(salesMap).join(', ')}`);
  return salesMap;
}

function parseAscTsv(tsvText, salesMap, debugLogs) {
  const lines = tsvText.split(/\r?\n/);
  if (lines.length < 2) return;
  const header = lines[0].split('\t');
  const appleIdIdx = header.findIndex((h) => h.trim() === 'Apple Identifier');
  const skuIdx = header.findIndex((h) => h.trim() === 'SKU');
  const productTypeIdx = header.findIndex(
    (h) => h.trim() === 'Product Type Identifier'
  );
  const unitsIdx = header.findIndex((h) => h.trim() === 'Units');

  if (unitsIdx === -1) return;

  const validProductTypes = new Set(['1', '1E', '1F', 'F1', 'F1-A', '3', '3F']);

  for (let i = 1; i < lines.length; i++) {
    const cols = lines[i].split('\t');
    if (cols.length <= unitsIdx) continue;
    const appleId = appleIdIdx !== -1 ? cols[appleIdIdx]?.trim() : null;
    const sku = skuIdx !== -1 ? cols[skuIdx]?.trim() : null;
    const prodType =
      productTypeIdx !== -1 ? cols[productTypeIdx]?.trim() : '1';
    const units = parseInt(cols[unitsIdx]?.trim(), 10) || 0;

    if (units > 0 && (productTypeIdx === -1 || validProductTypes.has(prodType))) {
      if (appleId) {
        salesMap[appleId] = (salesMap[appleId] || 0) + units;
      }
      if (sku) {
        salesMap[sku] = (salesMap[sku] || 0) + units;
      }
    }
  }
}

async function fetchGA4Data(
  accessToken,
  propertyId,
  subrequestsRef,
  debugLogs
) {
  if (!accessToken || !propertyId) return { web: 0, android: 0, ios: 0 };

  for (let attempt = 1; attempt <= 2; attempt++) {
    try {
      subrequestsRef.count++;
      const res = await fetch(
        `https://analyticsdata.googleapis.com/v1beta/properties/${propertyId}:runReport`,
        {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${accessToken}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            dateRanges: [{ startDate: '2020-01-01', endDate: 'today' }],
            dimensions: [{ name: 'platform' }],
            metrics: [{ name: 'newUsers' }],
          }),
        }
      );

      if (res.ok) {
        const data = await res.json();
        const result = { web: 0, android: 0, ios: 0 };
        const rows = data.rows || [];
        for (const row of rows) {
          const platform =
            row.dimensionValues?.[0]?.value?.toLowerCase() || '';
          const count = parseInt(row.metricValues?.[0]?.value, 10) || 0;
          if (platform.includes('web')) result.web += count;
          else if (platform.includes('android')) result.android += count;
          else if (platform.includes('ios')) result.ios += count;
        }
        return result;
      }

      const errText = await res.text();
      if (
        attempt === 1 &&
        (res.status === 502 || res.status === 503 || res.status === 429)
      ) {
        await new Promise((r) => setTimeout(r, 300));
        continue;
      }
      debugLogs.push(`GA4 prop ${propertyId} error: ${res.status} ${errText}`);
      return { web: 0, android: 0, ios: 0 };
    } catch (e) {
      if (attempt === 1) {
        await new Promise((r) => setTimeout(r, 300));
        continue;
      }
      debugLogs.push(`GA4 prop ${propertyId} exception: ${e.message}`);
      return { web: 0, android: 0, ios: 0 };
    }
  }
  return { web: 0, android: 0, ios: 0 };
}

async function fetchGooglePlayReportingApiInstalls(
  accessToken,
  packageName,
  subrequestsRef,
  debugLogs
) {
  if (!accessToken || !packageName) return null;
  try {
    const now = new Date();
    const endYear = now.getFullYear();
    const endMonth = now.getMonth() + 1;
    const endDay = now.getDate();

    subrequestsRef.count++;
    const url = `https://playdeveloperreporting.googleapis.com/v1beta/apps/${packageName}:queryInstallMetrics`;
    const res = await fetch(url, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        metrics: ['USER_INSTALLED'],
        timelineSpec: {
          aggregationPeriod: 'DAILY',
          startTime: { year: 2024, month: 1, day: 1 },
          endTime: { year: endYear, month: endMonth, day: endDay },
        },
      }),
    });

    if (res.ok) {
      const data = await res.json();
      let totalInstalls = 0;
      const rows = data.rows || data.metrics || [];
      for (const row of rows) {
        const vals = row.metricValues || row.values || [];
        for (const v of vals) {
          let n = 0;
          if (typeof v === 'number') {
            n = v;
          } else if (typeof v === 'string') {
            n = parseInt(v, 10) || 0;
          } else if (v && typeof v === 'object') {
            const valStr =
              v.decimalValue?.value || v.integerValue?.value || v.value;
            n = parseInt(valStr, 10) || 0;
          }
          totalInstalls += n;
        }
      }
      return totalInstalls > 0 ? totalInstalls : null;
    } else {
      const errText = await res.text();
      debugLogs.push(`Play API ${packageName} error: ${res.status} ${errText}`);
    }
  } catch (e) {
    debugLogs.push(`Play API ${packageName} exception: ${e.message}`);
  }
  return null;
}

const defaultGaPropertyMap = {
  weather_fit: { android: '431049413', web: '527741989' },
  life_coaching_ai: { android: '515588911', web: '515588911' },
  daoism_laozi_ai: { android: '446333120', web: '540496553' },
  ethical_scanner: { android: '421491625', web: '531235007' },
  portion_control: { android: '478313827', web: '527582436' },
  investtracks: { android: '469159580', web: '469159580' },
  politer_ai: { android: '418628235', web: '530865911' },
  news_glance: { android: '429042593', web: '429042593' },
  mala_knyzhka: { android: '471305318', web: '547254127' },
  anartist_store: { android: '438752601', web: '561863322' },
  composeship: { android: '560732955', web: '560732955' },
};

const defaultAppMetadataMap = {
  weather_fit: {
    androidPackage: 'com.turskyi.weather_fit',
    appleId: '6743688355',
  },
  life_coaching_ai: {
    androidPackage: 'com.turskyi.lifecoach',
    appleId: '6743688857',
  },
  daoism_laozi_ai: {
    androidPackage: 'com.turskyi.laozi_ai',
    appleId: '6743682937',
  },
  ethical_scanner: {
    androidPackage: 'com.turskyi.ethical_scanner',
    appleId: '6743681663',
  },
  portion_control: {
    androidPackage: 'com.turskyi.portion_control',
    appleId: '6743641654',
  },
  investtracks: {
    androidPackage: 'com.turskyi.investtrack',
    appleId: '6743641818',
  },
  politer_ai: {
    androidPackage: 'com.turskyi.politerai',
    appleId: '6743640556',
  },
  news_glance: {
    androidPackage: 'com.turskyi.news_glance',
    appleId: '6743685132',
  },
  mala_knyzhka: {
    androidPackage: 'com.turskyi.malaknyzhka',
    appleId: '6743679879',
  },
  anartist_store: {
    androidPackage: 'store.anartist.anartiststore',
    appleId: '6743679208',
  },
  composeship: {
    androidPackage: 'com.composeship',
  },
  travelling: { androidPackage: 'ua.turskyi.travelling' },
  sensilence: { androidPackage: 'com.music.android.sensilence' },
};
