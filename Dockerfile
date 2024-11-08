# Use an official Python runtime as a parent image
FROM python:latest

# Set the working directory in the container
WORKDIR /code
# Install system dependencies required for potential Python packages
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN pip install poetry

# Copy the current directory contents into the container at /code
COPY . /code/

# Configuration to avoid creating virtual environments inside the Docker container
RUN poetry config virtualenvs.create false

# Install dependencies including development ones
RUN poetry install --no-interaction --no-root

# Run the app. CMD can be overridden when starting the container
CMD ["poetry", "run", "uvicorn", "code.main:app", "--host", "0.0.0.0","--port", "8009","--reload"]