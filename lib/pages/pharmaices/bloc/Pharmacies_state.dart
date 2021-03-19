import 'package:equatable/equatable.dart';
import 'package:pharmacies_repository/pharmacies_repository.dart';

abstract class PharmaciesState extends Equatable{
  const PharmaciesState();
  @override
  List<Object> get props => [];
}

class PharmaciesInitial extends PharmaciesState{}

class PharmaciesLoadInProgress extends PharmaciesState{}

class PharmaciesLoadSuccess extends PharmaciesState{
  final List<Pharmacy> pharmacies;
  const PharmaciesLoadSuccess([this.pharmacies = const []]);

  @override
  List<Object> get props => [pharmacies];
}

class PharmaciesLoadFail extends PharmaciesState{}

