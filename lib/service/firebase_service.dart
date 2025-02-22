import 'package:firebase_core/firebase_core.dart';

class FirebaseService{
  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBKUyOpOCA7ONYWLf8-azYnBZWeOp88VIs",
            appId: "1:1022307443008:android:8e622e511efe70972c1aa5",
            messagingSenderId: "1022307443008",
            projectId: "test-c5003"));
    print('Initialized default app $app');
  }

}