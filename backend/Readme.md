# Setup

## Routes

### Welcome Route

**1. GET:** &emsp; /api/v0/welcome

&nbsp;\
**Description:**

- Health check Route
- Shows some basic details about the API

---

### Auth Route

**1. POST:** &emsp; /api/v0/auth/google-sign-in

&nbsp;\
**Description:**

- Supposed to be used for **both Google Sign in and Google Sign Up**
- If user does not exist it creates it
- Gets the user data from idToken

**Parameters:**

- idToken: Google Authentical idToken [**required**]

**Payload:**

```json
{
  "idToken": "<string>"
}
```

---

### Data Route

- Accessible only to ADMIN

**Headers:**

- Authorization: token
&nbsp;\ &nbsp;\

**1. POST:** &emsp; /api/v0/data/add

&nbsp;\
**Description:**

- Not supposed to be called externally though not enforced.
- Suggested so, since it needs precise values
- When triggered makes the flag isMaintainanceActive to true lettings the users know that maintainance is active if they access _Search Route_
- Scrape data and add to database
- The tags which were also there in the newly added images, their data will also be updated

**Parameters:**

- query: the tag for the image
- source: unsplash | pexels [**required**]
- perPage: for perPage request while scraping [**Default: 10**]
- page: current page number while requesting for scraping [**Default: 1**]
- returns: newEntries, newTags, didReachEnd
  - newEntries: How many new entries were made
  - newTags: How many new tags were encountered
  - didReachEnd: Was the request page the last page

**Payload:**

```json
{
  "query": "<string>",
  "source": "<ImageSource>",
  "perPage": "<int>",
  "page": "<int>"
}
```
&nbsp;\ &nbsp;\

**2. POST:** &emsp; /api/v0/data/chain-add

&nbsp;\
**Description:**

- Current heart of the data of the API
- Starts a timer which automatically triggers itself(this route) i.e. once initated, at random interval(bounded: current between 30 and 45 mins) will call itself and will add data for the next scraping page
- while doing so it lets others know that isMaintainanceActive flag is set to true
- It automatically gets the tags stored in the state from previous scrape
- After every call it returns the time when will it be called next
- If no tags are available it stops

**Parameters:**

- query: the tag for the image
- chainNewTags: If true, the tags found during parsing of the current query will be added to queue and if they were already parsed their state is reset so that they can be parsed again [**Default: false**]
- partialScrape: It is meant for the subsequent requests once when the base data is ready. If set to true, it will scrape as usual but in a scrape (for a given page) if there are no new images added to the database it assumes that the data has synced with the backend thus it stops there. [**Default: true**]

**Payload:**

```json
{
  "query": "<string>",
  "chainNewtags": "<bool>",
  "partialScrape": "<bool>"
}
```
