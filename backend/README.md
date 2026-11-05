# Cloudflare Worker Backend Documentation

Base URL: `https://turskyi-support-api.dmytro-turskyi.workers.dev`
- **Cloudflare Dashboard:** [Cloudflare Worker Service](https://dash.cloudflare.com/1918e9a6ac2794ef899bc1056f0cde51/workers/services/edit/turskyi-support-api/production)

---

## Endpoints

### 1. Send Support Email
- **Method:** `POST`
- **Path:** `/support`
- **Headers:** 
  - `Content-Type: application/json`
- **Request Body (JSON):**
  ```json
  {
    "name": "Dmytro Test",
    "email": "turskyi@icloud.com",
    "message": "Hello from Postman!"
  }
  ```
- **Success Response (200 OK):**
  ```json
  {
    "success": true,
    "message": "Email sent successfully"
  }
  ```

---

### 2. URL Health Check
- **Method:** `GET`
- **Path:** `/health`
- **Query Parameters:**
  - `url` (string): The target URL to test.
- **Example Request URL:**
  `https://turskyi-support-api.dmytro-turskyi.workers.dev/health?url=https://github.com`
- **Success Response (200 OK):**
  ```json
  {
    "available": true,
    "statusCode": 200
  }
  ```
- **Failure / Unreachable Response (200 OK):**
  ```json
  {
    "available": false,
    "statusCode": 404
  }
  ```

---

### 3. App Ranking & Download Statistics
- **Method:** `GET`
- **Path:** `/ranking`
- **Description:** Aggregates lifetime user/download stats across Web (Google Analytics Data API), Android (Google Play Developer Reporting API), and iOS (App Store Connect Sales API).
- **Example Request URL:**
  `https://turskyi-support-api.dmytro-turskyi.workers.dev/ranking`
- **Success Response (200 OK):**
  ```json
  {
    "updatedAt": "2026-11-03T00:53:56.430Z",
    "subrequestsCount": 32,
    "apps": [
      {
        "id": "weather_fit",
        "total": 5352,
        "ios": 247,
        "android": 3755,
        "web": 1350
      }
    ],
    "status": {
      "googleAuth": true,
      "ascSales": true
    }
  }
  ```

#### How Backend Ranking Logic Works:
1. **Parallel Multi-Source Execution (`Promise.allSettled`)**:
   - Google authentication (RS256 JWT) and App Store Connect authentication (ES256 JWT) execute concurrently.
   - All external API calls run wrapped in `Promise.allSettled`. If any third-party API or individual property encounters a transient outage or 502/429 error, partial metrics from all other operational sources are returned without breaking the response.
2. **Google Analytics Data API (`v1beta`)**:
   - Unique property IDs across all mapped apps are collected into a set and queried once to prevent duplicate subrequests.
   - Requests metrics filtered by dimension `platform` (`web`, `android`, `ios`) since 2020.
3. **Google Play Developer Reporting API (`v1beta`)**:
   - Queries `queryInstallMetrics` for each package name using a dynamic `endTime` based on the current date (`new Date()`).
   - Parses metric values (`decimalValue`, `integerValue`, `value`) to calculate total user installs.
4. **App Store Connect Sales API**:
   - Queries `frequency=YEARLY` (from 2025 onwards) and `frequency=MONTHLY` (for the current year's completed months) using the mandatory `'Accept': 'application/a-gzip'` header.
   - Decompresses Apple's `.a-gzip` TSV files natively using `DecompressionStream('gzip')`.
   - Parses unit counts for first-time app download product types (`1`, `1E`, `1F`, `F1`, `F1-A`, `3`, `3F`), matching records against both numeric `Apple Identifier` and string `SKU` / bundle ID.
5. **Platform User Aggregation**:
   - **Android:** `android = Math.max(ga4AndroidUsers, playDeveloperApiInstalls)`.
   - **iOS:** `ios = ascSalesUnits`.
   - **Web:** `web = ga4WebUsers`.
   - **Total:** `total = ios + android + web`.
6. **Sorting**: Apps are sorted in descending order by `total` user count before returning the JSON payload.
