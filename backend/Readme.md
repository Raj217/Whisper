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

- Accessible only to **Admin**

**Headers:**

- Authorization: token

&nbsp;

**1. POST:** &emsp; /api/v0/data/add

&nbsp;\
**Description:**

- Not supposed to be called externally though not enforced.
- Suggested so, since it needs precise values
- When triggered makes the flag isMaintainanceActive to true lettings the users know that maintainance is active if they access **Search Route**
- Scrape data and add to database
- The tags which were also there in the newly added images, their data will also be updated

**Parameters:**

- query: the tag for the image
- source: unsplash | pexels [**required**]
- perPage: for perPage request while scraping [**Default: 10**]
- page: current page number while requesting for scraping [**Default: 1**]
- returns: newEntries, newTags, didReachEnd
  - newEntriesCount: How many new entries were made
  - newTags: What are the other tags that were encountered
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

&nbsp;

**2. POST:** &emsp; /api/v0/data/chain-add

&nbsp;\
**Description:**

- Current heart of the data of the API
- Starts a timer which automatically triggers itself(this route) i.e. once initated, at random interval(bounded: can be adjusted from the parameters passed) will call itself and will add data for the next scraping page
- while doing so it lets others know that isMaintainanceActive flag is set to true
- It automatically gets the tags stored in the state from previous scrape
- After every call it returns the time when will it be called next
- If no tags are available it stops

**Parameters:**

- query: the tag for the image
- chainNewTags: If true, the tags found during parsing of the current query will be added to queue and if they were already parsed their state is reset so that they can be parsed again [**Default: false**]
- partialScrape: It is meant for the subsequent requests once when the base data is ready. If set to true, it will scrape as usual but in a scrape (for a given page) if there are no new images added to the database it assumes that the data has synced with the backend thus it stops there. [**Default: true**]
- nextCallMinGap: The next automatic call for the chain add min gap duration. Means after minimum of this time the chain add will be called. [**Default: 10**]
- nextCallMaxGap: The next automatic call for the chain add max gap duration. Means after maximum of this time the chain add will be called. [**Default: 14**]

**Payload:**

```json
{
  "query": "<string>",
  "chainNewtags": "<bool>",
  "partialScrape": "<bool>",
  "nextCallMinGap": "<int>",
  "nextCallMaxGap": "<int>"
}
```

&nbsp;

**3. POST:** &emsp; /api/v0/data/stop-chain

&nbsp;\
**Description:**

- If chain-add was active and the timer is scheduled it stops the timer and clears the next planned request for chain-add

&nbsp;

**4. GET:** &emsp; /api/v0/data/state

&nbsp;\
**Description:**

- Gives the current information about the state of the backend about which data is being scraped
- isMaintainanceActive, currentlyScraping, tagsToScrape, unsplashPage, pexelsPage
  - isMaintainanceActive: is currently scrapping data (is the isMaintainanceActive flag set to true).
  - currentScraping: what tag is currently being scraped.
  - tagsToScrape: The tags are in queue which will be scraped later.
  - unsplashPage: page number of unsplash to be scraped next.
  - pexelsPage: page number of pexels to be scraped next.

---

### Search Route

**1. GET:** &emsp; /api/v0/search

&nbsp;\
**Description:**

- Currently the only search route to search for images
- Pagination enabled

**Parameters:**

- query:
  - the search query, can be empty to search for random images
  - If no query is passed it returns images which the user has not seen before in random search (not tested)
  - When in random view it stores a checkpoint of viewed image when downloaded the **thumbnail** (currently)
- page:
  - current page number [Default: 1]
  - ignored if no query is passed (The checkpoint is used then) 
- per_page: image data per page [Default: 10] [Max: 30]
- width: image width [Default: 500 (If both height and width are empty)]
- height: image height
- fit: image fit

**Payload:**

/api/v0/search?query=nature&page=0&per_page=10&width=300&height=400

---

### Content Route

**1. GET:** &emsp; /api/v0/content

&nbsp;\
**Description:**

- **NOTE**: Cannot be called manually. The required data are generated by the API.
- The analyser route
- The urls provided by the search route are of this route
- It allows download acting as an proxy route
- Once download succeeds, it records it for analysis purposes

**Parameters:**

- id: Generated ID
- w: width
- h: height
- q: quality
- auto: filter
- crop: image crop
- fit: image fit
- cs: color space

**Payload:**

/api/v0/content?w=500&q=10
