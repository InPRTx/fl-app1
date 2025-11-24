// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AuthLoginPage]
class AuthLoginRoute extends PageRouteInfo<void> {
  const AuthLoginRoute({List<PageRouteInfo>? children})
    : super(AuthLoginRoute.name, initialChildren: children);

  static const String name = 'AuthLoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthLoginPage();
    },
  );
}

/// generated route for
/// [AuthSimpleLoginPage]
class AuthSimpleLoginRoute extends PageRouteInfo<void> {
  const AuthSimpleLoginRoute({List<PageRouteInfo>? children})
    : super(AuthSimpleLoginRoute.name, initialChildren: children);

  static const String name = 'AuthSimpleLoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthSimpleLoginPage();
    },
  );
}

/// generated route for
/// [DebugVersionPage]
class DebugVersionRoute extends PageRouteInfo<void> {
  const DebugVersionRoute({List<PageRouteInfo>? children})
    : super(DebugVersionRoute.name, initialChildren: children);

  static const String name = 'DebugVersionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DebugVersionPage();
    },
  );
}

/// generated route for
/// [LowAdminHomePage]
class LowAdminHomeRoute extends PageRouteInfo<void> {
  const LowAdminHomeRoute({List<PageRouteInfo>? children})
    : super(LowAdminHomeRoute.name, initialChildren: children);

  static const String name = 'LowAdminHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LowAdminHomePage();
    },
  );
}

/// generated route for
/// [LowAdminOldServiceShopListPage]
class LowAdminOldServiceShopListRoute extends PageRouteInfo<void> {
  const LowAdminOldServiceShopListRoute({List<PageRouteInfo>? children})
    : super(LowAdminOldServiceShopListRoute.name, initialChildren: children);

  static const String name = 'LowAdminOldServiceShopListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LowAdminOldServiceShopListPage();
    },
  );
}

/// generated route for
/// [LowAdminSsNodePage]
class LowAdminSsNodeRoute extends PageRouteInfo<void> {
  const LowAdminSsNodeRoute({List<PageRouteInfo>? children})
    : super(LowAdminSsNodeRoute.name, initialChildren: children);

  static const String name = 'LowAdminSsNodeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LowAdminSsNodePage();
    },
  );
}

/// generated route for
/// [LowAdminTicketDetailPage]
class LowAdminTicketDetailRoute
    extends PageRouteInfo<LowAdminTicketDetailRouteArgs> {
  LowAdminTicketDetailRoute({
    Key? key,
    required int ticketId,
    List<PageRouteInfo>? children,
  }) : super(
         LowAdminTicketDetailRoute.name,
         args: LowAdminTicketDetailRouteArgs(key: key, ticketId: ticketId),
         rawPathParams: {'id': ticketId},
         initialChildren: children,
       );

  static const String name = 'LowAdminTicketDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<LowAdminTicketDetailRouteArgs>(
        orElse: () =>
            LowAdminTicketDetailRouteArgs(ticketId: pathParams.getInt('id')),
      );
      return LowAdminTicketDetailPage(key: args.key, ticketId: args.ticketId);
    },
  );
}

class LowAdminTicketDetailRouteArgs {
  const LowAdminTicketDetailRouteArgs({this.key, required this.ticketId});

  final Key? key;

  final int ticketId;

  @override
  String toString() {
    return 'LowAdminTicketDetailRouteArgs{key: $key, ticketId: $ticketId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LowAdminTicketDetailRouteArgs) return false;
    return key == other.key && ticketId == other.ticketId;
  }

  @override
  int get hashCode => key.hashCode ^ ticketId.hashCode;
}

/// generated route for
/// [LowAdminTicketListPage]
class LowAdminTicketListRoute extends PageRouteInfo<void> {
  const LowAdminTicketListRoute({List<PageRouteInfo>? children})
    : super(LowAdminTicketListRoute.name, initialChildren: children);

  static const String name = 'LowAdminTicketListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LowAdminTicketListPage();
    },
  );
}

