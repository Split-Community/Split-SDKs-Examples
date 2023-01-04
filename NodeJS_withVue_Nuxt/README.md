## Overview

This is a basic example to use NodeJS Split SDK 10.18.0 or latest with Vue Framework and Nuxt Library using Server Side Rendering

## Environment
Nuxt 2.15.8 or later
Node 10.18.0 or later
Vue 2.6.12 or later

## Getting started
1. Clone the repo to your local environment.

2. Run the following command to install dependencies:


``` bash
# install dependencies
$ npm install # Or yarn install
```

3. The Split NodeJS SDK is loaded as a Vue plugin in /plugins/splitAPI.server.js and the file name contains "server" to force load the SDK only on server side.

4. To initialize the Split factory object as singleton (only once), we stored the factory object in Vue instance property, and then reuse the same property afterwards. Make sure to replace the 'SDK API Key' with a valid API Key type "Server-side".

``` javascript
import Vue from 'vue'
import { SplitFactory } from '@splitsoftware/splitio';

export default (context, inject) => {
    const factory = SplitFactory ({
      core: {
        authorization Key: 'SDK APIKEY'
},
});
 (inject('factory', Vue.prototype.$factory
}
```

5. The code below is located in store/index.js and is used to calculate the treatment. We use "client.ready()", which is a promise that the client object resolves when the SDK is ready and will reject if the timeout is reached.

Note: Be sure to replace the user key and split name in the example below:

``` javascript
import Vuex from 'vuex'
export const state = () => ({
  treatment: null
})
export const mutations = {
  SET_TREATMENT(state, treatment){
    state.treatment = treatment
  }
}
export const actions = {
  async nuxtServerInit({ commit }) {
    let client = this.$factory.client();
    await client.ready()
    let treatment  = client.getTreatment('john', 'sample_feature');
    commit('SET_TREATMENT', treatment);
  }
}

```
6. To run the sample app, do the following:

``` bash
# serve with hot reload at localhost:3000
$ npm run dev
```

7. Extras

``` bash
# build for production and launch server
$ npm run build
$ npm start
```
``` bash
# generate static project
$ npm run generate
```

For detailed explanation on how things work, checkout the [Nuxt.js docs](https://github.com/nuxt/nuxt.js).

