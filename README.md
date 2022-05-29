# Zemoga

The application is developed according to the requested requirements.

The following additional libraries have been used:
* http: ^0.13.4
* shared_preferences: ^2.0.15

The IDE used was AndroidStudio BumBlebee 2021.1.1 Patch 3

The shared_preferences library was chosen to store posts locally, because it is a simple application, and there was no need to use databases like sqflite.

The source code is in the zemoga_mobile/lib folder.
* model: DTO files to process the services information.
* ApiService: Service that calls the Rest APIs and saves the results in the local memory of the device (Shared Preferences)
* constants: Configuration parameters, endpoints of the APIs used in the App.
* main: Main Screen
* posts: Screen where the list of Posts is displayed
* post_detail: Screen where the detail of the Selected Post is displayed

To run the application you just have to open it and follow these steps:

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/victorgt26/Zemoga.git
```

**Step 2:**

Go to project root (zemoga_mobile) and execute the following command in console to get the required dependencies:

```
flutter pub get
```

**Step 3:**

```
Open the project in Android Studio (zemoga_mobile)
```

**Step 4:**

```
Select android or IOS emulatorOpen the project in Android Studio
```

**Step 4:**

```
Run the app
```
![alt text](https://github.com/victorgt26/Zemoga/blob/main/Screen1.png?raw=true)
![alt text](https://github.com/victorgt26/Zemoga/blob/main/Screen2.png?raw=true)
