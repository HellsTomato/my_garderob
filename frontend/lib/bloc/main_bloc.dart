import 'dart:async';
import 'package:rxdart/rxdart.dart';
class MainBloc {
  final BehaviorSubject<MainPageState> stateController = BehaviorSubject();

  Stream<MainPageState> observeMainPageState() => stateController;

  //Добавляем изначальную позицию
  MainBloc() {
    stateController.add(MainPageState.entrance);
  }

  void nextState() {
    final currentState = stateController.value;

    switch(currentState){

      case MainPageState.entrance:
        // TODO: Handle this case.
      case MainPageState.registration:
        // TODO: Handle this case.
    }
    final nextState = MainPageState.values[
    (MainPageState.values.indexOf(currentState) + 1) %
        MainPageState.values.length];
    stateController.sink.add(nextState);
  }


  void dispose() {
    stateController.close();
  }
}

enum MainPageState {
  entrance,
  registration,
}
