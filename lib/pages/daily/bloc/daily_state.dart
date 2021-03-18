import 'package:daily_repository/daily_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class DailyState extends Equatable{
  const DailyState();
  @override
  List<Object> get props => [];
}

class DailyInital extends DailyState{}

class DailyLoadInProgress extends DailyState{}

class DailyLoadSuccess extends DailyState{
  final Daily daily;

  const DailyLoadSuccess({@required this.daily}): assert(daily != null);

  @override
  List<Object> get props => [daily];
}

class DailyLoadFail extends DailyState{}



