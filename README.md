# Shuttle Bus System API

### Requirement
**>=16.13.0 <=20.10.0**

### Set Up

```
yarn install
```
 
### Run Local Development

```
yarn start
```

### Sync Database (Migrate + Generate + Push)

```
yarn db:sync
```

### Seed Database

```
yarn seed
```

### Open Prisma Studio

```
yarn prisma-studio
```


### Setup Database Local **DOCKER** (In case want to test own data)

```
docker compose up
``` 

Set env (**DATABASE_URL**) -> postgres://postgres:postgres@localhost:5432/postgres?schema=sms_dev
