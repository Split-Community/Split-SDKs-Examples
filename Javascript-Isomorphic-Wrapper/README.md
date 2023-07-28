# isomorphic_js_wrapper_demo


![image](https://github.com/kleinjoshuaa/isomorphic_js_wrapper_demo/assets/1207274/0aa924f7-d5d7-4d50-a22b-f84c4085c424)

In this case we are showing a nifty property of the Split JavaScript SDK. It is isomorphic. We are evaluating flags on both the server side and the client side using the same SDK Wrapper. 

To do this yourself, you will need to create a `.env` file at the root directory and put in variables `SERVER_SDK_KEY` and `CLIENT_SDK_KEY`. 

You will also need to set up a feature flag and a user id - those will be used by both the server side evaluation and also passed automatically into the client side evaluation. 

![image](https://github.com/kleinjoshuaa/isomorphic_js_wrapper_demo/assets/1207274/1d72666e-c591-4388-9469-b332635423a0)

Lastly, to run this you will need to run `npm install` and then `npm start` and it will serve the sample code on localhost port 3000.

The SDK Wrapper is an extension of the wrapper developed for the [Associator](https://github.com/kleinjoshuaa/associator/) and has a lot of features to handle multiple traffic types and associations on the client side. 


The constructor function for the wrapper requires that you pass in the Split Factory object given to you by the Splitio library on your platform of choice. This means the usage of this wrapper is independant from your bundling approach - you can use the cdn, npm, or any other way you prefer to bundle the SDK as long as the `SplitFactory` or `splitio` object is exposed. 

`attributes` can also be passed in and they will always be passed in when calling `getTreatment`. 

```javascript
constructor(SplitFactory, authKey, debug, attributes) {
```

Take a peek and enjoy! :D
