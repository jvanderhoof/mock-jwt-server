# Mock JWT Server

**This is a tool for testing purposes only!!**

## Introduction

Mock JWT Server is a tool for generating and validating JWT tokens with provided claims. It was developed to meet the internal Cyberark need to build integrations which use JWT tokens for identity.

## Usage

To start:

```sh
docker run --rm -p 8088:8088 jvanderhoof/mock-jwt-server
```

After running the above command, the mock server is available on your localhost. Verify by navigating to http://localhost:8088/info. You should see the following response:

```json
{
  "iss": "jwt.conjur.cyberark.com",
  "aud": "238d4793-70de-4183-9707-48ed8ecd19d9",
  "sub": "19016b73-3ffa-4b26-80d8-aa9287738677"
}
```

## API

### Generate JWT Token

Used to generate a JWT token, optionally, with custom claims

`POST /generate`

#### Token with no additional claims

**Request Body**

None

**Successful Response**

```
eyJraWQiOiJjNWExMDhlMDI3OTUyZmQ0NmU3YmU1ODMyMGNhMDk1NjlmODMyNzk3ZTNlOGM1Y2M2MmNmNDZlMzhkYjUwOTFmIiwiYWxnIjoiUlMyNTYifQ.eyJpc3MiOiJqd3QuY29uanVyLmN5YmVyYXJrLmNvbSIsImF1ZCI6IjIzOGQ0NzkzLTcwZGUtNDE4My05NzA3LTQ4ZWQ4ZWNkMTlkOSIsInN1YiI6IjE5MDE2YjczLTNmZmEtNGIyNi04MGQ4LWFhOTI4NzczODY3NyIsImV4cCI6MTY2Mzc3NDkxMCwiaWF0IjoxNjYzNzcxMzEwfQ.Qtt-t6K8t6ytPl1EmBLJ44LbHD4GHoETGTc5iX8LrtPB3VUIbS-iA-x6aRD9a0vvYnAt4ZUX30azXAWyfDH5M3sluekobJXGSuKgu3uMUYgL2cL7I1JlGSRruOb9bYVyFwgvaUiaRm7cHyx74IQ-dRqNICoebls209VkQG1dttlnQoea0i-ip1vnJHlFpO4pninxGnT6vd0KPz9F8oswwfHJggwfyxpr5BdGix8MpKu8FkVQ8RuFM1oValPYjHZuCX_0znhFLoPsHuRD-lD75hqxOvCYWUmabRFUjjEKb7RMHu7-Nll0su6qOwT0hunh2ouVt0piUuy2O8_lRaMnvg
```

Header:

```json
{
  "kid": "c5a108e027952fd46e7be58320ca09569f832797e3e8c5cc62cf46e38db5091f",
  "alg": "RS256"
}
```

Body:

```json
{
  "iss": "jwt.conjur.cyberark.com",
  "aud": "238d4793-70de-4183-9707-48ed8ecd19d9",
  "sub": "19016b73-3ffa-4b26-80d8-aa9287738677",
  "exp": 1663774910,
  "iat": 1663771310
}
```

#### Token with additional claims

**Request Body**

```json
{
  "namespace_id": "askdjflsakjlaskj",
  "user_login": "jason.vanderhoof",
  "aud": "foo"
}
```

**Successful Response**

```
eyJraWQiOiJjNWExMDhlMDI3OTUyZmQ0NmU3YmU1ODMyMGNhMDk1NjlmODMyNzk3ZTNlOGM1Y2M2MmNmNDZlMzhkYjUwOTFmIiwiYWxnIjoiUlMyNTYifQ.eyJpc3MiOiJqd3QuY29uanVyLmN5YmVyYXJrLmNvbSIsImF1ZCI6IjIzOGQ0NzkzLTcwZGUtNDE4My05NzA3LTQ4ZWQ4ZWNkMTlkOSIsInN1YiI6IjE5MDE2YjczLTNmZmEtNGIyNi04MGQ4LWFhOTI4NzczODY3NyIsImV4cCI6MTY2Mzc3NTM1NywiaWF0IjoxNjYzNzcxNzU3LCJuYW1lc3BhY2VfaWQiOiJhc2tkamZsc2Framxhc2tqIiwidXNlcl9sb2dpbiI6Imphc29uLnZhbmRlcmhvb2YiLCJhdWQiOiJmb28ifQ.Mt24egRpuY0sDhiQppok_n-i8GTCLCYx1Z3_8tq7AfBZzdhQUfmiMLGc0C7YnPAza_2FDQ81kip_d_e4I8zDajAWy2tKY_hibigFB2X9V4J8bbK9qwDhvsw7z_uyIQQHloFhO-QIue3-WqfEhqT3eghLUNWe2Vyh8Gmm3zzqLIJ-w33ZsProhD7bgMtO9UPiFsvYKY-URHZcwM9eLcn48jqnG7f3BBKRC_NqjxKwHzz_kW1wknc7nFx5wIb8PhtHO8kMt6_sRrMuop5e0_USoozy9PUmHPeF9WQMKlMIfBMaIZb7c4oRPmdQd_QtCII8EqFMlG4kHWzKquB8-bKwbw
```

Header:

```json
{
  "kid": "c5a108e027952fd46e7be58320ca09569f832797e3e8c5cc62cf46e38db5091f",
  "alg": "RS256"
}
```

Body:

