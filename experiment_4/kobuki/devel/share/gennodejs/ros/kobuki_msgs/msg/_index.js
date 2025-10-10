
"use strict";

let DigitalInputEvent = require('./DigitalInputEvent.js');
let KeyboardInput = require('./KeyboardInput.js');
let MotorPower = require('./MotorPower.js');
let Sound = require('./Sound.js');
let ExternalPower = require('./ExternalPower.js');
let CliffEvent = require('./CliffEvent.js');
let Led = require('./Led.js');
let DockInfraRed = require('./DockInfraRed.js');
let PowerSystemEvent = require('./PowerSystemEvent.js');
let ButtonEvent = require('./ButtonEvent.js');
let SensorState = require('./SensorState.js');
let WheelDropEvent = require('./WheelDropEvent.js');
let BumperEvent = require('./BumperEvent.js');
let VersionInfo = require('./VersionInfo.js');
let ScanAngle = require('./ScanAngle.js');
let RobotStateEvent = require('./RobotStateEvent.js');
let ControllerInfo = require('./ControllerInfo.js');
let DigitalOutput = require('./DigitalOutput.js');
let AutoDockingGoal = require('./AutoDockingGoal.js');
let AutoDockingResult = require('./AutoDockingResult.js');
let AutoDockingActionFeedback = require('./AutoDockingActionFeedback.js');
let AutoDockingActionResult = require('./AutoDockingActionResult.js');
let AutoDockingFeedback = require('./AutoDockingFeedback.js');
let AutoDockingAction = require('./AutoDockingAction.js');
let AutoDockingActionGoal = require('./AutoDockingActionGoal.js');

module.exports = {
  DigitalInputEvent: DigitalInputEvent,
  KeyboardInput: KeyboardInput,
  MotorPower: MotorPower,
  Sound: Sound,
  ExternalPower: ExternalPower,
  CliffEvent: CliffEvent,
  Led: Led,
  DockInfraRed: DockInfraRed,
  PowerSystemEvent: PowerSystemEvent,
  ButtonEvent: ButtonEvent,
  SensorState: SensorState,
  WheelDropEvent: WheelDropEvent,
  BumperEvent: BumperEvent,
  VersionInfo: VersionInfo,
  ScanAngle: ScanAngle,
  RobotStateEvent: RobotStateEvent,
  ControllerInfo: ControllerInfo,
  DigitalOutput: DigitalOutput,
  AutoDockingGoal: AutoDockingGoal,
  AutoDockingResult: AutoDockingResult,
  AutoDockingActionFeedback: AutoDockingActionFeedback,
  AutoDockingActionResult: AutoDockingActionResult,
  AutoDockingFeedback: AutoDockingFeedback,
  AutoDockingAction: AutoDockingAction,
  AutoDockingActionGoal: AutoDockingActionGoal,
};
