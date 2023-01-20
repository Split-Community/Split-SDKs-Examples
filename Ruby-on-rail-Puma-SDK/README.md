## Overview
This is a basic example code to use Split SDK 5.0.0

## Environment:

- Ruby 2.3.7 or later

- Rails 5.2.0 or later

- puma 3.12 or later

## Getting Started:

- Clone this repo to your local environment

- SDK initialize class to update API Key: 

```
app/config/initializers/splitclient.rb
```

- Treatment class: 

```
app/controllers/welcome_controller.rb
```

- Starting Puma App engine command: 

```
puma config.ru -w 5 --preload
```


HTTP Access: http://localhost:3000/
