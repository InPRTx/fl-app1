import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class SystemDebugViewTimezonePage extends StatefulWidget {
  const SystemDebugViewTimezonePage({super.key});

  @override
  State<SystemDebugViewTimezonePage> createState() =>
      _SystemDebugViewTimezonePageState();
}

class _SystemDebugViewTimezonePageState
    extends State<SystemDebugViewTimezonePage> {
  late Stream<DateTime> _timeStream;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  final List<Map<String, String>> _timezones = [
    {'name': '本地时区', 'location': 'local'},
    {'name': '东京 (Asia/Tokyo)', 'location': 'Asia/Tokyo'},
    {'name': '纽约 (America/New_York)', 'location': 'America/New_York'},
    {'name': '伦敦 (Europe/London)', 'location': 'Europe/London'},
    {'name': '巴黎 (Europe/Paris)', 'location': 'Europe/Paris'},
    {'name': '悉尼 (Australia/Sydney)', 'location': 'Australia/Sydney'},
    {'name': '上海 (Asia/Shanghai)', 'location': 'Asia/Shanghai'},
    {'name': '洛杉矶 (America/Los_Angeles)', 'location': 'America/Los_Angeles'},
    {'name': '新加坡 (Asia/Singapore)', 'location': 'Asia/Singapore'},
    {'name': '迪拜 (Asia/Dubai)', 'location': 'Asia/Dubai'},
  ];

  @override
  void initState() {
    super.initState();
    _timeStream = Stream.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now(),
    );
  }

  tz.TZDateTime _getTimezoneTime(String location) {
    if (location == 'local') {
      return tz.TZDateTime.now(tz.local);
    }
    final tz.Location tzLocation = tz.getLocation(location);
    return tz.TZDateTime.now(tzLocation);
  }

  String _getTimezoneOffset(String location) {
    final tz.TZDateTime time = _getTimezoneTime(location);
    final Duration offset = time.timeZoneOffset;
    final int hours = offset.inHours;
    final int minutes = offset.inMinutes.remainder(60);
    final String sign = hours >= 0 ? '+' : '';
    return '$sign$hours:${minutes.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('时区查看器'), elevation: 0),
      body: StreamBuilder<DateTime>(
        stream: _timeStream,
        builder: (context, snapshot) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.info_outline, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            '实时时区对比',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '以下时间每秒自动更新',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ..._timezones.map((timezone) {
                final tz.TZDateTime time = _getTimezoneTime(
                  timezone['location']!,
                );
                final String formattedTime = _dateFormat.format(time);
                final String offset = _getTimezoneOffset(timezone['location']!);
                final bool isLocal = timezone['location'] == 'local';

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: isLocal ? 4 : 1,
                  child: Container(
                    decoration: isLocal
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          )
                        : null,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isLocal
                              ? Theme.of(
                                  context,
                                ).primaryColor.withValues(alpha: 0.1)
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          isLocal ? Icons.location_on : Icons.public,
                          color: isLocal
                              ? Theme.of(context).primaryColor
                              : Colors.grey[600],
                        ),
                      ),
                      title: Text(
                        timezone['name']!,
                        style: TextStyle(
                          fontWeight: isLocal
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            formattedTime,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'monospace',
                              color: isLocal ? Colors.black87 : Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'UTC $offset',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      trailing: isLocal
                          ? Chip(
                              label: const Text(
                                '当前',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: EdgeInsets.zero,
                            )
                          : null,
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.tips_and_updates,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '说明',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• 所有时间均为实时更新\n'
                        '• UTC 偏移量表示该时区与协调世界时的时差\n'
                        '• 本地时区根据设备系统时区自动识别',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
