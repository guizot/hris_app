import 'package:flutter/material.dart';
import 'package:hantera/core/theme/app_theme.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final Widget? icon;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.icon,
    this.isLoading = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
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
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) {
              if (!widget.isLoading) {
                setState(() {
                  _isHovered = true;
                });
              }
            },
            onExit: (_) {
              if (!widget.isLoading) {
                setState(() {
                  _isHovered = false;
                });
              }
            },
            child: GestureDetector(
              onTap: () {
                if (!widget.isLoading) {
                  widget.onPressed();
                }
              },
              onTapDown: (_) {
                if (!widget.isLoading) {
                  _animationController.forward();
                }
              },
              onTapUp: (_) {
                if (!widget.isLoading) {
                  _animationController.reverse();
                }
              },
              onTapCancel: () {
                if (!widget.isLoading) {
                  _animationController.reverse();
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                decoration: widget.isOutlined
                    ? BoxDecoration(
                        color: _isHovered
                            ? AppTheme.primaryColor.withOpacity(0.1)
                            : AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: AppTheme.primaryColor,
                          width: 1.5,
                        ),
                        boxShadow: _isHovered
                            ? [
                                BoxShadow(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  blurRadius: 8.0,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      )
                    : BoxDecoration(
                        color: _isHovered
                            ? AppTheme.secondaryColor
                            : AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.2),
                            blurRadius: _isHovered ? 8.0 : 4.0,
                            spreadRadius: 0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                child: Center(
                  child: widget.isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              widget.isOutlined
                                  ? AppTheme.primaryColor
                                  : Colors.white,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.icon != null) ...[
                              widget.icon!,
                              const SizedBox(width: 12),
                            ],
                            Text(
                              widget.text,
                              style: widget.isOutlined
                                  ? Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(color: AppTheme.primaryColor)
                                  : Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
