# Use the official Ubuntu image as a base
FROM ubuntu:20.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install Apache2
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean

# Expose port 80
EXPOSE 80

# Run Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
