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
