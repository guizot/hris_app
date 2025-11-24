import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hantera/domain/entities/company.dart';
import 'package:hantera/domain/entities/user.dart';
import 'package:hantera/presentation/bloc/home/home_event.dart';
import 'package:hantera/presentation/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<HomeLoaded>(_onHomeLoaded);
    on<CompanySelected>(_onCompanySelected);
  }

  void _onHomeLoaded(HomeLoaded event, Emitter<HomeState> emit) {
    // In a real app, you would fetch this data from a repository
    final user = User(
      name: 'John Doe',
      email: 'john.doe@example.com',
    );
    final companies = [
      Company(id: '1', name: 'Company A'),
      Company(id: '2', name: 'Company B'),
      Company(id: '3', name: 'Company C'),
    ];
    final selectedCompany = companies.first;

    emit(HomeLoadSuccess(
      user: user,
      companies: companies,
      selectedCompany: selectedCompany,
    ));
  }

  void _onCompanySelected(CompanySelected event, Emitter<HomeState> emit) {
    if (state is HomeLoadSuccess) {
      final successState = state as HomeLoadSuccess;
      emit(successState.copyWith(selectedCompany: event.company));
    }
  }
}
