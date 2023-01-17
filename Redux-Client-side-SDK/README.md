## Overview

This is a basic example to use Split Redux SDK version 1.1.0 running on client side

Environment:

npm 6.4.1 or later
react 16.13.0 or later
redux 4.0.5 or later
redux-thunk 2.3.0 or later

## Getting started

- Clone this directory to your local environment and cd to the root folder and then run the following command to install all the dependencies:

``` nodejs
npm install
```

- Open file ./src/store.js locate the line below and replace the SDK API KEY with a valid key
 authorizationKey: 'SDK browser API KEY',
Replace the Default Split Name with a valid Split from your org in the line below:

 ``` javascript
 store.dispatch(getTreatments({ splitNames: ['Default Split Name'] }))
 ```

- Run the npm service:

``` javascript
npm start
```

- Using a browser window, use the URL below:

```
http://localhost:3000
```

- The app will calculate treatment for the default Split and show it in the browser page, the page allow typing any other Split Name and the tool will calculate the treatment and show it subsequently, as shown below for Splits sample_feature and clients
Screen_Shot_2020-05-13_at_5.51.13_PM.png

 https://help.split.io/hc/article_attachments/360057271651/Screen_Shot_2020-05-13_at_5.51.13_PM.png

- Since we are using the SDK in client mode, the user id used in getTreatment call has to be supplied when the SDK factory is initialized, the line is shown below in file `./src/store.js`

```
 key: 'bob',
 ```
If the user id is changed, make sure to reflect the name in file ./src/App.js, in the line below, note bob is hardcoded in the Redux store path, replace it with the new user id.


``` html
 <h1> Treatments: {i} ({this.props.data.splitio.treatments[i].bob.treatm
 ```

