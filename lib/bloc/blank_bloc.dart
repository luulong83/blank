import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/subjects.dart';
import 'package:shopflut_blocv1/bloc/blank_event.dart';
import 'package:shopflut_blocv1/models/model.dart';
//import 'package:rxdart/rxdart.dart';
import 'package:shopflut_blocv1/repositories/blank_repository.dart';
import 'bloc.dart';

class BlankBloc extends Bloc<BlankEvent, BlankState> {
  BehaviorSubject<bool> loadingStream = new BehaviorSubject<bool>.seeded(false);
  BlankRepository _blankRepository;

  BlankBloc({
    @required BlankRepository blankRepository,
  })  : assert(blankRepository != null),
        _blankRepository = blankRepository;

  @override
  BlankState get initialState => InitialBlankState();

  @override
  void onTransition(Transition<BlankEvent, BlankState> transition) {
    print(transition);
  }

  @override
  Stream<BlankState> mapEventToState(
    BlankEvent event,
  ) async* {
    if (event is InitBlankInfoEvent) {
      yield* _mapModelChangedToState(
          new BasicModel(), new TotalConstantModel(), new TANKCONSTANTModel());
    }
    if (event is SubmitBlank) {
      loadingStream.add(true);
      yield* _mapModelChangedToState(
          event.basicModel, event.totalConstantModel, event.tankconstantModel);
      loadingStream.add(false);
    }
  }

  Stream<BlankState> _mapModelChangedToState(
      BasicModel basicmodel,
      TotalConstantModel totalConstantModel,
      TANKCONSTANTModel tankconstantModel) async* {
    ResultAll resultAll;

    await Future.delayed(Duration(seconds: 1), () async {
      resultAll = await _blankRepository.result(
          basicmodel, totalConstantModel, tankconstantModel);
    });

    yield ResultBlankInfo(
        basicModelSubmit: basicmodel,
        totalConstantModelSubmit: totalConstantModel,
        tankconstantModelSubmit: tankconstantModel,
        result1: resultAll.result1,
        result2: resultAll.result2);
  }
}
