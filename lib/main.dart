import 'package:fl_app1/store/base_url_store.dart';
import 'package:fl_app1/store/local_time_store.dart';
import 'package:fl_app1/store/service/auth/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'router/index.dart';

// 全局 ScaffoldMessenger key，用于在任何地方显示 SnackBar
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  Intl.defaultLocale = 'zh_CN';
  tz.initializeTimeZones();

  // Initialize BaseUrlStore to get saved base URL
  await BaseUrlStore().init();

  // Initialize LocalTimeStore to get saved timezone
  await LocalTimeStore().init();

  // Get saved timezone or use default Asia/Shanghai
  final String timeZoneName = LocalTimeStore().fixedTimeZone ?? 'Asia/Shanghai';

  try {
    final tz.Location location = tz.getLocation(timeZoneName);
    tz.setLocalLocation(location);
  } catch (e) {
    // If timezone is invalid, fallback to Asia/Shanghai
    tz.setLocalLocation(tz.getLocation('Asia/Shanghai'));
  }

  // Initialize auth store
  await AuthStore().init();

  // 设置令牌过期回调
  AuthStore().onTokenExpired = (String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: '关闭',
          textColor: Colors.white,
          onPressed: () {
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      ),
    );
  };

  // 设置跳转到登录页回调
  AuthStore().onNavigateToLogin = () {
    router.go('/auth/login');
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      routerConfig: router,
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('zh', 'CN'), Locale('en', 'US')],
      locale: const Locale('zh', 'CN'),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home is handled by GoRouter's '/' route
    );
  }
}
