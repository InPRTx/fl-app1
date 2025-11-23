import 'package:fl_app1/router/app_router.dart';
import 'package:fl_app1/store/base_url_store.dart';
import 'package:fl_app1/store/local_time_store.dart';
import 'package:fl_app1/store/service/auth/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// 全局 ScaffoldMessenger key，用于在任何地方显示 SnackBar
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

// 全局路由器实例
final appRouter = AppRouter();

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
    appRouter.pushPath('/auth/login');
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
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('zh', 'CN'), Locale('en', 'US')],
      locale: const Locale('zh', 'CN'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
