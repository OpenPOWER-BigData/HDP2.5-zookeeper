@echo off
REM Licensed to the Apache Software Foundation (ASF) under one or more
REM contributor license agreements.  See the NOTICE file distributed with
REM this work for additional information regarding copyright ownership.
REM The ASF licenses this file to You under the Apache License, Version 2.0
REM (the "License"); you may not use this file except in compliance with
REM the License.  You may obtain a copy of the License at
REM
REM     http://www.apache.org/licenses/LICENSE-2.0
REM
REM Unless required by applicable law or agreed to in writing, software
REM distributed under the License is distributed on an "AS IS" BASIS,
REM WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM See the License for the specific language governing permissions and
REM limitations under the License.

setlocal enabledelayedexpansion
call "%~dp0zkEnv.cmd"

if defined SERVER_JVMFLAGS (
  set JVMFLAGS=%SERVER_JVMFLAGS% %JVMFLAGS%
)

if "%1" == "--service" (
  set ZOO_LOG4J_PROP=INFO,ROLLINGFILE
)

set ZOOMAIN=org.apache.zookeeper.server.quorum.QuorumPeerMain
set ZOO_LOG_FILE=zookeeper-%USERNAME%-server-%COMPUTERNAME%.log

set ARGS="-Dzookeeper.log.dir=%ZOO_LOG_DIR%" "-Dzookeeper.root.logger=%ZOO_LOG4J_PROP%" "-Dzookeeper.log.file=%ZOO_LOG_FILE%" -cp "%CLASSPATH%" %JVMFLAGS% %ZOOMAIN% "%ZOOCFG%"

if "%1" == "--service" (
  @echo ^<service^>
  @echo   ^<id^>zkServer^</id^>
  @echo   ^<name^>zkServer^</name^>
  @echo   ^<description^>This service runs Isotope zkServer^</description^>
  @echo   ^<executable^>%JAVA%^</executable^>
  @echo   ^<arguments^>%ARGS%^</arguments^>
  @echo ^</service^>
) else (
  call %JAVA% %ARGS%
)
endlocal
