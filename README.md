# Coding Assignment 11 - Docker File

**Course:** WEBD-3012 Business Systems Build and Testing
**Student:** Gyanee Jootun

A React application created with **Create React App**, running in a **Docker container** as a development environment. The site displays an `<h1>` tag with the text **"Codin 1"** at **http://localhost:7775**.

## Requirements Summary

| Requirement | Value |
|---|---|
| React tooling | Create React App (`react-scripts`) |
| Heading displayed | `<h1>Codin 1</h1>` |
| Docker image name | `jootun_gyanee_coding_assignment11` |
| Container name | `jootun_gyanee_coding_assignment11` |
| Workdir (site files) | `/jootun_gyanee_site` |
| URL | http://localhost:7775 |

---

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and **running**
- [Git](https://git-scm.com/) to clone the repository
- Node.js is **not** required to run the app, because it runs inside the container. It is only needed to recreate the project with `npx create-react-app`.

---

## Step 1 – Create React App Setup

This is how the project was created

```bash
npx create-react-app jootun_gyanee_coding_assignment11
cd jootun_gyanee_coding_assignment11
```

`src/App.js` was then edited to display the required heading:

```js
function App() {
  return <h1>Codin 1</h1>;
}

export default App;
```

Unused starter files (logo, CSS, tests, web vitals) were removed to keep the project focused on the assignment.

---

## Step 2 – Docker Configuration

The `Dockerfile` in the project root does the following:

| Instruction | What it does |
|---|---|
| `FROM node:20-alpine` | Starts from an official image with Node.js and npm installed |
| `WORKDIR /jootun_gyanee_site` | Creates the required workdir and runs all following commands from it |
| `ENV PORT=7775 HOST=0.0.0.0 ...` | Makes the CRA dev server run on port 7775 and accept connections from outside the container |
| `COPY package*.json ./` | Copies the dependency list first (speeds up rebuilds through layer caching) |
| `RUN npm install` | Installs React, ReactDOM and react-scripts inside the image |
| `COPY . .` | Copies the rest of the project into the workdir |
| `EXPOSE 7775` | Documents the port the app uses |
| `CMD ["npm", "start"]` | Starts the Create React App development server when the container runs |

The `.dockerignore` file prevents the local `node_modules` and `build` folders from being copied into the image.

---

## Step 3 – Clone the Repository

```bash
git clone https://github.com/gjootun/<repo-name>.git
cd <repo-name>
```

---

## Step 4 – Build the Docker Image

```bash
docker build -t jootun_gyanee_coding_assignment11 .
```

- `-t` tags the image.
- `.` tells Docker to use the Dockerfile in the current folder.

---

## Step 5 – Create and Run the Container

```bash
docker run -d -p 7775:7775 --name jootun_gyanee_coding_assignment11 jootun_gyanee_coding_assignment11
```

| Flag | Meaning |
|---|---|
| `-d` | Runs the container in the background (detached mode) |
| `-p 7775:7775` | Port mapping: port 7775 on your computer → port 7775 in the container |
| `--name jootun_gyanee_coding_assignment11` | Gives the container its required name |
| last argument | The image to create the container from |

Wait about 10–20 seconds for the development server to compile, then open:

**http://localhost:7775**

You should see the heading **Codin 1**.

### Alternative: Docker Compose

The included `docker-compose.yml` builds the image and creates the same container in one command, with live reload enabled:

```bash
docker compose up --build
```

Stop it with `Ctrl + C`, then run `docker compose down`.

---

## Step 6 – Verify the Requirements

Confirm the container is running with the correct name and port:

```bash
docker ps
```

Expected: a container named `jootun_gyanee_coding_assignment11` with ports `0.0.0.0:7775->7775/tcp`.

Confirm the workdir:

```bash
docker exec jootun_gyanee_coding_assignment11 pwd
```

Expected: `/jootun_gyanee_site`

Confirm the site files are in the workdir:

```bash
docker exec jootun_gyanee_coding_assignment11 ls
```

Expected: `Dockerfile  README.md  docker-compose.yml  node_modules  package.json  public  src`

View the server logs:

```bash
docker logs jootun_gyanee_coding_assignment11
```

Expected: `webpack compiled successfully`

---

## Step 7 – Stop and Clean Up

```bash
docker stop jootun_gyanee_coding_assignment11     # stop the container
docker rm jootun_gyanee_coding_assignment11       # delete the container
docker rmi jootun_gyanee_coding_assignment11      # delete the image
```

---

## Key Concepts

**Create React App (CRA)** - A toolchain that generates a ready-to-use React project with a preconfigured development server, build process and folder structure, so no manual Webpack is needed.

**npm vs npx** - `npm` (Node Package Manager) installs packages and runs scripts from `package.json` (e.g. `npm install`, `npm start`). `npx` runs a package's command once without installing it globally, which is why `npx create-react-app` is used to generate a new project.

**Dockerfile** - A text file of step-by-step instructions Docker follows to build an image.

**WORKDIR** - Sets the folder inside the container where files are copied and commands run. Here it is `/jootun_gyanee_site`.

**Docker image** - A read-only package (blueprint) containing the operating system, Node.js, dependencies and app code, built from the Dockerfile.

**Docker container** - A running instance of an image. Many containers can be created from the same image; this one is named `jootun_gyanee_coding_assignment11`.

**Port mapping** - A container has its own isolated network. `-p 7775:7775` forwards traffic from port 7775 on the host computer to port 7775 inside the container, so the browser can reach the app.

**Deployment on localhost:7775** - The CRA dev server inside the container listens on `0.0.0.0:7775`. Combined with port mapping, visiting `http://localhost:7775` on the host displays the app.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| `Conflict. The container name ... is already in use` | Remove the old container: `docker rm -f jootun_gyanee_coding_assignment11` |
| `port is already allocated` | Another program or container is using 7775. Stop it, or run `docker ps` to find it. |
| Page does not load right away | CRA takes a few seconds to compile. Check `docker logs jootun_gyanee_coding_assignment11`. |
| `Cannot connect to the Docker daemon` | Open Docker Desktop and wait until it is running. |

---

## Project Structure

```
jootun_gyanee_coding_assignment11/
├── Dockerfile            # Instructions to build the Docker image
├── .dockerignore         # Files excluded from the image
├── .gitignore            # Files excluded from Git
├── docker-compose.yml    # Optional one-command build and run
├── README.md             # This file
├── package.json          # Dependencies and npm scripts
├── public/
│   └── index.html        # HTML page containing <div id="root">
└── src/
    ├── index.js          # React entry point
    └── App.js            # Renders <h1>Codin 1</h1>
```
