# Flutter Firebase Auth

<img src='example.gif' width=200>

### Features

- ✅ Start screen
- ✅ Login
- ✅ Register
- ✅ Recover password
- ✅ Google provider auth
- ✅ Email verification

### What's inside

- Flutter
- Firebase

### Configure

1 - run flutter fire

```
flutterfire configure
```

2 - remove keys from `firebase_options.dart` and set in .env


`.env`

```
ANDROID_apiKey=KEY,
ANDROID_appId=KEY,
ANDROID_messagingSenderId=KEY,
ANDROID_projectId=KEY,
ANDROID_storageBucket=KEY,

IOS_apiKey=KEY,
IOS_appId=KEY,
IOS_messagingSenderId=KEY,
IOS_projectId=KEY,
IOS_storageBucket=KEY,
IOS_iosClientId=KEY,
IOS_iosBundleId=KEY,
```

`firebase_options.dart`


```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

...

static FirebaseOptions android = FirebaseOptions(
  apiKey: dotenv.get('ANDROID_apiKey'),
  appId: dotenv.get('ANDROID_appId'),
  messagingSenderId: dotenv.get('ANDROID_messagingSenderId'),
  projectId: dotenv.get('ANDROID_projectId'),
  storageBucket: dotenv.get('ANDROID_storageBucket'),
);

static FirebaseOptions ios = FirebaseOptions(
  apiKey: dotenv.get('IOS_apiKey'),
  appId: dotenv.get('IOS_appId'),
  messagingSenderId: dotenv.get('IOS_messagingSenderId'),
  projectId: dotenv.get('IOS_projectId'),
  storageBucket: dotenv.get('IOS_storageBucket'),
  iosClientId: dotenv.get('IOS_iosClientId'),
  iosBundleId: dotenv.get('IOS_iosBundleId'),
);
```

---
Carlos Costa 💥 2022
