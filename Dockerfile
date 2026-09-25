# =============================================================================
# Dockerfile - Coding Assignment 11
# Course:  WEBD-3012 Business Systems Build and Testing
# Author:  Gyanee Jootun
#
# Purpose: Build a Docker image that runs a Create React App development
#          server displaying <h1>Codin 1</h1> on http://localhost:7775
# =============================================================================

# 1. BASE IMAGE
# Node 20 is a long-term support (LTS) version compatible with react-scripts 5.
FROM node:20-alpine

# 2. WORKING DIRECTORY
# Creates the folder inside the container and moves
# into it. All following commands run from here
WORKDIR /jootun_gyanee_site

# 3. ENVIRONMENT VARIABLES
ENV PORT=7775 \
    HOST=0.0.0.0 \
    WATCHPACK_POLLING=true \
    BROWSER=none

# 4. COPY THE DEPENDENCY LIST FIRST
COPY package*.json ./

# 5. INSTALL DEPENDENCIES
RUN npm install

# 6. COPY THE REST OF THE PROJECT
# Copies public/, src/, README.md,into /jootun_gyanee_site.
# Anything listed in .dockerignore is skipped.
COPY . .

# 7. DOCUMENT THE PORT
# States that the app listens on port 7775. 
EXPOSE 7775

# 8. START COMMAND
CMD ["npm", "start"]
