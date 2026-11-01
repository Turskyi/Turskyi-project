/**
 * @fileoverview REFERENCE COPY ONLY.
 * This code is not executed by the Flutter app directly. It is a documentation
 * copy of the Cloudflare Worker deployed at:
 * https://dash.cloudflare.com/1918e9a6ac2794ef899bc1056f0cde51/workers/services/edit/turskyi-support-api/production
 *
 * To modify backend logic, edit the code directly in the Cloudflare dashboard
 * linked above, and then update this file to reflect those changes for
 * AI/documentation purposes.
 */
export default {
  async fetch(request, env) {
    const requestOrigin = request.headers.get('Origin') || '';
    const allowedOrigins = ['https://turskyi.com', 'https://turskyi.github.io'];

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
    };

    // Handle browser CORS preflight
    if (request.method === 'OPTIONS') {
      return new Response(null, { headers: corsHeaders });
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

        // 1. Send Notification Email to Support
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

        // 2. Send Confirmation Email to Customer
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
