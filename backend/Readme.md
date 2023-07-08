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

### AuthRoutes

<details>
<summary> <b> 1. POST - /api/v0/auth/sign-up </b> </summary>

<br>
Example:

```
{
  "firstName": "John",
  "lastName": "Doe",
  "email": "johndoe@example.com",
  "password": "buar13@iep",
  "role": "USER"
}
```

id?: string;
firstName?: string;
lastName?: string;
profileImageUrl?: string;
email?: string;
password?: string;
pexelsIDVisited?: string[];
unsplashIDVisited?: string[];
isOAuth?: boolean;
isEmailVerified?: boolean;
<br>
**firstName** required | String <br>
**lastName** optional | String <br>
**email** required | String <br>
**password** required if not isOAuth | String <br>
**isOAuth** deafults to false | Boolean <br>

<h2>Logic:</h2>

- Check for validations as mentioned
- Creates a new user
- If it is not OAuth prompts the user to verify email [NOTE: Does not send OTP on it's own]
- If OAuth returns a token
<br>
_NOTE_: Currently we only support OAuth from google
<br>
</details>
