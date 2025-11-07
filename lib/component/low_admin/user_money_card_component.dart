import 'package:fl_app1/api/models/admin_user_money_model.dart';
import 'package:flutter/material.dart';

class UserMoneyCardComponent extends StatelessWidget {
  final AdminUserMoneyModel? moneyData;
  final VoidCallback? onRecharge;

  const UserMoneyCardComponent({
    super.key,
    required this.moneyData,
    this.onRecharge,
  });

  @override
  Widget build(BuildContext context) {
    if (moneyData == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text('暂无钱包信息', style: TextStyle(color: Colors.grey[600])),
          ),
        ),
      );
    }

    final money = moneyData!;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  '用户钱包信息',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (onRecharge != null)
                  ElevatedButton.icon(
                    onPressed: onRecharge,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('充值'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow('用户 ID', money.id.toString()),
            _buildInfoRow(
              '账户余额',
              '¥${money.moneyAmount}',
              valueColor: Colors.green[700],
            ),
            _buildInfoRow(
              '推荐返利',
              '¥${money.moneyAmountRef}',
              valueColor: Colors.blue[700],
            ),
            _buildInfoRow('邀请人数', money.inviteNum.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontWeight: valueColor != null ? FontWeight.w500 : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
