import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = 60,
  });
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? AppColors.buttonSecondary,
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: iconColor ?? AppColors.primary, // Using the dynamic primary color
            size: size * 0.5,
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final TextStyle? textStyle;
  
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 200,
    this.height = 50,
    this.textStyle,
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.primary, // Using the dynamic primary color
        backgroundColor: AppColors.primaryLight, // Using the dynamic primary light color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        minimumSize: Size(width, height),
      ),
      child: Text(
        text,
        style: textStyle ?? TextStyle(fontSize: 24),
      ),
    );
  }
}