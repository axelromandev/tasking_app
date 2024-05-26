# Tasking Manager App

Tasking is a task manager application that allows you to create tasks and
organize them in lists. The organize them in lists. The application is designed to be simple and easy to
use.

## Tech Stack

**Client:** Flutter, Riverpod, Isar Database

<!-- **Server:** Firebase -->

## Configuration FVM and Flutter SDK

First you need to install the FVM to manage the Flutter SDK version, follow the instructions
on the official website: https://fvm.app/documentation/getting-started

After installing the FVM, run the following command to install the Flutter SDK version:

```bash
  fvm install
```

<!-- ## Configuration Firebase

Install the FlutterFire CLI to configure Firebase for the project, follow the
instructions on the official website: https://firebase.google.com/docs/flutter/setup

After installing the FlutterFire CLI, run the following command to configure Firebase for the project:

```bash
  flutterfire configure -p firebase-project-id
``` -->

## Run Locally

First you need to install the dependencies:

```bash
  fvm flutter pub get
```

Need to generate the database files:

```bash
  fvm dart run build_runner build
```

## Create Icon Launcher

```bash
  fvm dart run icons_launcher:create --path
```
