import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/codicons.dart';

/// The scheduled tasks page: the rail's clock icon's. A placeholder until
/// the scheduler lands.
class ScheduledTasksView extends StatelessWidget {
  const ScheduledTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Codicons.clock, size: 40, color: AppColors.textFaint),
          const SizedBox(height: 12),
          Text(
            'Scheduled tasks',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Coming soon',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
