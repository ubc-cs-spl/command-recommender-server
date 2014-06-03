rm bin/*.class
javac -cp gson-2.2.4.jar: -d bin src/*.java
cd bin
jar cfm ../../lib/recommender.jar manifest.mf *.class
