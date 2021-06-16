FROM node:alpine

# Copy source code
COPY --chown=node ./app /home/node/app

# Change working directory
WORKDIR /home/node/app

# Install dependencies
RUN npm install

# Expose API port to the outside
EXPOSE 8422

# Set user (always set it right before the CMD because
# it does not have permissions to install stuff).
USER node

# Launch application
CMD ["node", "index.js"]
