import 'dart:async';

import 'package:fl_app1/store/local_time_store.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class SystemLocalTimePage extends StatefulWidget {
  const SystemLocalTimePage({super.key});

  @override
  State<SystemLocalTimePage> createState() => _SystemLocalTimePageState();
}

class _SystemLocalTimePageState extends State<SystemLocalTimePage> {
  final LocalTimeStore _store = LocalTimeStore();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;
  List<String> _filteredZones = <String>[];
  bool _initialized = false;

  Timer? _timer;

  // Store selected timezone identifier (simple string). If 'UTC', we'll display UTC time.
  String? _selectedTimeZone;

  // Flag to ensure tz database initialized once.
  bool _tzInitialized = false;

  // Common timezone list. It's OK to extend this list later.
  static const List<String> _timeZoneList = <String>[
    'UTC',
    'Asia/Shanghai',
    'Asia/Tokyo',
    'Asia/Hong_Kong',
    'Asia/Singapore',
    'Asia/Kolkata',
    'Europe/London',
    'Europe/Berlin',
    'Europe/Paris',
    'America/New_York',
    'America/Los_Angeles',
    'America/Chicago',
    'America/Denver',
    'Australia/Sydney',
    'Pacific/Auckland',
  ];

  List<String> _allTimeZones = <String>[];

  @override
  void initState() {
    super.initState();
    _ensureInit();
    _focusNode.addListener(_handleFocus);
    _controller.addListener(_onTextChanged);
  }

