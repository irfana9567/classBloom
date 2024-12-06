// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../core/constants/firebase_constants.dart';
// import '../../../core/global_variable/global_variable.dart';
// import '../../../core/providers/failure.dart';
// import '../../../core/providers/firebase_providers.dart';
// import '../../../core/providers/typedef.dart';
// import '../../../model/user_model.dart';
//
//
// final authRepositoryProvider = Provider((ref) => AuthRepository(
//   firestore: ref.read(fireStoreProvider),
//   auth: ref.read(authProvider),
// ));
//
// class AuthRepository {
//   final FirebaseFirestore _firestore;
//   final FirebaseAuth _auth;
//   // final GoogleSignIn _googleSignIn;
//
//   AuthRepository(
//       {required FirebaseFirestore firestore,
//         required FirebaseAuth auth})
//       : _firestore = firestore,
//         _auth = auth;
//
//   CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);
//   CollectionReference get _settings => _firestore.collection(FirebaseConstants.settingsCollection);
//
//   Future<int> getUid() async {
//     DocumentSnapshot id =
//     await _settings.doc('settings').get();
//     int uid = id['userId'];
//     uid++;
//     await _settings
//         .doc('settings')
//         .update({'userId': FieldValue.increment(1)});
//     return uid;
//   }
//
//   FutureEither signUp({
//     required String name,
//     required String email,
//     required String password,
//     required String confirmPassword,
//     required String phone})
//   async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       int getId = await getUid();
//       DocumentReference ref = _users.doc("US$getId");
//       UserModel userModel = UserModel(
//         uid:  "US$getId",
//         name: name,
//         email: email,
//         phoneNumber: phone,
//         created_time: DateTime.now(),
//         password: password,
//         confirmPassword: confirmPassword,
//         reference: ref,
//       );
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       currentUserEmail=   localStorage.setString('email', email);
//       currentUserId=     localStorage.setString('uid', "US$getId");
//       currentUserName=     localStorage.setString('name', name);
//       // currentUserEmail = localStorage.getString('email')!;
//       // currentUserId = localStorage.getString('uid')!;
//       // currentUserName=localStorage.getString('name');
//       currentUserEmail=userModel.email!;
//       currentUserId=userModel.uid!;
//       currentUserName=userModel.name!;
//       print("rightttttttttttttt");
//       return right(ref.set(userModel.toJson()));
//     } on FirebaseAuthException catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//       return left(Failure(e.code));
//     } catch (e) {
//       return left(Failure("Unknown error: $e"));
//     }
//   }
//
//   FutureEither signInWithEmailPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       String? mail = userCredential.user!.email;
//       final userData = await _users.where("email",isEqualTo: mail).get();
//       if (userData.docs.isEmpty) {
//         return left(Failure("User not found in Firestore"));
//       }
//       UserModel userModel = UserModel.fromJson(userData.docs.first.data() as Map<String,dynamic>);
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       currentUserEmail=    localStorage.setString('email', email);
//       currentUserId=localStorage.setString("uid", userModel.uid);
//       currentUserEmail = userModel.email;
//       currentUserId = userModel.uid;
//       currentUserName=userModel.name;
//       return right(userModel);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         return left(Failure("No user found for this email."));
//       } else if (e.code == 'wrong-password') {
//         return left(Failure("Incorrect password."));
//       }
//       return left(Failure(e.message ?? 'Login failed.'));
//     } catch (e) {
//       return left(Failure("Unknown error: $e"));
//     }
//   }
//
//   Future<UserModel> getUserData(String currentUserEmail) async {
//     if (kDebugMode) {
//       print("currentUserEmail");
//     }
//     if (kDebugMode) {
//       print(currentUserEmail);
//     }
//     if (kDebugMode) {
//       print("currentUserEmail");
//     }
//     var a = await _users.where("email", isEqualTo: currentUserEmail).get();
//     if (a.docs.isEmpty) {
//       throw Exception("User not found for email: $currentUserEmail");
//     } else {
//       return UserModel.fromJson(a.docs.first.data() as Map<String, dynamic>);
//     }
//   }
//
//   FutureEither<UserModel> checkKeepLogin() async {
//     try {
//       if (kDebugMode) {
//         print("111111111111111");
//       }
//       final localStorage = await SharedPreferences.getInstance();
//       bool log = localStorage.containsKey('email');
//       if (log) {
//         if (localStorage.getString('email')!.isEmpty) {
//           await localStorage.remove("email");
//           await localStorage.remove("uid");
//           await localStorage.remove("name");
//           currentUserEmail = '';
//           currentUserId = '';
//           return left(Failure("No email stored in SharedPreferences."));
//         } else {
//           currentUserEmail = localStorage.getString('email')!;
//           currentUserId = localStorage.getString('uid')!;
//           currentUserName=localStorage.getString('name');
//           String? uId = localStorage.getString("uid");
//           if (kDebugMode) {
//             print("dataaa");
//           }
//           if (kDebugMode) {
//             print(currentUserEmail);
//           }
//           if (kDebugMode) {
//             print(currentUserId);
//           }
//           if (kDebugMode) {
//             print(uId);
//           }
//           if (kDebugMode){
//             print(currentUserName);
//           }
//           if (kDebugMode) {
//             print("dataaa");
//           }
//           UserModel user = await getUserData(currentUserEmail);
//           return right(user);
//         }
//       } else {
//         if (kDebugMode) {
//           print("User not logged in.");
//         }
//         return left(Failure("User not logged in."));
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error during keep login check: $e");
//       }
//       return left(Failure("Error during keep login check: $e"));
//     }
//   }
//
//   Future signOut() async {
//     try {
//       await _auth.signOut();
//       // await _googleSignIn.signOut();
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       localStorage.remove('email');
//       currentUserEmail = '';
//       print('${currentUserEmail}');
//       currentUserName = '';
//       print('${currentUserName}');
//       currentUserId = '';
//       print('${currentUserId}');
//       print('tttttttttttttttttttttttttttttt');
//       return right(null);
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }
//
//
//
// }
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/global_variable/global_variable.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../model/user_model.dart';

