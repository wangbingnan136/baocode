// Customize's place in the sidebar, as Codex's: its title, then a row for
// each kind, the one shown selected.

import 'package:flutter/material.dart';

import '../chat/widgets/hover_builder.dart';
import '../l10n/l10n.dart';
import '../theme/app_theme.dart';
import '../theme/workbench_theme.dart' show themeColors;
import '../workspace/title_bar_double_click.dart';
import '../workspace/window_controls.dart';
import 'customize_view.dart' show CustomizationKindLabels;
import 'customizations.dart';

class CustomizeNav extends StatelessWidget {
  const CustomizeNav({super.key, required this.kind, required this.onSelect});

  final CustomizationKind kind;
  final ValueChanged<CustomizationKind> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: AppColors.sidebarSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!WindowControls.drawsHeader)
            const TitleBarDoubleClick(
              child: SizedBox(height: AppMetrics.titleBarHeight),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Text(
              l10n.customizeTitle,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          for (final each in CustomizationKind.values)
            _NavRow(
              icon: each.icon,
              label: each.label(l10n),
              selected: each == kind,
              onTap: () => onSelect(each),
            ),
        ],
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    child: HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context, hovered) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: 32,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: selected
                ? themeColors['list.activeSelectionBackground']
                : hovered
                ? AppColors.hover
                : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 15,
                color: selected ? AppColors.textPrimary : AppColors.textMuted,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? AppColors.textPrimary : AppColors.text,
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
