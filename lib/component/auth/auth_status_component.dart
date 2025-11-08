import 'package:fl_app1/store/service/auth/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

/// Example widget showing how to use AuthStore in your app
class AuthStatusComponent extends StatefulWidget {
  const AuthStatusComponent({super.key});

  @override
  State<AuthStatusComponent> createState() => _AuthStatusComponentState();
}

class _AuthStatusComponentState extends State<AuthStatusComponent> {
  final AuthStore _authStore = AuthStore();

  @override
  void initState() {
    super.initState();
    // Listen to auth state changes
    _authStore.addListener(_onAuthChanged);
  }

  @override
  void dispose() {
    _authStore.removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    // Rebuild UI when auth state changes (login/logout/token refresh)
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Authentication Status',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildStatusRow(
              'Status',
              _authStore.isAuthenticated
                  ? 'Authenticated ✓'
                  : 'Not Authenticated',
              _authStore.isAuthenticated ? Colors.green : Colors.red,
            ),
            if (_authStore.isAuthenticated) ...[
              const SizedBox(height: 8),
              _buildStatusRow('Email', _authStore.userEmail ?? 'N/A', null),
              const SizedBox(height: 8),
              _buildStatusRow(
                'Token Expiry',
                _formatExpiry(_authStore.accessTokenPayload?.exp),
                null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await _authStore.logout();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out successfully')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Logout'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, Color? valueColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(value, style: TextStyle(color: valueColor)),
        ),
      ],
    );
  }

  String _formatExpiry(int? exp) {
    if (exp == null) return 'N/A';
    final expTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    final now = tz.TZDateTime.now(tz.local);
    final diff = expTime.difference(now);

    if (diff.isNegative) {
      return 'Expired';
    }

    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    return 'In ${hours}h ${minutes}m';
  }
}
