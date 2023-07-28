require('dotenv').config()
var createError = require("http-errors");
var express = require("express");
var path = require("path");
var cookieParser = require("cookie-parser");
var logger = require("morgan");
const { SplitFactory } = require("@splitsoftware/splitio");
import {SplitWrapper} from "./local-lib/split-wrapper/split_wrapper.js"


const splitSdkKey = process.env.SERVER_SDK_KEY;
const SplitSdk = new SplitWrapper(SplitFactory, splitSdkKey, false);

var app = express();

// view engine setup
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));

app.get("/", (req, res) => {
  let splitFlag = "sample_flag";
  let user = 'sampleUser'
  SplitSdk.defaultClient.ready().then(() => {
    let treatment = SplitSdk.getTreatment(user, splitFlag);
    res.render("index", {
      title: "Isomorphic Wrapper",
      flag: splitFlag,
      user: user,
      treatment: treatment,
      clientSDKkey: process.env.CLIENT_SDK_KEY
    });
  });
});

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get("env") === "development" ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render("error");
});

module.exports = app;
