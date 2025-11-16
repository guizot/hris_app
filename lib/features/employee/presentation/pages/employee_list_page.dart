import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hantera/core/theme/app_theme.dart';
import 'package:hantera/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:hantera/features/employee/presentation/widgets/employee_card.dart';
import 'package:hantera/features/employee/presentation/widgets/search_bar.dart';
import 'package:hantera/features/employee/presentation/pages/employee_detail_page.dart';
import 'package:hantera/features/employee/presentation/pages/add_employee_page.dart';
import 'package:hantera/service_locator.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
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
    
    // Load employees when page initializes
    context.read<EmployeeBloc>().add(const GetEmployeesEvent());
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/employees/add');
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                children: [
                  // Header row
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => context.go('/home'),
                          icon: const Icon(
                            FontAwesomeIcons.arrowLeft,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Employee Management',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Manage your team members efficiently',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.textColorSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Search + list inside card
                  Expanded(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: _buildSearchBar(),
                            ),
                            const Divider(height: 1),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                child: _buildEmployeeList(),
                              ),
                            ),
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
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: EmployeeSearchBar(
        controller: _searchController,
        onChanged: (query) {
          if (query.isEmpty) {
            context.read<EmployeeBloc>().add(const ClearSearchEvent());
          } else {
            context.read<EmployeeBloc>().add(SearchEmployeesEvent(query));
          }
        },
      ),
    );
  }

  Widget _buildEmployeeList() {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        if (state is EmployeeLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        } else if (state is EmployeeFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.triangleExclamation,
                  size: 64,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (state is EmployeeLoaded) {
          final employees = state.employees;
          if (employees.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.users,
                    size: 64,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No employees found',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: employees.length,
            itemBuilder: (context, index) {
              return EmployeeCard(
                employee: employees[index],
                onTap: () {
                  context.go('/employees/${employees[index].id}', extra: employees[index]);
                },
              );
            },
          );
        } else if (state is EmployeeSearchLoaded) {
          final employees = state.employees;
          if (employees.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 64,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No employees found for your search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: employees.length,
            itemBuilder: (context, index) {
              return EmployeeCard(
                employee: employees[index],
                onTap: () {
                  context.go('/employees/${employees[index].id}', extra: employees[index]);
                },
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}