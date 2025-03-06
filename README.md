# Jim-App

Jim-App is a backend application built with NestJS and powered by a MySQL database. This guide provides detailed instructions on setting up and running the project locally using Docker.

## Prerequisites

Ensure the following dependencies are installed on your system before proceeding:

- [Docker](https://www.docker.com/get-started) and [Docker Compose](https://docs.docker.com/compose/install/)

## Installation

Follow these steps to set up and run the project:

### 1. Clone the Repository

Clone the repository and navigate into the project directory:

```bash
git clone <your_repository_url>
cd <your_project_directory>
```

### 2. Configure Environment Variables

Create an `.env` file by copying the example configuration and updating the required values:

```bash
cp .env.example .env
```

Edit the `.env` file with your preferred text editor to set the necessary database credentials and API keys:

```bash
nano .env  # Alternatively, use vim .env or code .env
```

### 3. Start the Application Using Docker

Use Docker Compose to build and start the application:

```bash
docker-compose up --build
```

This command will:
- Build the necessary Docker images.
- Start the MySQL database and backend services.
- Automatically execute `npm run start:dev` within the backend container.

### 4. Verify Running Containers

Check if the containers are running successfully:

```bash
docker ps
```

Locate the container name of the backend service (typically named `<project_name>_backend_1`).

### 5. Run Database Migrations

Access the backend container's shell:

```bash
docker exec -it <backend_container_name> sh
```

Replace `<backend_container_name>` with the actual container name from the previous step. Then, execute database migrations:

```bash
npm run migration:run
```

This will create the required database tables and seed any predefined data.

## Usage

Once the setup is complete, the backend service will be available at:

```
http://localhost:<BACKEND_PORT>
```

where `<BACKEND_PORT>` is the port specified in your `.env` file.

You can interact with the API using tools such as [Postman](https://www.postman.com/) or [Insomnia](https://insomnia.rest/).

## Additional Notes

- Ensure that Docker and Docker Compose are installed and properly configured.
- **Do not commit your `.env` file** to version control. Add it to `.gitignore` to protect sensitive credentials.
- Modify the `.env` and `docker-compose.yml` files as needed to match your environment.
- If you encounter database connection issues, double-check the database credentials in the `.env` file.

For any troubleshooting or additional configuration, refer to the project's documentation or reach out to the development team.
