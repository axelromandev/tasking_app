const { onRequest } = require("firebase-functions/v2/https");

const express = require('express');
const app = express();

app.use(express.json());

app.post('/', (req, res) => {
  // Replace with your Android package identifier
  const bodyParams = new URLSearchParams(req.body).toString();

  // Replace with your Android package identifier
  const ANDROID_PACKAGE_IDENTIFIER = process.env.ANDROID_PACKAGE_IDENTIFIER;

  // Replace with your Android package identifier
  const redirect = `intent://callback?${bodyParams}#Intent;package=${ANDROID_PACKAGE_IDENTIFIER};scheme=signinwithapple;end`;

  // Redirect to the Android app
  res.redirect(307, redirect);
});

exports.callbacksSignInWithApple = onRequest(app);