/// generated route for
/// [LowAdminUserBoughtListPage]
class LowAdminUserBoughtListRoute
    extends PageRouteInfo<LowAdminUserBoughtListRouteArgs> {
  LowAdminUserBoughtListRoute({
    Key? key,
    String? queryParam,
    List<PageRouteInfo>? children,
  }) : super(
         LowAdminUserBoughtListRoute.name,
         args: LowAdminUserBoughtListRouteArgs(
           key: key,
           queryParam: queryParam,
         ),
         rawQueryParams: {'q': queryParam},
         initialChildren: children,
       );

  static const String name = 'LowAdminUserBoughtListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<LowAdminUserBoughtListRouteArgs>(
        orElse: () => LowAdminUserBoughtListRouteArgs(
          queryParam: queryParams.optString('q'),
        ),
      );
      return LowAdminUserBoughtListPage(
        key: args.key,
        queryParam: args.queryParam,
      );
    },
  );
}

class LowAdminUserBoughtListRouteArgs {
  const LowAdminUserBoughtListRouteArgs({this.key, this.queryParam});

  final Key? key;

  final String? queryParam;

  @override
  String toString() {
    return 'LowAdminUserBoughtListRouteArgs{key: $key, queryParam: $queryParam}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LowAdminUserBoughtListRouteArgs) return false;
    return key == other.key && queryParam == other.queryParam;
  }

  @override
  int get hashCode => key.hashCode ^ queryParam.hashCode;
}

/// generated route for
/// [LowAdminUserDetailPage]
class LowAdminUserDetailRoute
    extends PageRouteInfo<LowAdminUserDetailRouteArgs> {
  LowAdminUserDetailRoute({
    Key? key,
    required int userId,
    List<PageRouteInfo>? children,
  }) : super(
         LowAdminUserDetailRoute.name,
         args: LowAdminUserDetailRouteArgs(key: key, userId: userId),
         rawPathParams: {'id': userId},
         initialChildren: children,
       );

  static const String name = 'LowAdminUserDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<LowAdminUserDetailRouteArgs>(
        orElse: () =>
            LowAdminUserDetailRouteArgs(userId: pathParams.getInt('id')),
      );
      return LowAdminUserDetailPage(key: args.key, userId: args.userId);
    },
  );
}

class LowAdminUserDetailRouteArgs {
  const LowAdminUserDetailRouteArgs({this.key, required this.userId});

  final Key? key;

  final int userId;

  @override
  String toString() {
    return 'LowAdminUserDetailRouteArgs{key: $key, userId: $userId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LowAdminUserDetailRouteArgs) return false;
    return key == other.key && userId == other.userId;
  }

  @override
  int get hashCode => key.hashCode ^ userId.hashCode;
}

/// generated route for
/// [LowAdminUserPayListPage]
class LowAdminUserPayListRoute
    extends PageRouteInfo<LowAdminUserPayListRouteArgs> {
  LowAdminUserPayListRoute({
    Key? key,
    String? queryParam,
    List<PageRouteInfo>? children,
  }) : super(
         LowAdminUserPayListRoute.name,
         args: LowAdminUserPayListRouteArgs(key: key, queryParam: queryParam),
         rawQueryParams: {'q': queryParam},
         initialChildren: children,
       );

  static const String name = 'LowAdminUserPayListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<LowAdminUserPayListRouteArgs>(
        orElse: () => LowAdminUserPayListRouteArgs(
          queryParam: queryParams.optString('q'),
        ),
      );
      return LowAdminUserPayListPage(
        key: args.key,
        queryParam: args.queryParam,
      );
    },
  );
}

class LowAdminUserPayListRouteArgs {
  const LowAdminUserPayListRouteArgs({this.key, this.queryParam});

  final Key? key;

  final String? queryParam;

  @override
  String toString() {
    return 'LowAdminUserPayListRouteArgs{key: $key, queryParam: $queryParam}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LowAdminUserPayListRouteArgs) return false;
    return key == other.key && queryParam == other.queryParam;
  }

  @override
  int get hashCode => key.hashCode ^ queryParam.hashCode;
}

/// generated route for
/// [LowAdminUsersListPage]
class LowAdminUsersListRoute extends PageRouteInfo<void> {
  const LowAdminUsersListRoute({List<PageRouteInfo>? children})
    : super(LowAdminUsersListRoute.name, initialChildren: children);

  static const String name = 'LowAdminUsersListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LowAdminUsersListPage();
    },
  );
}

/// generated route for
/// [LowAdminWrapperPage]
class LowAdminWrapperRoute extends PageRouteInfo<void> {
  const LowAdminWrapperRoute({List<PageRouteInfo>? children})
    : super(LowAdminWrapperRoute.name, initialChildren: children);

