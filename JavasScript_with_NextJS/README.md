# Example Next.js + Split on client and server-side
# Overview:
Basic Code to use Javascript Split SDK with React library and Next.js, the app has both Client side and Server side renderings, you can disable one or the other depending on business need.

On the server-side, the SDK is used to get a treatment.
On the client-side, the SDK is used to track events.

## Environment 

```
nuxt@2.15.8
next.js@13.0.5
react 16.12.0
```

## How to use:

Clone this repo, to the root folder and run the npm command below to download the dependencies:

```
npm install
```


 - Add your Split API keys:
   - Split API Key (Browser type) at `/pages/_app.js`
   ```
   authorizationKey: 'BROWSER API KEY',
   ```

   - Split API Key (SDK type) at `/server/getServerSideSplitClient.js`

   ```
   authorizationKey: 'SDK API KEY',
   ```

 - Update the name of your Split at `/constants.js`. The Server Side SDK will use the Split name in file ./constants.js under the **serverFEATURE** constant

 ```
export const serverFEATURE = 'test_split';

 ```
- The Client Side SDK will use the clientFEATURE constant:

```
export const clientFEATURE = "sample_feature";
```

 - Install and run the app:

```
$ npm run build
$ npm run start
```

 - Open `http://localhost:3000/` in your browser. The script will use load Split SDK on server side and Client (browser) side, and will show the treatments for both.

```
http://localhost:3000/

![image](https://user-images.githubusercontent.com/49971676/210458848-b564ac70-46dd-469a-a2eb-fd68cea0aef8.png)
