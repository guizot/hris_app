import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hantera/core/theme/app_theme.dart';

class EmployeeSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const EmployeeSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<EmployeeSearchBar> createState() => _EmployeeSearchBarState();
}

class _EmployeeSearchBarState extends State<EmployeeSearchBar> with SingleTickerProviderStateMixin {
  bool _isFocused = false;
  late AnimationController _animationController;
  late Animation<double> _focusAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _focusAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
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
      animation: _focusAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _focusAnimation.value,
          child: _buildSearchField(),
        );
      },
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      onTap: () {
        setState(() => _isFocused = true);
      },
      onSubmitted: (value) {
        setState(() => _isFocused = false);
      },
      onTapOutside: (event) {
        setState(() => _isFocused = false);
      },
      decoration: InputDecoration(
        hintText: 'Search employees by name, email, department...',
        prefixIcon: Icon(
          FontAwesomeIcons.search,
          color: _isFocused ? AppTheme.primaryColor : AppTheme.textColorMuted,
        ),
      ),
    );
  }

}