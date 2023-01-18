/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */
'use strict';

import React, { Component } from 'react'; // 1
import {
  StyleSheet,
  Text,
  TextInput,
  View,
  Button,
  ActivityIndicator,
  Image,
} from 'react-native';
import {
  createStackNavigator,
  createAppContainer
} from 'react-navigation';
import { SplitFactory } from '@splitsoftware/splitio';
const factory: SplitIO.ISDK = SplitFactory({ 
	core: {
		authorizationKey: 'SDK API KEY',
		key: 'react_native_guy'
	}
});
var SDKReady=false;    	
const client: SplitIO.IClient = factory.client();


type Props = {};
export default class ReactSDK extends Component<Props> { 
	constructor(props){
    	super(props);
		client.on(client.Event.SDK_READY, () => {
			SDKReady=true;
		  	console.log("SDK is Ready");
		}); 
  	}	
	static navigationOptions = {
  		title: 'Split SDK Sample',
	};


	GetSplitTreatment = () => {
		if (SDKReady)
		{
	  		const treatment: SplitIO.Treatment = client.getTreatment('sample_feature');
	  		console.log(treatment);
	  	};
  	};

	render() {
	  return (
	  	<View style={styles.container}>
		  	<Button
			    onPress={this.GetSplitTreatment}
			    color='#48BBEC'
			    title='Click To Generate Treatments'/>
	  	</View>
	  	);
	}
}
const styles = StyleSheet.create({
  description: {
    marginBottom: 20,
    fontSize: 18,
    textAlign: 'center',
    color: '#656565'
  },
  container: {
    padding: 30,
    marginTop: 65,
    alignItems: 'center'
  },
  flowRight: {
	  flexDirection: 'row',
	  alignItems: 'center',
	  alignSelf: 'stretch',
  },
	searchInput: {
	  height: 36,
	  padding: 4,
	  marginRight: 5,
	  flexGrow: 1,
	  fontSize: 18,
	  borderWidth: 1,
	  borderColor: '#48BBEC',
	  borderRadius: 8,
	  color: '#48BBEC',
	}
});
