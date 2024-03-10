## Pricetrack

Pricetrack is a containerized web scraper built to scan for price changes on any online marketplace.

<!-- ![Pricetrack home page screenshot](/app/public/images/screenshots/homepage.png "Pricetrack home page") -->
![Pricetrack item page screenshot](/app/public/images/screenshots/itempage.png "Pricetrack item page")

## Usage
### Local

>📝 This application requires docker compose. 

Set app environment varibles before running.
> See **.sample.env** to know which environment variables to set.
> Or rename .sample.env to .env in each project directory.

To build and run the database, simply run:
```bash
docker compose up
```

To visit the home page go to
> http://localhost:3300

To see what is happening inside the container go to
> http://localhost:7900/?autoconnect=1&resize=scale&password=secret
