# Use a base image with Java and bash installed
FROM eclipse-temurin:11-jre

# Set working directory
WORKDIR /app

# Copy all required files
COPY . .

# Make chromium executable
RUN chmod +x chromium/chromium-linux64/chrome

# Set environment variables
ENV JAVA_OPTS="-Xmx512m"

# Create an entrypoint script that replicates the original behavior
RUN echo '#!/bin/sh \n\
DIR_BACKUP_XJAL=$(pwd) \n\
SCRIPT_DIR_XJAL=$(dirname "$0") \n\
cd "$SCRIPT_DIR_XJAL" \n\
exec java -cp model.jar:lib/MaterialHandlingLibrary.jar:lib/ProcessModelingLibrary.jar:lib/MarkupDescriptors.jar:lib/NavigationMesh.jar:lib/LevelSystem.jar:lib/Core.jar:lib/RackSystemModule.jar:lib/jts-core-1.16.0.jar:lib/com.anylogic.engine.jar:lib/com.anylogic.engine.datautil.jar:lib/com.anylogic.engine.editorapi.jar:lib/com.anylogic.engine.generalization.jar:lib/com.anylogic.engine.sa.jar:lib/sa/com.anylogic.engine.sa.web.jar:lib/sa/executor-basic-8.3.jar:lib/sa/ioutil-8.3.jar:lib/sa/jackson/jackson-annotations-2.14.3.jar:lib/sa/jackson/jackson-core-2.14.3.jar:lib/sa/jackson/jackson-databind-2.14.3.jar:lib/sa/spark/javax.servlet-api-3.1.0.jar:lib/sa/spark/jetty-client-9.4.51.v20230217.jar:lib/sa/spark/jetty-http-9.4.51.v20230217.jar:lib/sa/spark/jetty-io-9.4.51.v20230217.jar:lib/sa/spark/jetty-security-9.4.51.v20230217.jar:lib/sa/spark/jetty-server-9.4.51.v20230217.jar:lib/sa/spark/jetty-servlet-9.4.51.v20230217.jar:lib/sa/spark/jetty-servlets-9.4.51.v20230217.jar:lib/sa/spark/jetty-util-9.4.51.v20230217.jar:lib/sa/spark/jetty-util-ajax-9.4.51.v20230217.jar:lib/sa/spark/jetty-webapp-9.4.51.v20230217.jar:lib/sa/spark/jetty-xml-9.4.51.v20230217.jar:lib/sa/spark/slf4j-api-1.7.25.jar:lib/sa/spark/spark-core-2.9.4-AL.jar:lib/sa/spark/websocket-api-9.4.51.v20230217.jar:lib/sa/spark/websocket-client-9.4.51.v20230217.jar:lib/sa/spark/websocket-common-9.4.51.v20230217.jar:lib/sa/spark/websocket-server-9.4.51.v20230217.jar:lib/sa/spark/websocket-servlet-9.4.51.v20230217.jar:lib/sa/util-8.3.jar:lib/querydsl-core-5.0.0.jar:lib/querydsl-sql-5.0.0.jar:lib/querydsl-sql-codegen-5.0.0.jar:lib/commons-lang3-3.9.jar:lib/commons-codec-1.16.0.jar:lib/commons-collections4-4.4.jar:lib/commons-math3-3.6.1.jar:lib/commons-compress-1.25.0.jar:lib/commons-io-2.15.0.jar:lib/log4j-api-2.21.1.jar:lib/log4j-to-slf4j-2.21.1.jar:lib/poi-5.2.5.jar:lib/poi-examples-5.2.5.jar:lib/poi-excelant-5.2.5.jar:lib/poi-ooxml-5.2.5.jar:lib/poi-ooxml-lite-5.2.5.jar:lib/poi-scratchpad-5.2.5.jar:lib/xmlbeans-5.2.0.jar $JAVA_OPTS solar_panel_production_line.Simulation "$@" \n\
EXIT_CODE=$? \n\
cd "$DIR_BACKUP_XJAL" \n\
exit $EXIT_CODE' > /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Use the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]