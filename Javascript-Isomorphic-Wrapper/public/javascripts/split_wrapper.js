const isNode = (function () {
    var isNode = false;
    if (typeof process === "object") {
      if (typeof process.versions === "object") {
        if (typeof process.versions.node !== "undefined") {
          isNode = true;
        }
      }
    }
    return isNode;
  })();
  
  export class SplitWrapper {
    constructor(SplitFactory, authKey, debug, attributes) {
      if (authKey == "" || authKey == null || typeof authKey == "undefined") {
        console.log("Error: authKey not provided");
        return;
      }
      if (typeof attributes !== "undefined" && isNode) {
        console.warn(
          "Attributes passed but running on server side - these will be used but this might not be intended behavior"
        );
      }
  
      this.splitSettings = {
        core: {
          authorizationKey: authKey,
          // key represents your internal user id, or the account id that
          key: "key", // here in both server and client side, though it doesn't do anything when on the server side
        },
        debug: !!debug,
      };
      this.keys = [];
      this.clients = [];
      this.trafficTypeToKeyMap = {};
      this.splitToTrafficTypeMap = {};
      this.factory = SplitFactory(this.splitSettings);
      this.initDefaultClient();
      if (!isNode) {
        this.initTrafficTypeMap();
        this.getTreatment = this.getTreatmentClientSide;
        this.track = this.trackClientSide;
      } else {
        this.getTreatment = this.getTreatmentServerSide;
        this.track = this.trackServerSide;
      }
    }
  
    setAttribute(key, value) {
      this.attributes[key] = value;
    }
  
    getAttribute(key) {
      return this.attributes[key];
    }
  
    clearAllAttributes() {
      this.attributes = {};
    }
  
    async initDefaultClient() {
      console.log("setting default client");
      this.defaultClient = this.factory.client();
      await this.defaultClient.ready();
      return;
    }
  
    async initTrafficTypeMap() {
      self = this;
      let manager = this.factory.manager();
      await manager.ready();
      let splits = manager.splits();
      splits.forEach(function (v, i, a) {
        self.splitToTrafficTypeMap[v.name] = v.trafficType;
      });
    }
  
    async getReady(key, trafficType) {
      if (key == "" || typeof key == "undefined") {
        console.error("Error: key not defined");
        return;
      } else if (isNode) {
        console.warn(
          "getReady should not be called on the server side while running in Node"
        );
        return;
      } else if (this.keys.indexOf(key) !== -1) {
        // key already tracked
        return;
      } else {
        let newClient = this.factory.client(key);
        await newClient.ready();
        this.keys.push(key);
        this.trafficTypeToKeyMap[trafficType] = key;
        this.clients.push(newClient);
        return;
      }
    }
  
    getTreatmentClientSide(splitName, config) {
      if (isNode) {
        console.error("not meant to be called server side");
      }
      let client;
      let trafficType = this.splitToTrafficTypeMap[splitName];
      let element = Object.keys(this.trafficTypeToKeyMap).indexOf(trafficType);
      let key = Object.values(this.trafficTypeToKeyMap)[element];
      if (typeof trafficType == "undefined") {
        console.error("Split does not exist: " + splitName);
        return;
      } else if (element == -1) {
        console.error("Client does not exist for trafficType: " + trafficType);
        return;
      } else {
        client = this.clients[element];
      }
  
      if (typeof config != "undefined" && !!config) {
        return client.getTreatmentWithConfig(splitName, this.attributes)
        
      } else {
        return client.getTreatment(splitName, this.attributes)
      
      }
    }
  
    getTreatmentServerSide(key, splitName, config) {
      if (!isNode) {
        console.error("not meant to be called client side");
      }
      let client = this.defaultClient;
      if (typeof config != "undefined" && !!config) {
        return  client.getTreatmentWithConfig(key, splitName, this.attributes)
      } else {
        return client.getTreatment(key, splitName, this.attributes)
  
      }
    }
  
    trackClientSide(eventType, value, properties) {
      if (isNode) {
        console.error("not meant to be called server side");
      }
      self = this;
      let trackedEvents = {};
      this.clients.forEach(function (client, index, array) {
        let key = Object.keys(self.trafficTypeToKeyMap)[index];
        let success = client.track(key, eventType, parseFloat(value), properties);
        if (!success) {
          console.error(eventType + " event not tracked for key: " + key);
        } else {
          trackedEvents[key] = { eventType: eventType, value: value };
        }
      });
      return trackedEvents;
    }
    
    trackServerSide(key, eventType, value, properties) {
      if (!isNode) {
        console.error("not meant to be called client side");
      }
  
      let success = client.track(key, eventType, parseFloat(value), properties);
      if (!success) {
        console.error(eventType + " event not tracked for key: " + key);
      }
  
      return success;
    }
  
    destroyAll() {
      this.clients.forEach(async function (client, index, array) {
        await client.destroy();
        console.log("Client Destroyed!");
      });
      console.log("all clients destroyed");
    }
  }
  