## Overview
Example: Basic Code to use Split SDK 2.4.5

## Environment
Adnroid Studio 3.4.2 or later Gradle-based project

JRE 1.8.0 or later

Kotlin 1.3.31 or later

Android SDK 28 or later

## Getting started:

1. Clone this repo to your local environment


2. Update your relevant Split API, user Key, Split name in:

``` kotlin
/Kotlin_SDK/app/src/main/java/com/example/bilalal_shahwany/kotlin_sdk/MainActivity.kt
```

3. When the app starts, it will initialize Split factory object, getTreatemnt is called to calculate the treatment when the SDK_READY event is fired.