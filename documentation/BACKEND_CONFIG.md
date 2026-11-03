# Cloudflare Worker Backend Configuration (`turskyi-support-api`)

This document provides a reference for all Cloudflare Worker environment variables, secrets, and mapping objects used by `turskyi-support-api`.

## Environment Variables & Secrets

In Cloudflare Worker Settings > **Variables and Secrets**:

| Secret / Variable         | Description                                                                                                       |
|---------------------------|-------------------------------------------------------------------------------------------------------------------|
| `RESEND_API_KEY`          | Resend.com API key for support emails (`re_...`).                                                                 |
| `ALLOWED_ORIGIN`          | Comma-separated allowed CORS origins (e.g., `https://turskyi.com,https://turskyi.github.io`).                     |
| `GA_SERVICE_ACCOUNT_JSON` | Full JSON key string for Google Service Account with `analytics.readonly` and `devstorage.read_only` permissions. |
| `PLAY_BUCKET_NAME`        | Cloud Storage bucket name for Google Play reports (e.g. `pubsite_prod_raw_...`).                                  |
| `ASC_PRIVATE_KEY`         | App Store Connect `.p8` private key string (`-----BEGIN PRIVATE KEY-----...`).                                    |
| `ASC_KEY_ID`              | App Store Connect Key ID.                                                                                         |
| `ASC_ISSUER_ID`           | App Store Connect Issuer UUID.                                                                                    |
| `ASC_VENDOR_NUMBER`       | App Store Connect 8-digit Vendor Number.                                                                          |
| `GA_PROPERTY_MAP`         | JSON string mapping app ID to Google Analytics 4 property IDs.                                                    |
| `APP_METADATA_MAP`        | JSON string mapping app ID to Android package names and Apple App IDs.                                            |

---

## JSON Configuration Payloads

### `GA_PROPERTY_MAP`
```json
{
  "weather_fit": { "android": "431049413", "web": "527741989" },
  "life_coaching_ai": { "android": "515588911" },
  "daoism_laozi_ai": { "android": "446333120", "web": "540496553" },
  "ethical_scanner": { "android": "421491625", "web": "531235007" },
  "portion_control": { "android": "478313827", "web": "527582436" },
  "investtracks": { "android": "469159580" },
  "politer_ai": { "android": "418628235", "web": "530865911" },
  "news_glance": { "android": "429042593", "web": "429042593" },
  "mala_knyzhka": { "android": "471305318", "web": "547254127" },
  "anartist_store": { "android": "561863322", "web": "438752601" }
}
```

### `APP_METADATA_MAP`
```json
{
  "weather_fit": { "androidPackage": "com.turskyi.weather_fit", "appleId": "6743688355" },
  "life_coaching_ai": { "androidPackage": "com.turskyi.lifecoach", "appleId": "6743688857" },
  "daoism_laozi_ai": { "androidPackage": "com.turskyi.laozi_ai", "appleId": "6743682937" },
  "ethical_scanner": { "androidPackage": "com.turskyi.ethical_scanner", "appleId": "6743681663" },
  "portion_control": { "androidPackage": "com.turskyi.portion_control", "appleId": "6743641654" },
  "investtracks": { "androidPackage": "com.turskyi.investtrack", "appleId": "6743641818" },
  "politer_ai": { "androidPackage": "com.turskyi.politerai", "appleId": "6743640556" },
  "news_glance": { "androidPackage": "com.turskyi.news_glance", "appleId": "6743685132" },
  "mala_knyzhka": { "androidPackage": "com.turskyi.malaknyzhka", "appleId": "6743679879" },
  "anartist_store": { "androidPackage": "store.anartist.anartiststore", "appleId": "6743679208" },
  "travelling": { "androidPackage": "io.github.turskyi.travellingpro" },
  "sensilence": { "androidPackage": "com.music.android.sensilence" }
}
```
