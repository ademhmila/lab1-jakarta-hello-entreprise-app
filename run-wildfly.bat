@echo off
echo ========================================================
echo Starting WildFly Server from C:\servers\wildfly
echo ========================================================
set "JAVA_HOME=C:\Program Files\Java\jdk-27"
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "C:\servers\wildfly\bin"
call standalone.bat
