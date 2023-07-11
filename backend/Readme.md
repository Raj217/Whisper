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

**Parameters:**

- idToken: Google Authentical idToken [required]

**Payload:**

```json
{
  "idToken": <string>
}
```

---

### Data Route

**POST:** &emsp; /api/v0/data/add

&nbsp;\
**Description:**

- Accessible only to ADMIN
- Not supposed to be called externally though not enforced.
- Suggested so, since it needs precise values
- When triggered makes the flag isMaintainanceActive to true lettings the users know that maintainance is active if they access *Search Route*
- Scrape data and add to database
- The tags which were also there in the newly added images, their data will also be updated

**Parameters:**

- query: the tag for the image
- source: unsplash | pexels [required]
- per_page: for per_page request while scraping [Default: 10]
- page: current page number while requesting for scraping [Default: 1]
- returns: newEntries, newTags, didReachEnd
  - newEntries: How many new entries were made
  - newTags: How many new tags were encountered
  - didReachEnd: Was the request page the last page

**Payload:**

```json
{
    "query": <string>,
    "source": <ImageSource>,
    "per_page": <int>,
    "page": <int>
}
```
