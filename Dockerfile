FROM golang:1.21 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM registry.access.redhat.com/ubi8/ubi-minimal:latest
WORKDIR /app
COPY --from=builder /app/main .
# Add permissions for OpenShift
USER 1001
EXPOSE 8080
CMD ["./main"]
