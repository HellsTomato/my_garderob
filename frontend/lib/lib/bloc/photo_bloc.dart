import 'package:my_garderob/pages/room_page.dart';
import 'package:rxdart/rxdart.dart';

class SavePhotoToRoom {
  static BehaviorSubject<String> headController = BehaviorSubject.seeded('');
  static BehaviorSubject<String> torsoController = BehaviorSubject.seeded("");
  static BehaviorSubject<String> legsController = BehaviorSubject.seeded("");
  static BehaviorSubject<String> feetController = BehaviorSubject.seeded('');

  SavePhotoToRoom() {

      headController.sink.add('');
      torsoController.sink.add('');
      legsController.sink.add('');
      feetController.sink.add('');
  }



  void dispose() {
    headController.close();
    torsoController.close();
    legsController.close();
    feetController.close();
  }


  }

class BodyPartName {
  static const String head = 'Head';
  static const String torso = 'Torso';
  static const String legs = 'Legs';
  static const String feet = 'Feet';
}
