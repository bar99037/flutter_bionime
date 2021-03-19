import 'package:equatable/equatable.dart';
import 'package:pharmacies_repository/pharmacies_repository.dart';

abstract class PharmaciesEvent extends Equatable{
  const PharmaciesEvent();
}

class PharmaciesRequested extends PharmaciesEvent{
  @override
  List<Object> get props => [];
}

class PharmaciesDeleted extends PharmaciesEvent{
  final Pharmacy pharmacy;
  const PharmaciesDeleted(this.pharmacy);

  @override
  List<Object> get props => [this.pharmacy];
}