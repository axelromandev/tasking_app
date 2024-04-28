const { onRequest } = require("firebase-functions/v2/https");

const express = require('express');
const app = express();

app.use(express.json());

app.post('/', (req, res) => {
  // Replace with your Android package identifier
  const bodyParams = new URLSearchParams(req.body).toString();

  // Replace with your Android package identifier
  const ANDROID_PACKAGE_IDENTIFIER = 'com.ingedevs.tasking';

  // Replace with your Android package identifier
  const redirect = `intent://callback?${bodyParams}#Intent;package=${ANDROID_PACKAGE_IDENTIFIER};scheme=signinwithapple;end`;

  // Log the redirect URL
  console.log(`Redirecting to ${redirect}`);

  // Redirect to the Android app
  res.redirect(307, redirect);
});

exports.callbacksSignInWithApple = onRequest(app);