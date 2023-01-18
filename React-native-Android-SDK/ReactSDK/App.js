/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */
'use strict';

import React, { Component } from 'react'; // 1
import {Platform, StyleSheet, Text, View, Button} from 'react-native';
import {
  createStackNavigator,
  createAppContainer
} from 'react-navigation';
import ReactSDK from './ReactSDK'


const RootStack = createStackNavigator({
	  Home: { screen: ReactSDK },
});
const App = createAppContainer(RootStack);
export default App;

