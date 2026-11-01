# Cloudflare Worker Backend Documentation

Base URL: `https://turskyi-support-api.dmytro-turskyi.workers.dev`

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
