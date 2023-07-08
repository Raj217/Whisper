# Setup
# _OUTDATED_
## .env

_Create a .env(root level) file with the following params:_

    DATABASE_URL
    JWT_SECRET
    VERSION
    SALT_ROUNDS
    JWT_EXPIRY

## Routes

### Welcome
<details>
<summary> <b> 1. GET - /api/v0/welcome </b> </summary>

<br>
Description:
* Health check Route
* Shows some basic details about the API

</details>

### Auth Route
<details>
<summary> <b> 1. POST - /api/v0/auth/google-sign-in </b> </summary>

<br>
Payload:
```
{
  "idToken": "<>"
}
```
Description:
* Supposed to be used for <b> both Google Sign in and Google Sign Up </b>
* Gets the user data from idToken
* If user does not exist it creates it

</details>
