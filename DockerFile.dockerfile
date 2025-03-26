# # Use an official OpenJDK base image
# FROM openjdk:11-jre-slim

# # Install X11 dependencies for GUI forwarding (on Windows)
# RUN apt-get update && \
#     apt-get install -y \
#     x11-apps \
#     libxext6 \
#     libxrender1 \
#     libxtst6 \
#     libxi6 \
#     && rm -rf /var/lib/apt/lists/*

# # Set environment variables for GUI forwarding (adjust for Windows)
# ENV DISPLAY=host.docker.internal:0

# # Copy the .jar file into the container
# COPY GUIApp.jar /app/GUIApp.jar

# # Set the working directory
# WORKDIR /app

# # Command to run the .jar file
# # ENTRYPOINT ["java", "-jar", "GUIApp.jar"]

# ENTRYPOINT ["java", "-Djava.awt.headless=false", "-jar", "GUIApp.jar"]


# Use an official OpenJDK base image
FROM openjdk:11-jre-slim

# Install Xvfb (virtual display), necessary libraries, and other dependencies
RUN apt-get update && \
    apt-get install -y \
    xvfb \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libxi6 \
    && rm -rf /var/lib/apt/lists/*

# Set environment variable for Java to not use headless mode
ENV DISPLAY=:99

# Copy your .jar file into the container
COPY SimpleGuiApp.jar /app/SimpleGuiApp.jar

# Set the working directory
WORKDIR /app

# Command to run the application inside Xvfb
ENTRYPOINT ["xvfb-run", "-a", "java", "-jar", "SimpleGuiApp.jar"]
