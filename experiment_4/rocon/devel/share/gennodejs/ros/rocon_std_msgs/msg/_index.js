
"use strict";

let Float32Stamped = require('./Float32Stamped.js');
let Connection = require('./Connection.js');
let MasterInfo = require('./MasterInfo.js');
let ConnectionsList = require('./ConnectionsList.js');
let Icon = require('./Icon.js');
let ConnectionCacheSpin = require('./ConnectionCacheSpin.js');
let KeyValue = require('./KeyValue.js');
let StringArray = require('./StringArray.js');
let ConnectionsDiff = require('./ConnectionsDiff.js');
let Strings = require('./Strings.js');
let Remapping = require('./Remapping.js');
let StringsPairRequest = require('./StringsPairRequest.js');
let StringsPair = require('./StringsPair.js');
let StringsPairResponse = require('./StringsPairResponse.js');
let StringsRequest = require('./StringsRequest.js');
let StringsResponse = require('./StringsResponse.js');

module.exports = {
  Float32Stamped: Float32Stamped,
  Connection: Connection,
  MasterInfo: MasterInfo,
  ConnectionsList: ConnectionsList,
  Icon: Icon,
  ConnectionCacheSpin: ConnectionCacheSpin,
  KeyValue: KeyValue,
  StringArray: StringArray,
  ConnectionsDiff: ConnectionsDiff,
  Strings: Strings,
  Remapping: Remapping,
  StringsPairRequest: StringsPairRequest,
  StringsPair: StringsPair,
  StringsPairResponse: StringsPairResponse,
  StringsRequest: StringsRequest,
  StringsResponse: StringsResponse,
};
