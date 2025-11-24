import 'package:equatable/equatable.dart';
import 'package:hantera/domain/entities/company.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeEvent {}

class CompanySelected extends HomeEvent {
  final Company company;

  const CompanySelected(this.company);

  @override
  List<Object> get props => [company];
}