final AuthRepositoryProvider=Provider((ref) => AuthRepository(firestore: ref.watch(fireStoreProvider), firebaseAuth: FirebaseAuth.instance, ));

// final currentUserIdProvider = StateProvider((ref) => "");
class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth}) : _firestore=firestore, _firebaseAuth=firebaseAuth ;

  ///create user
  createUser({required UserModel userModel}) {
    try{
      DocumentReference reference=_firestore.collection("users").doc();

      // print(reference.id);
      UserModel userModelData=userModel.copyWith(
        id: reference.id,
        reference: reference,
      );
      // print(usermodelData.id);
      createEmail(userModel.email, userModel.password);
      return Right(reference.set(userModelData.toMap()));
    } catch(e){
      return Left(e.toString());
    }
  }
  ///create user with email&password
  createEmail(email,password){
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }
  ///user login
  loginUser(String email,String password,)async{
    try{
      final result=await _firestore.collection("users")
          .where('email',isEqualTo: email)
          .get();
      print(result);
      if(result.docs.isEmpty){
        return "This user does not exist";
      }
      final currentUserDoc = result.docs.first;
      final userData = currentUserDoc.data();
      final storedPassword = userData['password'];

      if (storedPassword == password) {
        currentUser = UserModel.fromMap(userData);
        currentUserId=currentUserDoc.id;
        return right(currentUser);
      } else {
        return left(('Incorrect password'));
      }
    }catch(e,s){
      print(s);
      return left(('Login failed'));
    }
  }


//   class AuthProvider with ChangeNotifier {
//   UserModel? currentUser;
//   String currentUserId = '';
//
//   Future<Either<String, UserModel>> loginUser(String email, String password) async {
//     try {
//       final result = await _firestore.collection("users")
//           .where('email', isEqualTo: email)
//           .get();
//
//       if (result.docs.isEmpty) {
//         return left("This user does not exist");
//       }
//
//       final currentUserDoc = result.docs.first;
//       final userData = currentUserDoc.data();
//       final storedPassword = userData['password'];
//
//       if (storedPassword == password) {
//         currentUser = UserModel.fromMap(userData);
//         currentUserId = currentUserDoc.id;
//         notifyListeners(); // Notify listeners about the state change
//         return right(currentUser!);
//       } else {
//         return left('Incorrect password');
//       }
//     } catch (e, s) {
//       print(s);
//       return left('Login failed');
//     }
//   }
// }






}