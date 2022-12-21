## Overview:
This is a basic code to use Split Android SDK

## Environment:
Android Studio vervion >= 3.3 Gradle-based project

JRE version >= 1.8.0

Android SDK version >= 27

## Getting started:

1. Update your relevant Split API, user Key, Split name in:

```
/UI_App/app/src/main/java/com/example/example_app/ui_app/MainActivity.java
```

2. Add/edit the wrapper class for the Split SDK as needed in 

```
/UI_App/app/src/main/java/com/example/
example_app/ui_app/SplitSDK.java
```

3. When the app starts, it will initialize Split factory object, when the button is clicked, getTreatemnt is called to calculate the treatment.