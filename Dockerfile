# Use the latest n8n version for experiments.
# Be aware that breaking changes might occur between versions.
FROM n8nio/n8n:latest

# Switch to root user to perform system-level changes and global npm installs
USER root

# Update package lists, install/update root CA certificates,
# install the required global npm package, and clean up apt cache in a single layer
# This helps ensure SSL/TLS connections work correctly and keeps the image size smaller.
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    update-ca-certificates && \
    npm install -g firecrawl-mcp && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variable to install community nodes on startup.
# n8n will automatically install packages listed here into the correct directory.
# Example: Installing the popular Puppeteer node.
# IMPORTANT: This makes the node list part of the image. Setting this variable
# in your hosting environment (Railway) is more flexible.
ENV N8N_CUSTOM_EXTENSIONS=n8n-nodes-puppeteer

# Optional: Add a healthcheck to verify n8n is running correctly.
# This checks the default health endpoint on the standard n8n port.
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
    CMD curl --fail http://localhost:5678/healthz || exit 1

# Revert back to the non-root 'node' user for security before running the application
USER node

# The main CMD to start n8n is typically inherited from the base n8nio/n8n image
# and doesn't need to be specified here unless you want to override the default startup. 
