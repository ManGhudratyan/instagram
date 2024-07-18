import 'package:firebase_database/firebase_database.dart';

mixin MessageMixin {
  FirebaseDatabase get firebaseDatabase;

  DatabaseReference get messageDatabaseReference =>
      firebaseDatabase.ref('messages');
}
