# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2020-10-03

### Fixed

- Setting `RACK_ENV=production` for the container to run in Docker Compose is no longer required.

### Added

- Issuer, Audience, and Subject are optionally configurable using the environment variables `ISSUER`, `AUDIENCE`, and `SUBJECT`.

## [0.1.0] - 2020-09-21

### Added

- Adds `/generate` endpoint to generate a valid JWT with provided claims.
- Adds `/jwks` endpoint for external signature validation.
- Adds `/info` endpoint for identifying the issuer, audience, and subject claims for a generated JWT.
- Adds `/jwks_empty` endpoint to extend testing scenarios.
