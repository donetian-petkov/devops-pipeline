# Use the official PHP image as the base image
FROM php:8.0-cli

# Set the working directory inside the container
WORKDIR /app

# Copy the PHP script into the container
COPY index.php /app/

# Expose port 8000 for the PHP built-in web server
EXPOSE 80

# Run the PHP built-in web server as a foreground process
CMD ["php", "-S", "0.0.0.0:80", "index.php"]
