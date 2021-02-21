#!/bin/bash

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ];
then
  echo "Please specify a project name."
  exit 1
fi

echo "===> Creating Maven project in $PWD/$PROJECT_NAME"
mkdir -p $PROJECT_NAME/src/{main,test}/{java/com/$USER,resources}

echo "<project>
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.$USER</groupId>
    <artifactId>$PROJECT_NAME</artifactId>
    <version>1.0.0</version>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.target>11</maven.compiler.target>
        <maven.compiler.source>11</maven.compiler.source>
        <junit-jupiter.version>5.6.2</junit-jupiter.version>
        <junit-jupiter-params.version>5.6.2</junit-jupiter-params.version>
        <mockito.version>1.10.19</mockito.version>
        <maven-surefire-plugin.version>3.0.0-M4</maven-surefire-plugin.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-api</artifactId>
            <version>\${junit-jupiter.version}</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-params</artifactId>
            <version>\${junit-jupiter-params.version}</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.mockito</groupId>
            <artifactId>mockito-all</artifactId>
            <version>\${mockito.version}</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <pluginManagement>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-surefire-plugin</artifactId>
                    <version>\${maven-surefire-plugin.version}</version>
                    <configuration>
                        <includes>
                            <include>**/Test*.java</include>
                            <include>**/*Test.java</include>
                            <include>**/*Tests.java</include>
                            <include>**/*TestCase.java</include>
                            <include>**/*Should.java</include>
                            <include>**/*Acceptance.java</include>
                            <include>**/*Feature.java</include>
                        </includes>
                    </configuration>
                </plugin>
            </plugins>
        </pluginManagement>
    </build>
</project>
" > $PROJECT_NAME/pom.xml

echo "===> SUCCESS"
