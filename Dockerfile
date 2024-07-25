# Stage 1: Clone code (Builder)
FROM ubuntu:20.04 AS builder

WORKDIR /app

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install Git
RUN apt-get update && apt-get install -y git

# Update package lists and install Apache2
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean

# Clone your Git repository (replace with your URL)
RUN git clone https://github.com/nileshmuthal1317/cicdproject.git .

# Stage 2: Build runtime image
FROM python:slim

# Copy application code from builder stage
COPY --from=builder /app/cicdproject/* /var/www/html

# Install dependencies (if needed)
# RUN pip install -r requirements.txt  # Example for Python dependencies

# (Rest of your Dockerfile instructions from previous example)

EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
