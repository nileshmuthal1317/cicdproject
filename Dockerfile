# Use a base image that has the necessary tools
FROM python:slim

# Install Apache and Git
RUN apt-get update && \
    apt-get install -y apache2 git && \
    apt-get clean

# Set the working directory to Apache's default web directory
WORKDIR /var/www/html

# Clone the repository into the working directory
RUN git clone --branch master https://github.com/nileshmuthal1317/cicdproject.git .

# Debug: Verify files in the target directory
RUN echo "Listing files in /var/www/html after clone:" && ls -l /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
