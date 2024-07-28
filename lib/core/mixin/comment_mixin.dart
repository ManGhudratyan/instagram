import 'package:firebase_database/firebase_database.dart';

mixin CommentMixin {
  FirebaseDatabase get firebaseDatabase;

  DatabaseReference get commentDatabaseReference =>
      firebaseDatabase.ref('comments');
}
