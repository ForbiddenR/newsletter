FROM rust:1.84.1-alpine3.21 AS builder

WORKDIR /app

# RUN apk add --no-cache build-base
RUN apk add --no-cache musl-dev gcc

COPY . .

RUN SQLX_OFFLINE=true cargo build --release

FROM alpine:3.21

COPY --from=builder /app/target/release/newsletter /usr/local/bin/newsletter


ENTRYPOINT ["newsletter"]