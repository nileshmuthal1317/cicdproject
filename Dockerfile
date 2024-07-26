# Stage 1: Clone code (Builder)
FROM ubuntu:20.04 AS builder

# Create and set the working directory
RUN mkdir -p /app
WORKDIR /app

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install Git
RUN apt-get update && apt-get install -y git

# Clone your Git repository into the /app directory
RUN git clone --branch master https://github.com/nileshmuthal1317/cicdproject.git .

# Debug: List files in /app directory to verify clone
RUN echo "Listing files in /app after clone:" && ls -l /app

# Stage 2: Build runtime image
FROM python:slim

# Install Apache
RUN apt-get update && apt-get install -y apache2 && apt-get clean

# Copy application code from builder stage
COPY --from=builder /app/ /var/www/html/

# Debug: Verify files in the target directory
RUN echo "Listing files in /var/www/html after copy:" && ls -l /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]

