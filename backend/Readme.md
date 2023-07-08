# Setup

## Routes

### Welcome Route
**GET:** &emsp; /api/v0/welcome
<br> <br>
__Description:__
    
- Health check Route
- Shows some basic details about the API

##
### Auth Route
**POST:** &emsp; /api/v0/auth/google-sign-in
<br><br>
__Description:__
- Supposed to be used for <b> both Google Sign in and Google Sign Up 
- If user does not exist it creates it
- Gets the user data from idToken

__Payload:__
```
{
  "idToken": "<>"
}
```

