# Stage 1: Clone code (Builder)
FROM ubuntu:20.04 AS builder

# Explicitly create the /app directory and set it as the working directory
RUN mkdir -p /app
WORKDIR /app

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install Git
RUN apt-get update && apt-get install -y git

# Update package lists and install Apache2
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean

# Clone your Git repository into the /app directory
RUN git clone https://github.com/nileshmuthal1317/cicdproject.git .

# Debug: List files in /app directory
RUN ls -l /app

# Stage 2: Build runtime image
FROM python:slim

# Create the destination directory
RUN mkdir -p /var/www/html

# Copy application code from builder stage
COPY --from=builder /app/cicdproject/* /var/www/html

# Install dependencies (if needed)
# RUN pip install -r requirements.txt  # Example for Python dependencies

EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
