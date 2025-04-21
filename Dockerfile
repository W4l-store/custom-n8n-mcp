# Use the latest n8n version for experiments.
# Be aware that breaking changes might occur between versions.
FROM n8nio/n8n:latest

# Switch to root user to install global dependencies and update certs
USER root

# Update package lists and install/update CA certificates
# The base n8n image likely uses Alpine, so we use apk
RUN apk update && apk add --no-cache ca-certificates && update-ca-certificates && rm -rf /var/cache/apk/*

# Install the Firecrawl mcp
RUN npm install -g firecrawl-mcp

# Switch back to the default node user
USER node
