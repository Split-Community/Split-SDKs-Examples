## Overview
This a basic sample to use Java Split with Scala SBT command line compiler.

## Environment

SBT 1.3.2

Java 10.0.1


## Getting started

- Add Split Java SDK dependencies to SBT project

```
libraryDependencies += "io.split.client" % "java-client" % "3.2.4"
```

- The code to the SDK is similar to the Java code

```
import io.split.client.SplitClientConfig
import io.split.client.SplitFactoryBuilder
import io.split.client.SplitClient

object Hello extends App {
   val config = SplitClientConfig.builder()
   .setBlockUntilReadyTimeout(15000) 
   .build()
   val splitFactory = SplitFactoryBuilder.build("API KEY", config)
   val client = splitFactory.client()
   client.blockUntilReady()
   println(s"SDK is ready") 
   val treatment = client.getTreatment("Customer Id","Split Name")
   println(s"Treatment ${treatment}")
   client.destroy()
}
```

- To enable debug logging, open the file `build.sbt` and add the log4j dependency

```
libraryDependencies += "org.slf4j" % "slf4j-log4j12" % "1.7.21"

```

- Create the file `log4j.properties` with the following content:

```
log4j.rootLogger=DEBUG, A1
log4j.appender.A1=org.apache.log4j.ConsoleAppender
log4j.appender.A1.layout=org.apache.log4j.PatternLayout
log4j.appender.A1.layout.ConversionPattern=%-4r [%t] %-5p %c %x - %m%n
```

- Store the file under the following path within the SBT project

```
src/main/resources/log4j.properties
```

- To compile and run the code, open the sbt command prompt

```
sbt
```

Then run compile 

```
sbt:sbt> compile
[info] Compiling 1 Scala source to /Users/bilalal-shahwany/Desktop/Projects/Java/SBT/target/scala-2.12/classes ...
[success] Total time: 2 s
```


- Once compilation is successful, use `run` command to run the code

```
sbt:sbt> run
[info] running example.Hello 
SDK is ready
Treatment off
[success] Total time: 7 s
```

## To use
- Update the relevant Split API Key, customerID, and Split name in

```
src/main/scala/Hello.scala
```
