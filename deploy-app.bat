@echo off
echo ========================================================
echo Building and Deploying Jakarta EE App to WildFly
echo ========================================================
set "JAVA_HOME=C:\Program Files\Java\jdk-27"
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "%~dp0"
call mvnw.cmd clean package
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Maven build failed!
    pause
    exit /b %ERRORLEVEL%
)
echo Copying war to WildFly standalone\deployments...
copy /y "target\jakartaee-course.war" "C:\servers\wildfly\standalone\deployments\"
echo Deployment finished successfully!
echo Endpoints:
echo - http://localhost:8080/jakartaee-course/hello
echo - http://localhost:8080/jakartaee-course/goodbye
echo - http://localhost:8080/jakartaee-course/
