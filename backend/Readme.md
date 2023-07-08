# Setup

## Routes

### Welcome Route

**GET:** &emsp; /api/v0/welcome

&nbsp;\
**Description:**

- Health check Route
- Shows some basic details about the API

---

### Auth Route

**POST:** &emsp; /api/v0/auth/google-sign-in

&nbsp;\
**Description:**

- Supposed to be used for **both Google Sign in and Google Sign Up**
- If user does not exist it creates it
- Gets the user data from idToken

**Payload:**

```json
{
  "idToken": "<>"
}
```