```json
{
  "iss": "jwt.conjur.cyberark.com",
  "aud": "foo",
  "sub": "19016b73-3ffa-4b26-80d8-aa9287738677",
  "exp": 1663775357,
  "iat": 1663771757,
  "namespace_id": "askdjflsakjlaskj",
  "user_login": "jason.vanderhoof"
}
```

### JWKS Endpoint

JWKS endpoint to use for verifying a JWT

`GET /jwks`

**Response**

```json
{
  "keys": [
    {
      "alg": "RS256",
      "kty": "RSA",
      "n": "kkG0DokQnaNZN6NQrXuX9eAMC1Sjnj9c7V7JFaXD2LGwDg04uIIlus27SSubLkup4Q-R_YypmecNH8L39rBF9kD6_igodtT2KhuS2wX6xyliQsVHOxVI7T8zaUwxKsNvbLnGyx3x9ND5CftProUXlCqrTCivs3kDk01jDJ0YZO0VgeLXR7hixElKlwMZRv_U9dsNdMn1hoWZ1tJFteOgMyhPTkYvYT8ojz90kf4k0DXt_pE9r8w8ECWnqQx59Vsze4EY94f10wqJv-f2kX9cAPJuoLeDdrFzghPBJ25sEEgbWvxFrX94CzhMOKRr5-xuHTwZkQYMHEPV2eNegkro8Q",
      "e": "AQAB",
      "kid": "c5a108e027952fd46e7be58320ca09569f832797e3e8c5cc62cf46e38db5091f"
    }
  ]
}
```

### Verify

Used to verify a particular JWT against the JWKS endpoint. The decoded token is returned.

`POST /verify`

**Request Body**

```json
{
  "token": "eyJraWQiOiJjNWExMDhlMDI3OTUyZmQ0NmU3YmU1ODMyMGNhMDk1NjlmODMyNzk3ZTNlOGM1Y2M2MmNmNDZlMzhkYjUwOTFmIiwiYWxnIjoiUlMyNTYifQ.eyJpc3MiOiJqd3QuY29uanVyLmN5YmVyYXJrLmNvbSIsImF1ZCI6IjIzOGQ0NzkzLTcwZGUtNDE4My05NzA3LTQ4ZWQ4ZWNkMTlkOSIsInN1YiI6IjE5MDE2YjczLTNmZmEtNGIyNi04MGQ4LWFhOTI4NzczODY3NyIsImV4cCI6MTY2Mzc3NDkxMCwiaWF0IjoxNjYzNzcxMzEwfQ.Qtt-t6K8t6ytPl1EmBLJ44LbHD4GHoETGTc5iX8LrtPB3VUIbS-iA-x6aRD9a0vvYnAt4ZUX30azXAWyfDH5M3sluekobJXGSuKgu3uMUYgL2cL7I1JlGSRruOb9bYVyFwgvaUiaRm7cHyx74IQ-dRqNICoebls209VkQG1dttlnQoea0i-ip1vnJHlFpO4pninxGnT6vd0KPz9F8oswwfHJggwfyxpr5BdGix8MpKu8FkVQ8RuFM1oValPYjHZuCX_0znhFLoPsHuRD-lD75hqxOvCYWUmabRFUjjEKb7RMHu7-Nll0su6qOwT0hunh2ouVt0piUuy2O8_lRaMnvg"
}
```

**Successful Response**

```json
[
  {
    "iss": "jwt.conjur.cyberark.com",
    "aud": "238d4793-70de-4183-9707-48ed8ecd19d9",
    "sub": "19016b73-3ffa-4b26-80d8-aa9287738677",
    "exp": 1663774910,
    "iat": 1663771310
  },
  {
    "kid": "c5a108e027952fd46e7be58320ca09569f832797e3e8c5cc62cf46e38db5091f",
    "alg": "RS256"
  }
]
```

**Failed Response**

JWT validation can fail for a number of reasons. Any JWT validation failures are recorded in the following form:

Code: `400`

Response:

```json
{
  "error": "Signature has expired"
}
```

### Info

Displays the default information for Issuer, Audience, and Subject.

`GET /info`

**Successful Response**

```json
{
  "iss": "jwt.conjur.cyberark.com",
  "aud": "238d4793-70de-4183-9707-48ed8ecd19d9",
  "sub": "19016b73-3ffa-4b26-80d8-aa9287738677"
}
```

### Empty JWKS Endpoint

Generates an "empty" JWKS endpoint response. This useful when testing for a mis-configured JWKS to ensure the developed component "failes closed".

`GET /jwks_empty`

**Successful Response**

```json
{
  "keys": []
}
```

## Configuration

The following values can optionally be set using environment variables:

- Issuer - set using `ISSUER` environment variable
- Audience - set using `AUDIENCE` environment variable
- Subject - set using `SUBJECT` environment variable

For example:

```sh
docker run --rm \
    --publish 8088:8088 \
    --env ISSUER=http://jwt.mycompany.com \
    --env AUDIENCE=ansible \
    --env SUBJECT=development \
    jvanderhoof/mock-jwt-server
```

Yields the following JWT claims (as viewed through the `/info` endpoint):

```json
{
  "iss": "http://jwt.mycompany.com",
  "aud": "ansible",
  "sub": "development"
}
```

## Contributing

To step into a development environment:

```
bin/start
```

The above command will leave you inside the develment environment. Start a webserver with:

```
bundle exec rackup -p 8088 -o 0.0.0.0
```

When you're done, teardown with:

```
bin/stop
```
