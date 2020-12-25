import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  /// Call this function to make sure the app is initialized. Otherwise, we can't access native code
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Hydrated Bloc to Store some Persistent States.
  HydratedBloc.storage = await HydratedStorage.build(
    /// Use Application Documents Directory to Store the States.
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  /// Initialize Firebase Core
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  /// Initialize Firebase Messaging
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  /// Initialize Firebase Analytics
  FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  void initState() {
    super.initState();

    /// Add Windget Binding Observer, to observe app's state.
    WidgetsBinding.instance.addObserver(this);

    /// Configure Firebase Messaging Depending on the Current App's State.
    firebaseMessaging.configure(
      /// App is open and user is active.
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage called: $message');
      },

      /// App is on the background but not closed.
      onResume: (Map<String, dynamic> message) async {
        print('onResume called: $message');
      },

      /// App is killed.
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch called: $message');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pama Backlog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Container(
          child: Center(
            child: Text("Pama Backlog"),
          ),
        ),
      ),
    );
  }
}
