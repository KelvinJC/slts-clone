import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class NavItem extends StatelessWidget {
  final String? asset;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    this.asset,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final color = selected ? null : AppColors.onBackgroundSurface2;

    Widget icon = asset == null
        ? Icon(null, size: wp(7), color: color)
        : ImageIcon(AssetImage(asset!), size: wp(7), color: color);

    if (selected) {
      icon = ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: AppColors.buttonGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        blendMode: BlendMode.srcIn,
        child: icon,
      );
    }

    Widget text = Text(
      label,
      style: TextStyle(
        fontSize: wp(3.2),
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
    if (selected) {
      text = ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: AppColors.buttonGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        blendMode: BlendMode.srcIn,
        child: text,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: wp(asset == null ? 30 : 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [icon, SizedBox(height: 4), text],
        ),
      ),
    );
  }
}
