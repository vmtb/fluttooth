

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/main_controller.dart';
import '../controllers/user_controller.dart';
import 'app_const.dart';


Provider<FirebaseAuth> mAuthRef = Provider((ref)=>getFirebaseAuth());
final messaging = Provider<FirebaseMessaging>((ref) => FirebaseMessaging.instance);
final thumbStorageRef = Provider<Reference>((ref) => FirebaseStorage.instance.ref());

Provider<CollectionReference> userRef  = Provider((ref)=>getFirestore().collection("Users"));
Provider<CollectionReference> catRef  = Provider((ref)=>getFirestore().collection("Categories"));
Provider<CollectionReference> livreRef  = Provider((ref)=>getFirestore().collection("Livres"));
Provider<CollectionReference> postRef  = Provider((ref)=>getFirestore().collection("Posts"));
Provider<CollectionReference> favRef  = Provider((ref)=>getFirestore().collection("Favoris"));
Provider<CollectionReference> followRef  = Provider((ref)=>getFirestore().collection("Followers"));

final userController = Provider<UserController>((ref)=>UserController(ref));
final mainController = Provider<MainController>((ref)=>MainController(ref));

final lockApp = StateProvider<bool>((ref)=>false);


FirebaseFirestore getFirestore(){
  if(currentEnv==ENV_MODE.dev){
    return FirebaseFirestore.instanceFor(app: Firebase.app("secondary"));
  }else{
    return FirebaseFirestore.instance;
  }
}

getFirebaseAuth() {
    /*if(currentEnv==ENV_MODE.dev){
      return FirebaseAuth.instanceFor(app: Firebase.app("secondary"));
    }*/
    return FirebaseAuth.instance;
}