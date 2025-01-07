
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/providers/failure.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/providers/typedef.dart';
import '../../../model/question_model.dart';
import '../../../model/user_model.dart';


final homeRepositoryProvider = Provider((ref) => HomeRepository(
  fireStore:ref.watch(fireStoreProvider),
));


class HomeRepository{
  final FirebaseFirestore _fireStore;


  HomeRepository({required FirebaseFirestore fireStore}) : _fireStore = fireStore;


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

  FutureVoid updateUser({required String uid, required UserModel userModel,}) async {
    try {
      return right(_fireStore.collection("users").doc(uid).update(userModel.toMap()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  addQns( {required QuestionModel questionModel}){
    try{
      DocumentReference reference=_fireStore.collection("questions").doc();
      QuestionModel questionModelData=questionModel.copyWith(
        id: reference.id,
        reference: reference,
      );
      return Right(reference.set(questionModelData.toJson()));


    }catch (e){
      return Left(e.toString());
    }
  }

  Stream<List<QuestionModel>> getQns(){
    return _fireStore.collection('questions').where('delete',isEqualTo: false).orderBy('uploadDate',descending: true).snapshots().map((event) =>
        event.docs.map((e) => QuestionModel.fromJson(e.data()),).toList(),);
  }
}


