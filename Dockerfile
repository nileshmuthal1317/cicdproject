# Use a base image with Apache
FROM debian:latest

# Install Apache
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean

# Set the working directory to Apache's default web directory
WORKDIR /var/www/html

# Copy the contents of the repository from the Jenkins workspace to the working directory
COPY . .

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
