import 'dart:convert';
import 'dart:math';

import 'package:PamaBacklog/Logic/Admin/AdminSelectOrder/cubit/admin_select_order_cubit.dart';
import 'package:PamaBacklog/Logic/Admin/AdminSubmitEstimasi/bloc/admin_submit_estimasi_bloc.dart';
import 'package:PamaBacklog/Logic/Admin/AdminSubmitWR/bloc/admin_submit_wr_bloc.dart';
import 'package:PamaBacklog/Logic/Firestore/CN/bloc/cn_bloc.dart';
import 'package:PamaBacklog/Logic/GL/GLSelectOrder/cubit/gl_select_order_cubit.dart';
import 'package:PamaBacklog/Logic/GL/GLSelectTableOrder/cubit/gl_select_table_order_cubit.dart';
import 'package:PamaBacklog/Logic/GL/GLSwitchTable/cubit/gl_switch_table_cubit.dart';
import 'package:PamaBacklog/Logic/Mekanik/AddBacklog/bloc/mekanikadd_bloc.dart';
import 'package:PamaBacklog/Service/AuthRepository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';

import 'package:PamaBacklog/Global/NotificationHelper/NotificationHelper.dart';
import 'Global/DesignSize/DesignSize.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:PamaBacklog/Router/Router.dart';

import 'Logic/Auth/bloc/auth_bloc.dart';
import 'Logic/Connectivity/cubit/connectivity_cubit.dart';
import 'Logic/FCM/bloc/sendnotification_bloc.dart';
import 'Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'Logic/GL/GLApproveOrder/bloc/gl_approve_order_bloc.dart';
import 'Logic/Mekanik/Home/MekanikTable/bloc/mekaniktable_bloc.dart';
import 'Logic/Mekanik/UpdateLaporan/bloc/MekanikUpdateLaporan_bloc.dart';
import 'Service/FCMRepository.dart';
import 'Service/OrderRepository.dart';

/// Background message handler
Future<Map<String, dynamic>> _firebaseMessagingBackgroundHandler(
    Map<String, dynamic> message) async {
  print("Handling a background message: $message");
  return message;
}

/// Select Notification on Local Notification
final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

/// Navigation Key
final _navKey = GlobalKey<NavigatorState>();

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

  /// Initialize Firebase Messaging
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  /// Initialize Flutter Local Notification
  final initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize Flutter Local Notification Plugin
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (payload) async {
    selectNotificationSubject.add(payload);
  });

  runApp(MyApp(
    firebaseMessaging: firebaseMessaging,
    flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
  ));
}

class MyApp extends StatefulWidget {
  final FirebaseMessaging firebaseMessaging;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  MyApp({
    Key key,
    this.firebaseMessaging,
    this.flutterLocalNotificationsPlugin,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  /// Intialize App Router
  static AppRouter _appRouter = AppRouter();

  /// Initialize Firebase Analytics
  FirebaseAnalytics analytics = FirebaseAnalytics();

  /// Initialize Connectivity Cubit for Identifying User's Connectivity State
  final ConnectivityCubit connectivityCubit =
      ConnectivityCubit(connectivity: Connectivity());

  /// Initialize Authentication Bloc
  final AuthBloc authBloc = AuthBloc(authRepository: AuthService());

  /// Get Firebase Messaging object
  FirebaseMessaging get firebaseMessaging => widget.firebaseMessaging;

  /// Get Flutter Local Notification Plugin
  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      widget.flutterLocalNotificationsPlugin;

  /// Order Repository
  OrderRepository _orderRepository = OrderService();

  /// FCM Repository
  FCMService _fcmService = FCMService();

  @override
  void initState() {
    super.initState();

    /// Configure local notification select
    _configureSelectNotificationSubject();

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

      /// Handle On Background Message
      onBackgroundMessage: _firebaseMessagingBackgroundHandler,
    );

    /// Add Windget Binding Observer, to observe app's state.
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => connectivityCubit),
        BlocProvider(create: (context) => authBloc),
        BlocProvider(
          create: (context) => SendNotificationBloc(
            fcmRepository: _fcmService,
          ),
        ),
        BlocProvider(
          create: (context) => MekanikTableBloc(
            orderRepository: _orderRepository,
          ),
        ),
        BlocProvider(create: (context) => MekanikUpdateLaporanBloc()),
        BlocProvider(
          create: (context) => MekanikAddBloc(
            mekanikTableBloc: context.read<MekanikTableBloc>(),
            orderRepository: _orderRepository,
            fcmRepository: _fcmService,
          ),
        ),
        BlocProvider(create: (context) => OrdersBloc()),
        BlocProvider(create: (context) => CNBloc()),
        BlocProvider(create: (context) => GLSelectOrderCubit()),
        BlocProvider(create: (context) => GLSelectTableOrderCubit()),
        BlocProvider(create: (context) => GLSwitchTableCubit()),
        BlocProvider(
          create: (context) => GLApproveOrderBloc(
            fcmRepository: _fcmService,
            orderRepository: _orderRepository,
          ),
        ),
        BlocProvider(create: (context) => AdminSelectOrderCubit()),
        BlocProvider(
          create: (context) => AdminSubmitEstimasiBloc(
            fcmRepository: _fcmService,
            orderRepository: _orderRepository,
          ),
        ),
        BlocProvider(
          create: (context) => AdminSubmitWrBloc(
            fcmRepository: _fcmService,
            orderRepository: _orderRepository,
          ),
        ),
      ],
      child: ScreenUtilInit(
        allowFontScaling: true,
        designSize: Size(DesignSize.width, DesignSize.height),
        child: MaterialApp(
          title: 'Pama Backlog',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          navigatorKey: _navKey,
          navigatorObservers: <NavigatorObserver>[
            FirebaseAnalyticsObserver(analytics: analytics)
          ],
          onGenerateRoute: _appRouter.generateRoute,
          initialRoute: RouteName.splashScreen,
        ),
      ),
    );
  }

  /// Navigate to a screen when user tap on a notification
  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      await _navKey.currentState.pushNamed(RouteName.homeScreen);
    });
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    authBloc.close();
    super.dispose();
  }
}
