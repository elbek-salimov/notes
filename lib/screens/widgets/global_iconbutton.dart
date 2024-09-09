import 'package:flutter/material.dart';
import 'package:notes/utils/size/app_size.dart';

import '../../utils/colors/app_colors.dart';

class GlobalIconButton extends StatefulWidget {
  const GlobalIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  State<GlobalIconButton> createState() => _GlobalIconButtonState();
}

class _GlobalIconButtonState extends State<GlobalIconButton> {
  IconData? icon;
  VoidCallback? onTap;

  @override
  void initState() {
    icon = widget.icon;
    onTap = widget.onTap;
    super.initState();
  }

  bool _isPressed = false;

  void _setPressed(bool isPressed) {
    setState(() {
      _isPressed = isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.c252525,
          borderRadius: BorderRadius.circular(8.w),
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.03),
                    blurRadius: 5,
                  ),
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.3),
                    blurRadius: 5,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.03),
                    offset: const Offset(-5, -5),
                    blurRadius: 5,
                  ),
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.3),
                    offset: const Offset(5, 5),
                    blurRadius: 5,
                  ),
                ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 16.w,
          ),
        ),
      ),
    );
  }
}
