import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final fbAuth = FirebaseAuth.instance;
final currentUserId = fbAuth.currentUser!.uid;

final usersCollection = FirebaseFirestore.instance.collection('users');

final chatsCollection = usersCollection.doc(currentUserId).collection('chats');
