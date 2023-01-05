import { SplitFactory } from '@splitsoftware/splitio'

//var splitClient = undefined
//if (typeof splitClient == "undefined") {
	console.log("Creating new Split Factory on server side")
	const splitConfig = {
	  core: {
	    authorizationKey: 'SDK API KEY'
	  },
	  debug: true
	}
	const splitFactory = SplitFactory(splitConfig)
	var splitClient = splitFactory.client()
//}
export default splitClient
