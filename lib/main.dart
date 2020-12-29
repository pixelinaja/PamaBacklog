import 'dart:convert';
import 'dart:math';

import 'package:PamaBacklog/Global/NotificationHelper/NotificationHelper.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:PamaBacklog/Router/Router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'Logic/Connectivity/cubit/connectivity_cubit.dart';

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
  /// Intialize App Router
  static AppRouter _appRouter = AppRouter();

  /// Initialize Firebase Analytics
  FirebaseAnalytics analytics = FirebaseAnalytics();

  /// Initialize Firebase Messaging
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  /// Initialize Connectivity Cubit for Identifying User's Connectivity State
  final ConnectivityCubit connectivityCubit =
      ConnectivityCubit(connectivity: Connectivity());

  @override
  void initState() {
    super.initState();

    /// Add Windget Binding Observer, to observe app's state.
    WidgetsBinding.instance.addObserver(this);

    /// Initialize Flutter Local Notification
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    /// Initialize Flutter Local Notification Plugin
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: NotificationHelper.onSelectNotification);

    /// Configure Firebase Messaging Depending on the Current App's State.
    firebaseMessaging.configure(
      /// App is open and user is active.
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage called: $message');

        /// Show Local Notification when App is Foreground
        NotificationHelper.showNotification(
          Random().nextInt(100),
          message['notification']['title'],
          message['notification']['body'],
          json.encode(message['data']),
          flutterLocalNotificationsPlugin,
        );
      },

      /// App is on the background but not closed.
      onResume: (Map<String, dynamic> message) async {
        print('onResume called: $message');
        Fluttertoast.showToast(
            msg: message.toString(), toastLength: Toast.LENGTH_LONG);
      },

      /// App is killed.
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch called: $message');
        Fluttertoast.showToast(
            msg: message.toString(), toastLength: Toast.LENGTH_LONG);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => connectivityCubit)],
      child: MaterialApp(
        title: 'Pama Backlog',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorObservers: <NavigatorObserver>[
          FirebaseAnalyticsObserver(analytics: analytics)
        ],
        onGenerateRoute: _appRouter.generateRoute,
        initialRoute: RouteName.splashScreen,
      ),
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }
}
