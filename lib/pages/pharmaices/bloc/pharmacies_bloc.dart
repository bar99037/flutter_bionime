import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pharmacies_repository/pharmacies_repository.dart';

import 'pharmacies_event.dart';
import 'Pharmacies_state.dart';

const pharmaicesBox = 'pharmaices';

class PharmaciesBloc extends Bloc<PharmaciesEvent, PharmaciesState>{
  final PharmaciesRepository pharmaciesRepository;
  PharmaciesBloc({@required this.pharmaciesRepository})
      : assert(pharmaciesRepository != null),
        super(PharmaciesInitial());

  @override
  Stream<PharmaciesState> mapEventToState(PharmaciesEvent event) async*{
    if(event is PharmaciesRequested){
      yield* _mapMasksRequestedToState();
    }
    if(event is PharmaciesDeleted){
      yield* _mapMaskDeletedToState(event);
    }
  }

  Stream<PharmaciesState> _mapMasksRequestedToState() async*{
    yield PharmaciesLoadInProgress();
    try{
      var box = await Hive.openBox<Pharmacy>(pharmaicesBox);
      if(box.length > 0){
        yield PharmaciesLoadSuccess(box.values.toList());
      }else{
       List<Pharmacy> pharmaices = await pharmaciesRepository.getPahrmacies('臺中市');
       box.addAll(pharmaices);
       yield PharmaciesLoadSuccess(box.values.toList());
      }
    }catch(e){
      print(e.toString());
      yield PharmaciesLoadFail();
    }
  }

  Stream<PharmaciesState> _mapMaskDeletedToState(PharmaciesDeleted event) async*{
    await event.pharmacy.delete();
    yield PharmaciesLoadSuccess(Hive.box<Pharmacy>(pharmaicesBox).values.toList());
  }

}