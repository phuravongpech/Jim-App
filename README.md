# Jim-App

Jim-App is a mobile application built with Flutter, NestJS backend and a MySQL database. This guide provides step-by-step instructions for setting up and running the project locally using Docker.

## Prerequisites

Ensure the following dependencies are installed on your system before proceeding:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) and [Flutter SDK](https://docs.flutter.dev/release/archive)

## Backend Setup

### 1. Clone the Repository

Clone the repository and navigate into the project directory:

```bash
git clone <repository_url>
cd <your_project_directory>
```

### 2. Configure Environment Variables

Create an `.env` file by copying the example configuration and updating the required values

### 3. Start Backend Service Using Docker

Use Docker Compose to build and start the application:

```bash
docker-compose up --build
```

This command will:
- Build the necessary Docker images.
- Start the MySQL database and backend services.
- Automatically install and execute `npm run start:dev` within the backend container.

### Usage

Once the setup is complete, the backend service will be available at:

```
http://localhost:<BACKEND_PORT>
```

where `<BACKEND_PORT>` is the port specified in your `.env` file.

## Frontend Setup

### 1. Navigate to the Flutter Project

Change into the Flutter app directory:

```bash
cd frontend
```

### 2. Install Dependencies

Fetch the Flutter packages required by the project:

```bash
flutter pub get
```

### 3. Run the Application

Ensure a device or emulator is running, then launch the app:

```bash
flutter run
```

### Usage

Once the setup is complete, you should be able to use the app.

## Additional Notes

You can easily get free api key from [Rapid API (ExerciseDB)](https://rapidapi.com/justin-WFnsXH_t6/api/exercisedb) for new registraion, but for your convenience, you can also contact our telegram (@rivath) to get the api key from us.

For any troubleshooting or additional configuration, refer to the project's documentation or reach out to the development team.