  Future<void> _ensureInit() async {
    // initialize store
    await _store.init();

    // initialize timezone database once
    if (!_tzInitialized) {
      try {
        tzdata.initializeTimeZones();
      } catch (_) {
        // If initialization fails, we still continue and fall back to local/UTC DateTime.
      }
      _tzInitialized = true;
    }

    // Try to read full timezone list from database; fall back to common list.
    try {
      final Iterable<String> keys = tz.timeZoneDatabase.locations.keys;
      _allTimeZones = keys.toList()
        ..sort();
      if (_allTimeZones.isEmpty) {
        _allTimeZones = List<String>.from(_timeZoneList);
      }
    } catch (_) {
      _allTimeZones = List<String>.from(_timeZoneList);
    }

    _controller.text = _store.fixedTimeZone ?? '';

    // 如果时区标识为空，则默认设置为 Asia/Shanghai
    if (_controller.text.isEmpty) {
      const String defaultTimeZone = 'Asia/Shanghai';
      await _store.setFixedTimeZone(defaultTimeZone);
      _controller.text = defaultTimeZone;
      _selectedTimeZone = defaultTimeZone;
    } else {
      _selectedTimeZone = _controller.text;
    }

    // If there is a saved tz, set tz.local location now so tz APIs use it immediately
    try {
      final tz.Location? initLoc = _resolveLocation(_selectedTimeZone);
      if (initLoc != null) {
        tz.setLocalLocation(initLoc);
      }
    } catch (_) {
      // ignore
    }

    // start live timer
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {});
    });

    setState(() {
      _initialized = true;
      _filteredZones = List<String>.from(_allTimeZones);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _removeOverlay();
    _focusNode.removeListener(_handleFocus);
    _focusNode.dispose();
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final String input = _controller.text.trim();
    if (input.isEmpty) {
      _filteredZones = List<String>.from(_allTimeZones);
    } else {
      _filteredZones = _allTimeZones
          .where((String z) => z.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
    if (_focusNode.hasFocus) {
      _showOverlay();
    }
  }

  void _handleFocus() {
    if (_focusNode.hasFocus) {
      _showOverlay();
    } else {
      // small delay to allow onTap of suggestion to register
      Future<void>.delayed(const Duration(milliseconds: 100), () {
        _removeOverlay();
      });
    }
  }

  void _showOverlay() {
    _removeOverlay();
    final OverlayState? overlayState = Overlay.of(context);
    if (overlayState == null) return;

    _overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Positioned(
        width: MediaQuery
            .of(context)
            .size
            .width - 32,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 56),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(4),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredZones.length,
                itemBuilder: (BuildContext context, int index) {
                  final String tzName = _filteredZones[index];
                  return ListTile(
                    title: Text(tzName),
                    onTap: () {
                      _controller.text = tzName;
                      _controller.selection =
                          TextSelection.collapsed(offset: tzName.length);
                      _selectedTimeZone = tzName;
                      _removeOverlay();
                      _focusNode.unfocus();
                      setState(() {});
                    },
                  );
                },
              ),
            ),
          ),
        ),
      );
    });

    overlayState.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  Future<void> _save() async {
    final String val = _controller.text.trim();

    // 如果输入为空，设置为默认时区 Asia/Shanghai
    if (val.isEmpty) {
      const String defaultTimeZone = 'Asia/Shanghai';
      await _store.setFixedTimeZone(defaultTimeZone);
      _selectedTimeZone = defaultTimeZone;
      _controller.text = defaultTimeZone;

      // 设置 tz package 的本地时区
      try {
        final tz.Location? loc = _resolveLocation(defaultTimeZone);
        if (loc != null) {
          tz.setLocalLocation(loc);
        }
      } catch (_) {
        // ignore
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已设置为默认时区 (Asia/Shanghai)')));
      setState(() {});
      return;
    }

    // Validate and canonicalize timezone name using tz database if possible
    final tz.Location? loc = _resolveLocation(val);
    if (loc == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('时区无效，请检查输入（例如 Asia/Shanghai 或 UTC）')));
      return;
    }

    // Find canonical name from database keys (case-insensitive match)
    String canonical = val;
    try {
      final Iterable<String> keys = tz.timeZoneDatabase.locations.keys;
      final String? match = keys.firstWhere(
            (String k) => k.toLowerCase() == val.toLowerCase(),
        orElse: () => '',
      );
      if (match != null && match.isNotEmpty) canonical = match;
    } catch (_) {
      // keep user input if no database available
    }

    await _store.setFixedTimeZone(canonical);
    _selectedTimeZone = canonical;
    // set tz package local location so tz.now() and related helpers use it
    try {
      final tz.Location? canonicalLoc = _resolveLocation(canonical);
      if (canonicalLoc != null) {
        tz.setLocalLocation(canonicalLoc);
      }
    } catch (_) {
      // ignore
    }
    // update input to canonical name so subsequent display uses exact key
    _controller.text = canonical;
    _controller.selection = TextSelection.collapsed(offset: canonical.length);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已保存时区设置')));
    setState(() {});
  }

  Future<void> _clear() async {
    // 清除时强制设置为 Asia/Shanghai
    const String defaultTimeZone = 'Asia/Shanghai';
    await _store.setFixedTimeZone(defaultTimeZone);
    _controller.text = defaultTimeZone;
    _selectedTimeZone = defaultTimeZone;

    // 设置 tz package 的本地时区
    try {
      final tz.Location? loc = _resolveLocation(defaultTimeZone);
      if (loc != null) {
        tz.setLocalLocation(loc);
      }
    } catch (_) {
      // ignore
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已重置为默认时区 (Asia/Shanghai)')));
    setState(() {});
  }

  tz.Location? _resolveLocation(String? tzName) {
    if (tzName == null) return null;
    final String name = tzName.trim();
    if (name.isEmpty) return null;
    if (name.toUpperCase() == 'UTC') {
      return tz.UTC;
    }

    try {
      return tz.getLocation(name);
    } catch (_) {
      // fall through to case-insensitive lookup
    }

    try {
      final Iterable<String> keys = tz.timeZoneDatabase.locations.keys;
      final String? match = keys.firstWhere(
            (String k) => k.toLowerCase() == name.toLowerCase(),
        orElse: () => '',
      );
      if (match != null && match.isNotEmpty) {
        try {
          return tz.getLocation(match);
        } catch (_) {
          return null;
        }
      }
    } catch (_) {
      // ignore
    }

    return null;
  }

  String _formatDateTimeForSelectedZone() {
    if (_selectedTimeZone != null &&
        _selectedTimeZone!.toUpperCase() == 'UTC') {
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc()) +
          ' (UTC+00:00)';
    }

    final tz.Location? loc = _resolveLocation(_selectedTimeZone);
    if (loc != null) {
      final tz.TZDateTime tzNow = tz.TZDateTime.from(
          DateTime.now().toUtc(), loc);
      final Duration offset = tzNow.timeZoneOffset;
      final int hours = offset.inHours.abs();
      final int minutes = offset.inMinutes.abs() % 60;
      final String offsetStr = '${offset.isNegative ? '-' : '+'}'
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(
          2, '0')}';
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(tzNow) +
          ' (UTC$offsetStr)';
    }

    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toLocal());
  }

  String _formatUtcNow() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc());
  }

  // Return offset string for selected timezone (e.g. +08:00) or empty if none
  String _selectedZoneOffsetString() {
    final tz.Location? loc = _resolveLocation(_selectedTimeZone);
    if (loc == null) return '';
    final tz.TZDateTime tzNow = tz.TZDateTime.from(DateTime.now().toUtc(), loc);
    final Duration offset = tzNow.timeZoneOffset;
    final int hours = offset.inHours.abs();
    final int minutes = offset.inMinutes.abs() % 60;
    final String offsetStr = '${offset.isNegative ? '-' : '+'}'
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(
        2, '0')}';
    return 'UTC$offsetStr';
  }

  String _deviceOffsetString() {
    final Duration offset = DateTime
        .now()
        .timeZoneOffset;
    final int hours = offset.inHours.abs();
    final int minutes = offset.inMinutes.abs() % 60;
    final String offsetStr = '${offset.isNegative ? '-' : '+'}'
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(
        2, '0')}';
    return 'UTC$offsetStr';
  }

  @override
  Widget build(BuildContext context) {
    final String deviceLocal = DateFormat('yyyy-MM-dd HH:mm:ss').format(
        DateTime.now().toLocal());
    final String utcNow = _formatUtcNow();
    final String selectedZoneLabel = _selectedTimeZone == null ||
        _selectedTimeZone!.isEmpty
        ? '（未设置，使用设备本地时区）'
        : _selectedTimeZone!;
    final String selectedZoneTime = _formatDateTimeForSelectedZone();
    final String selectedZoneOffset = _selectedZoneOffsetString();
    final String deviceOffset = _deviceOffsetString();

    return Scaffold(
      appBar: AppBar(title: const Text('本地时区设置')),
      body: _initialized
          ? Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                '固定本软件使用的本地时区 (时区数据库标识，例如: UTC, Asia/Shanghai)'),
            const SizedBox(height: 12),
            CompositedTransformTarget(
              link: _layerLink,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '时区标识',
                  hintText: '例如: Asia/Shanghai 或 UTC',
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(onPressed: _save, child: const Text('保存')),
                const SizedBox(width: 12),
                TextButton(onPressed: _clear, child: const Text('重置为默认')),
              ],
            ),
            const SizedBox(height: 20),

            // Live display section
            const Text('当前时间（设备本地）'),
            const SizedBox(height: 6),
            Text(deviceLocal, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),

            const Text('当前 UTC 时间'),
            const SizedBox(height: 6),
            Text(utcNow, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),

            const Text('使用的时区及显示时间'),
            const SizedBox(height: 6),
            Text(selectedZoneLabel, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 6),
            Text(selectedZoneTime, style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            // show offset comparison to help debug/display correctness
            if (selectedZoneOffset.isNotEmpty) ...[
              Text('选定时区偏移：$selectedZoneOffset'),
              const SizedBox(height: 4),
            ],
            Text('设备本地偏移：$deviceOffset'),
            const SizedBox(height: 20),

            const Text('说明'),
            const SizedBox(height: 6),
            const Text('1) 默认时区为 Asia/Shanghai (东八区 UTC+08:00)。'),
            const SizedBox(height: 6),
            const Text('2) 点击"重置为默认"将恢复为 Asia/Shanghai 时区。'),
            const SizedBox(height: 6),
            const Text(
              '3) 设置后应用会将此时区视为本地时区用于显示/比较/格式化（不改变API提交时间，仍请按 UTC 规则转换）。',
            ),
          ],
        ),
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
