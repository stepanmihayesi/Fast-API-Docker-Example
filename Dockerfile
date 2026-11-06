# stage 1 : Builder stage
FROM python:3.10-slim as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
# copy the rest of the app files
COPY . .

# stage 2 : Final Stage
FROM python:3.10-slim
# set the working dir
WORKDIR /app
# copy dependencies from builder stage
COPY --from=builder /app /app

# Expose port 8000 to make the application accessible
EXPOSE 8000

# Define the command to run the app
CMD [ "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000" ]