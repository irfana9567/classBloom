
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/providers/failure.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/providers/typedef.dart';
import '../../../model/user_model.dart';


final homeRepositoryProvider = Provider((ref) => HomeRepository(
  fireStore:ref.watch(fireStoreProvider),
));


class HomeRepository{
  final FirebaseFirestore _fireStore;


  HomeRepository({required FirebaseFirestore fireStore}) : _fireStore = fireStore;

  ///get surveyor data
  Future<UserModel> getUser(String uid)async{
    try{
      final querySnapshot=await _fireStore
          .collection("users")
          .doc(uid).get();

      if(querySnapshot.exists){
        return UserModel.fromMap(querySnapshot.data()!);
      }else{
        return UserModel.fromMap({});
      }
    }catch (e) {
      print('Error fetching insurance companies: $e');
      return UserModel.fromMap({});
    }
  }

  ///update surveyor data
  FutureVoid updateSurveyor({required String uid, required UserModel userModel,}) async {
    try {
      return right(_fireStore.collection("users").doc(uid).update(userModel.toMap()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

}


