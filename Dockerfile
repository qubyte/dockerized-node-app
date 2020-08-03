# syntax = docker/dockerfile:1.0-experimental
FROM node:12-slim

# Update software managed by the OS.
RUN apt-get update && apt-get dist-upgrade --yes

# Change to the node user (less privileged) and use its home directory.
USER node
WORKDIR /home/node

# Copy files from the repo into the container.
COPY . .

# Use a production install.
ENV NODE_ENV production

EXPOSE 8000

# Install dependencies, mounting the npm token as a secret. npm forces us to
# do this via a .npmrc file, so we create it and remove it within the same RUN
# step to avoid it showing up in a build layer.
RUN --mount=type=secret,id=npmtoken,mode=644 echo -n "//registry.npmjs.org/:_authToken=" >> .npmrc && \
  cat /run/secrets/npmtoken >> .npmrc  && \
  npm ci && \
  rm .npmrc

# The package file should point to the main module.
CMD ["node", "."]
