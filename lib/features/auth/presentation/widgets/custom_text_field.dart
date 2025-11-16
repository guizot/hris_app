import 'package:flutter/material.dart';
import 'package:hantera/core/theme/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.01).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.obscureText,
              validator: widget.validator,
              decoration: InputDecoration(
                labelText: widget.labelText,
                prefixIcon: widget.prefixIcon != null
                    ? Icon(widget.prefixIcon)
                    : null,
                suffixIcon: widget.suffixIcon,
              ),
              onTap: () {
                setState(() {
                  _isFocused = true;
                });
                _animationController.forward();
              },
              onTapOutside: (event) {
                setState(() {
                  _isFocused = false;
                });
                _animationController.reverse();
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        );
      },
    );
  }
}
