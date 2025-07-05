import 'package:flutter/material.dart';

class ReviewRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const ReviewRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          Flexible(
            child: Text(
              value.isEmpty ? '-' : value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: valueColor ?? theme.colorScheme.onSurface,
                fontSize: 14,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
