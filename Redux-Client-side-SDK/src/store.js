import { createStore, applyMiddleware, combineReducers } from 'redux';
import thunk from "redux-thunk";
import { splitReducer, initSplitSdk } from '@splitsoftware/splitio-redux';
import { getTreatments } from '@splitsoftware/splitio-redux';

const sdkBrowserConfig = {
  core: {
    authorizationKey: 'SDK browser API KEY',
    key: 'bob',
  }
};


const store = createStore(
	combineReducers({
	    splitio: splitReducer,
	}),
	applyMiddleware(thunk)
);

store.dispatch(initSplitSdk({ config: sdkBrowserConfig, onReady: onReadyCallback }));

function onReadyCallback() {
	store.dispatch(getTreatments({ splitNames: ['Default Split Name'] }))
}

export default store;