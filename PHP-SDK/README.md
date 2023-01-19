## Overview
This is a basic example code to use PHP Split SDK 6.1.0

## Environment:

Eclipse 4.8.0 php Project 

PDT UI plugin 6.0.0

PHP 7.1.16 or later

Composer 1.6.5

Redis 4.0.10

Split Synchronizer 2.1.1 or later

## Getting started:

- Clone this repo to your local environment

- Start Redis
         
```
redis-server /usr/local/etc/redis.conf
```

- Start Split Synchronizer
         
```
split-sync -sync-admin-port 3010 -api-key "[SDK API KEY]" -log-stdout -log-debug -log-verbose -redis-host localhost -redis-port 6379
```

- Class wrapper for SplitSDK is:

```
SplitPHP/Mysdk.php
```

- Update your relevant Split API Key, Track type and Split names in:

```
SplitPHP/Main.php 
```

