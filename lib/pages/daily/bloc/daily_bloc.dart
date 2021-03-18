import 'package:daily_repository/daily_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bionime/pages/daily/bloc/daily_event.dart';
import 'package:flutter_bionime/pages/daily/bloc/daily_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyBloc extends Bloc<DailyEvent, DailyState>{
  final DailyRepository dailyRepository;

  DailyBloc({@required this.dailyRepository})
      :assert(dailyRepository != null),
      super(DailyInital());

  @override
  Stream<DailyState> mapEventToState(DailyEvent event) async*{
    if(event is DailyRequested){
      yield DailyLoadInProgress();
      try{
        //等待1秒才執行，避免Loading效果沒看到
        await Future.delayed(Duration(seconds: 1));
        final Daily daily = await dailyRepository.getDaily();
        yield DailyLoadSuccess(daily: daily);
      }catch(e){
        yield DailyLoadFail();
      }
    }
  }

}