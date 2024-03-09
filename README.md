## Pricetrack

Pricetrack is a containerized web scraper built to scan for price changes on any online marketplace.

<!-- ![Pricetrack home page screenshot](/app/public/images/screenshots/homepage.png "Pricetrack home page") -->
![Pricetrack item page screenshot](/app/public/images/screenshots/itempage.png "Pricetrack item page")

## Usage
### Local

>📝 This application requires docker compose. 

Set app environment varibles before running.
> See the example file **.sample.env** to know which environment variables to set.

To build and run the database, simply run:

```bash
docker compose up
```

In another terminal run:

```bash
cd app/
npm run dev
```
