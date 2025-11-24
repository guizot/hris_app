import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hantera/presentation/bloc/home/home_bloc.dart';
import 'package:hantera/presentation/bloc/home/home_event.dart';
import 'package:hantera/presentation/bloc/home/home_state.dart';
import 'package:hantera/presentation/pages/company_selector_card.dart';
import 'package:hantera/presentation/pages/feature_grid.dart';
import 'package:hantera/presentation/pages/user_info_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeLoaded()),
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoadSuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      UserInfoCard(user: state.user),
                      const SizedBox(height: 16),
                      CompanySelectorCard(
                        companies: state.companies,
                        selectedCompany: state.selectedCompany,
                        onCompanySelected: (company) {
                          context.read<HomeBloc>().add(CompanySelected(company));
                        },
                      ),
                      const SizedBox(height: 16),
                      const FeatureGrid(),
                    ],
                  ),
                ),
              );
            } else if (state is HomeLoadFailure) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }
}
