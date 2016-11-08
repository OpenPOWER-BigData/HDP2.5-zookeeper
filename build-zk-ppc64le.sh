#!/bin/bash
set -ex
ZOOKEEPER_VERSION=3.4.6.2.5.0.0-1245
ANT_OPTS="-Dversion=$ZOOKEEPER_VERSION $@"
ant compile ${ANT_OPTS}
(cd src/contrib/rest && ant jar ${ANT_OPTS})
ant package package-native tar ${ANT_OPTS}

mvn install:install-file -DcreateChecksum=true -DgroupId=org.apache.zookeeper -DartifactId=zookeeper -Dversion=$ZOOKEEPER_VERSION -Dclassifier=tests -Dpackaging=jar -Dfile=build/zookeeper-$ZOOKEEPER_VERSION-test.jar

mvn install:install-file -DcreateChecksum=true -DgroupId=org.apache.zookeeper -DartifactId=zookeeper -Dversion=$ZOOKEEPER_VERSION -Dpackaging=jar -Dfile=build/zookeeper-$ZOOKEEPER_VERSION.jar
