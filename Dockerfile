# Use the latest n8n version for experiments.
# Be aware that breaking changes might occur between versions.
FROM n8nio/n8n:latest

# Switch to root user to install global dependencies
USER root

# Install the Firecrawl mcp
RUN npm install -g firecrawl-mcp

# Switch back to the default node user
USER node
