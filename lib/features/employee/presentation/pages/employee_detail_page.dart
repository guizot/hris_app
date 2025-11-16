import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hantera/core/theme/app_theme.dart';
import 'package:hantera/features/employee/domain/entities/employee.dart';
import 'package:hantera/features/employee/presentation/bloc/employee_bloc.dart';

class EmployeeDetailPage extends StatefulWidget {
  final String? employeeId;
  final Employee? employee;

  const EmployeeDetailPage({
    super.key,
    this.employeeId,
    this.employee,
  });

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    
    // Fetch employee data if not provided
    if (widget.employee == null && widget.employeeId != null) {
      context.read<EmployeeBloc>().add(GetEmployeeByIdEvent(widget.employeeId!));
    }
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to edit employee page
          // context.go('/employees/${widget.employee.id}/edit');
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(
          FontAwesomeIcons.penToSquare,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    // Header
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(
                            FontAwesomeIcons.arrowLeft,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Employee details',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Details card
                    Expanded(
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildProfileSection(),
                              const SizedBox(height: 24),
                              _buildInfoSection(),
                              const SizedBox(height: 24),
                              _buildContactSection(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              FontAwesomeIcons.user,
              size: 40,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              final employee = switch (state) {
                EmployeeDetailsLoaded s => s.employee,
                _ when widget.employee != null => widget.employee!,
                _ => null,
              };

              if (employee == null) {
                return Column(
                  children: [
                    SizedBox(
                      width: 160,
                      height: 16,
                      child: LinearProgressIndicator(
                        backgroundColor: AppTheme.backgroundColor,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 120,
                      height: 12,
                      child: LinearProgressIndicator(
                        backgroundColor: AppTheme.backgroundColor,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                      ),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  Text(
                    employee.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    employee.designation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textColorSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Employee information',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            final employee = switch (state) {
              EmployeeDetailsLoaded s => s.employee,
              _ when widget.employee != null => widget.employee!,
              _ => null,
            };

            if (employee == null) {
              return Column(
                children: [
                  _buildInfoRow(
                    icon: FontAwesomeIcons.idBadge,
                    label: 'Employee ID',
                    value: 'Loading...',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: FontAwesomeIcons.building,
                    label: 'Department',
                    value: 'Loading...',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: FontAwesomeIcons.calendar,
                    label: 'Hire date',
                    value: 'Loading...',
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildInfoRow(
                  icon: FontAwesomeIcons.idBadge,
                  label: 'Employee ID',
                  value: employee.id,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: FontAwesomeIcons.building,
                  label: 'Department',
                  value: employee.department,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: FontAwesomeIcons.calendar,
                  label: 'Hire date',
                  value:
                      '${employee.hireDate.day}/${employee.hireDate.month}/${employee.hireDate.year}',
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact information',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            final employee = switch (state) {
              EmployeeDetailsLoaded s => s.employee,
              _ when widget.employee != null => widget.employee!,
              _ => null,
            };

            if (employee == null) {
              return Column(
                children: [
                  _buildInfoRow(
                    icon: FontAwesomeIcons.envelope,
                    label: 'Email',
                    value: 'Loading...',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: FontAwesomeIcons.phone,
                    label: 'Phone',
                    value: 'Loading...',
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildInfoRow(
                  icon: FontAwesomeIcons.envelope,
                  label: 'Email',
                  value: employee.email,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: FontAwesomeIcons.phone,
                  label: 'Phone',
                  value: employee.phone,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.07),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 14,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textColorMuted,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}