import 'package:equatable/equatable.dart';
import 'package:hantera/domain/entities/company.dart';
import 'package:hantera/domain/entities/user.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final User user;
  final List<Company> companies;
  final Company selectedCompany;

  const HomeLoadSuccess({
    required this.user,
    required this.companies,
    required this.selectedCompany,
  });

  @override
  List<Object> get props => [user, companies, selectedCompany];

  HomeLoadSuccess copyWith({
    User? user,
    List<Company>? companies,
    Company? selectedCompany,
  }) {
    return HomeLoadSuccess(
      user: user ?? this.user,
      companies: companies ?? this.companies,
      selectedCompany: selectedCompany ?? this.selectedCompany,
    );
  }
}

class HomeLoadFailure extends HomeState {
  final String error;

  const HomeLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
