import React from 'react'
import App from 'next/app'
import { SplitFactory } from '@splitsoftware/splitio'
import { clientFEATURE } from '../constants'
var ctreatment = "";
var sdkReady = false;

class MyApp extends App {

  async componentDidMount() {

    const { userKey, splitName } = this.props.pageProps;

    // Init Split on client-side
    (function () {
      window.split = window.split ||
        SplitFactory({
          core: {
            authorizationKey: 'BROWSER API KEY',
            key: userKey,
          },
          debug: true,
        });
    })();

  // This branch runs only on the client-side
    const splitClient = window.split.client()
    await splitClient.ready()
    sdkReady = true;
    ctreatment  = splitClient.getTreatment(clientFEATURE);
    console.log("client treatment: "+ctreatment);
    this.setState({          
        ctreatment: this.props.ctreatment
    });
  }

  render() {
    const { Component, pageProps } = this.props;
    return (<Component {...pageProps } {...{clientTreatment: ctreatment, isReady: sdkReady}} />);
  }
}

MyApp.getInitialProps = async function (appContext) {
  const userKey = 'client-key';
  return { pageProps: { splitName: clientFEATURE, userKey } }
};


export default MyApp;