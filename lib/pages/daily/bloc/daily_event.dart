import 'package:equatable/equatable.dart';

abstract class DailyEvent extends Equatable{
  const DailyEvent();
}

class DailyRequested extends DailyEvent{
  @override
  List<Object> get props => [];
}