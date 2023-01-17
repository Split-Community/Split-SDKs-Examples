## Overview
This is a basic example using Go Split SDK 5.0.1 and Localhost mode reading from Yaml file 

## Environment:

Go go1.10.3 or later

## Getting started:

- Add Split names and Treatments in the yaml file:

```
split.yaml
```

- Update Split names in:

```
src/folder/SDKYaml.go
```

Note:

- The YAML file has specific format, make sure the treatment lines have 4 character spaces.

- Based on the Yaml content, when the user id "key" is used in Treatment() method, "off" treatment is returned, otherwise "on" treatment is returned.

