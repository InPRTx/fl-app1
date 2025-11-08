import 'dart:async';

import 'package:fl_app1/store/local_time_store.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    _controller.text = _store.fixedTimeZone ?? '';
    _selectedTimeZone = _controller.text.isEmpty ? null : _controller.text;

    // start live timer
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {});
    });

    setState(() {
      _initialized = true;
      _filteredZones = List<String>.from(_timeZoneList);
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
      _filteredZones = List<String>.from(_timeZoneList);
    } else {
      _filteredZones = _timeZoneList
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
    await _store.setFixedTimeZone(val.isEmpty ? null : val);
    _selectedTimeZone = val.isEmpty ? null : val;
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已保存时区设置')));
    setState(() {});
  }

  Future<void> _clear() async {
    await _store.setFixedTimeZone(null);
    _controller.text = '';
    _selectedTimeZone = null;
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已清除时区设置')));
    setState(() {});
  }

  String _formatDateTimeForSelectedZone() {
    if (_selectedTimeZone == 'UTC') {
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc());
    }
    // For non-UTC zones we display device local time (accurate conversion requires timezone database).
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final String deviceLocal = DateFormat('yyyy-MM-dd HH:mm:ss').format(
        DateTime.now());
    final String selectedZoneLabel = _selectedTimeZone == null ||
        _selectedTimeZone!.isEmpty
        ? '（未设置，使用设备本地时区）'
        : _selectedTimeZone!;
    final String selectedZoneTime = _formatDateTimeForSelectedZone();

    return Scaffold(
      appBar: AppBar(title: const Text('本地时区设置')),
      body: _initialized
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('固定本软件使用的本地时区 (时区数据库标识，例如: UTC, Asia/Shanghai)'),
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
                      TextButton(onPressed: _clear, child: const Text('清除')),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Live display section
                  const Text('当前时间（设备本地）'),
                  const SizedBox(height: 6),
                  Text(deviceLocal, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),

                  const Text('使用的时区及显示时间'),
                  const SizedBox(height: 6),
                  Text(selectedZoneLabel, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 6),
                  Text(selectedZoneTime, style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),

                  const Text('说明'),
                  const SizedBox(height: 6),
                  const Text('1) 如果不设置(为空)，应用将使用设备本地时间显示。'),
                  const SizedBox(height: 6),
                  const Text(
                    '2) 设置后应用会将此时区视为本地时区用于显示/比较/格式化（不改变API提交时间，仍请按 UTC 规则转换）。',
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