  static const String name = 'LowAdminWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LowAdminWrapperPage();
    },
  );
}

/// generated route for
/// [MainWrapperPage]
class MainWrapperRoute extends PageRouteInfo<void> {
  const MainWrapperRoute({List<PageRouteInfo>? children})
    : super(MainWrapperRoute.name, initialChildren: children);

  static const String name = 'MainWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainWrapperPage();
    },
  );
}

/// generated route for
/// [MyHomePage]
class MyHomeRoute extends PageRouteInfo<MyHomeRouteArgs> {
  MyHomeRoute({
    Key? key,
    String title = 'Flutter Demo Home Page',
    List<PageRouteInfo>? children,
  }) : super(
         MyHomeRoute.name,
         args: MyHomeRouteArgs(key: key, title: title),
         initialChildren: children,
       );

  static const String name = 'MyHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MyHomeRouteArgs>(
        orElse: () => const MyHomeRouteArgs(),
      );
      return MyHomePage(key: args.key, title: args.title);
    },
  );
}

class MyHomeRouteArgs {
  const MyHomeRouteArgs({this.key, this.title = 'Flutter Demo Home Page'});

  final Key? key;

  final String title;

  @override
  String toString() {
    return 'MyHomeRouteArgs{key: $key, title: $title}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MyHomeRouteArgs) return false;
    return key == other.key && title == other.title;
  }

  @override
  int get hashCode => key.hashCode ^ title.hashCode;
}

/// generated route for
/// [SystemDebugBaseUrlPage]
class SystemDebugBaseUrlRoute extends PageRouteInfo<void> {
  const SystemDebugBaseUrlRoute({List<PageRouteInfo>? children})
    : super(SystemDebugBaseUrlRoute.name, initialChildren: children);

  static const String name = 'SystemDebugBaseUrlRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SystemDebugBaseUrlPage();
    },
  );
}

/// generated route for
/// [SystemDebugJwtTokenPage]
class SystemDebugJwtTokenRoute extends PageRouteInfo<void> {
  const SystemDebugJwtTokenRoute({List<PageRouteInfo>? children})
    : super(SystemDebugJwtTokenRoute.name, initialChildren: children);

  static const String name = 'SystemDebugJwtTokenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SystemDebugJwtTokenPage();
    },
  );
}

/// generated route for
/// [SystemDebugPage]
class SystemDebugRoute extends PageRouteInfo<void> {
  const SystemDebugRoute({List<PageRouteInfo>? children})
    : super(SystemDebugRoute.name, initialChildren: children);

  static const String name = 'SystemDebugRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SystemDebugPage();
    },
  );
}

/// generated route for
/// [SystemDebugViewTimezonePage]
class SystemDebugViewTimezoneRoute extends PageRouteInfo<void> {
  const SystemDebugViewTimezoneRoute({List<PageRouteInfo>? children})
    : super(SystemDebugViewTimezoneRoute.name, initialChildren: children);

  static const String name = 'SystemDebugViewTimezoneRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SystemDebugViewTimezonePage();
    },
  );
}

/// generated route for
/// [SystemLocalTimePage]
class SystemLocalTimeRoute extends PageRouteInfo<void> {
  const SystemLocalTimeRoute({List<PageRouteInfo>? children})
    : super(SystemLocalTimeRoute.name, initialChildren: children);

  static const String name = 'SystemLocalTimeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SystemLocalTimePage();
    },
  );
}

/// generated route for
/// [SystemSettingsPage]
class SystemSettingsRoute extends PageRouteInfo<void> {
  const SystemSettingsRoute({List<PageRouteInfo>? children})
    : super(SystemSettingsRoute.name, initialChildren: children);

  static const String name = 'SystemSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SystemSettingsPage();
    },
  );
}

/// generated route for
/// [UserDashboardPage]
class UserDashboardRoute extends PageRouteInfo<void> {
  const UserDashboardRoute({List<PageRouteInfo>? children})
    : super(UserDashboardRoute.name, initialChildren: children);

  static const String name = 'UserDashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserDashboardPage();
    },
  );
}

/// generated route for
/// [UserWrapperPage]
class UserWrapperRoute extends PageRouteInfo<void> {
  const UserWrapperRoute({List<PageRouteInfo>? children})
    : super(UserWrapperRoute.name, initialChildren: children);

  static const String name = 'UserWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserWrapperPage();
    },
  );
}
