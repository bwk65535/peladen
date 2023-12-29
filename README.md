[![Netlify Status](https://api.netlify.com/api/v1/badges/56c706bd-59f8-4184-81d9-fa86a3a30b1d/deploy-status)](https://app.netlify.com/sites/peladen/deploys)

# peladen
[Personal blog](https://peladen.web.id)

## Docker Usage
### Run site locally
Run site locally to do changes with docker compose file `docker/compose-dev.yml`. Current directory will be mounted inside the container so any changes can be seen without rebuilding the image.
```
docker compose -f docker/compose-dev.yml up -d
```

And then open the site at `http://127.0.0.1:1313`

We can checks the hugo logs with:
```
docker compose -f docker/compose-dev.yml logs -f
```

### Build to nginx image
To build the site, packaging it with nginx image and run locally, use docker compose file `docker/compose-build.yml`.
```
docker compose -f docker/compose-build.yml build
```
The resulting docker image can also be moved and run somewhere else.

### Create new site
We can also create new site using docker compose file `docker/compose-dev.yml` with these modification:

- Create a folder for the new site and copy the `docker` folder.
```
mkdir newblog
cp -r peladen/docker newblog/
cd newblog
```

- Open `docker/compose-dev.yml` and comment out this entrypoint
```
#entrypoint: ["hugo", "server", "--bind=0.0.0.0", "--buildDrafts"]
```

- Uncomment this entrypoint and tty
```
entrypoint: cat
...
tty: true
```

- Run docker compose and go inside the container
```
docker compose -f docker/compose-dev.yml up -d
docker compose -f docker/compose-dev.yml exec hugo sh
```

- Create new site
```
hugo new site . --force
```

- Exit and stop container
```
exit
docker compose -f docker/compose-dev.yml down
```

- Restore original entrypoint and comment out tty
```
entrypoint: ["hugo", "server", "--bind=0.0.0.0", "--buildDrafts"]
#entrypoint: cat
...
#tty: true
```

- Run docker compose again and continue site development.
```
docker compose -f docker/compose-dev.yml up -d
```

## License

The content of this project itself is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International license](https://creativecommons.org/licenses/by-sa/4.0/), and the underlying source code used to format and display that content is licensed under the [GPL-3.0 license](LICENSE).