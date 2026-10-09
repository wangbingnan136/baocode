import 'package:flutter/material.dart';

import '../chat/widgets/hover_builder.dart';
import '../ide/ide_hover.dart';
import '../theme/codicons.dart';
import '../theme/app_theme.dart';

/// The page the rail's icon shows: the conversations (Home), the scheduled
/// tasks, or the plugins and skills.
enum SidebarRailPage { home, scheduled, plugins }

/// The icon column beside the sidebar, as Codex's: one icon a page, the
/// current one's highlighted.
class SidebarRail extends StatelessWidget {
  const SidebarRail({
    super.key,
    required this.page,
    required this.onSelect,
    this.labels = const (
      home: 'Home',
      scheduled: 'Scheduled tasks',
      plugins: 'Plugins',
    ),
  });

  final SidebarRailPage page;
  final ValueChanged<SidebarRailPage> onSelect;

  /// The icons' tooltips; the app's localized ones where it has them.
  final ({String home, String scheduled, String plugins}) labels;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      child: Column(
        children: [
          const SizedBox(height: 12),
          _RailIcon(
            icon: Codicons.home,
            tooltip: labels.home,
            selected: page == SidebarRailPage.home,
            onTap: () => onSelect(SidebarRailPage.home),
          ),
          const SizedBox(height: 8),
          _RailIcon(
            icon: Codicons.clock,
            tooltip: labels.scheduled,
            selected: page == SidebarRailPage.scheduled,
            onTap: () => onSelect(SidebarRailPage.scheduled),
          ),
          const SizedBox(height: 8),
          _RailIcon(
            icon: Codicons.extensions,
            tooltip: labels.plugins,
            selected: page == SidebarRailPage.plugins,
            onTap: () => onSelect(SidebarRailPage.plugins),
          ),
        ],
      ),
    );
  }
}

class _RailIcon extends StatelessWidget {
  const _RailIcon({
    required this.icon,
    required this.tooltip,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IdeHover(
      message: tooltip,
      excludeFromSemantics: true,
      child: Semantics(
        button: true,
        selected: selected,
        label: tooltip,
        child: HoverBuilder(
          cursor: SystemMouseCursors.click,
          builder: (context, hovered) => GestureDetector(
            onTap: onTap,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.hover
                    : hovered
                    ? AppColors.hover.withValues(alpha: 0.5)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 20,
                color: selected || hovered
                    ? AppColors.text
                    : AppColors.textMuted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
