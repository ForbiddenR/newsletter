FROM rust:1.84.1-alpine3.21 AS builder

WORKDIR /app

# RUN apk add --no-cache build-base
RUN apk add --no-cache musl-dev gcc

COPY . .

RUN SQLX_OFFLINE=true cargo build --release

FROM alpine:3.21 AS runtime

WORKDIR /app

ENV APP_ENVIRONMENT=production

COPY --from=builder /app/target/release/newsletter newsletter

COPY configuration configuration

EXPOSE 8000

ENTRYPOINT ["./newsletter"]