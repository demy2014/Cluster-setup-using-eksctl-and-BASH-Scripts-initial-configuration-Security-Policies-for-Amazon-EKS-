FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . /app

# Set environment variables
ENV APP_ENV=development
ENV APP_PORT=5000

# Expose the application port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
