
import 'package:classbloom/feature/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/global_variable/global_variable.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/widgets/text.dart';
import '../../../model/user_model.dart';
import '../repository/auth_repository.dart';
import '../screen/signin.dart';

// final AuthControllerProvider=Provider((ref) => AuthController(addingRepository: ref.watch(AuthRepositoryProvider)));
//
//
// class AuthController {
//   final AuthRepository _authRepository;
//
//   AuthController({required AuthRepository addingRepository})
//       :_authRepository=addingRepository;

final AuthControllerProvider =
StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authRepository: ref.watch(AuthRepositoryProvider),
    ref: ref,
  );
});



class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);



  createUser(BuildContext context,{required UserModel usermodel})async {
    final res= await _authRepository.createUser( userModel: usermodel);
    res.fold((l)=> AppsHelper.showSnackBar(l.toString(), context),(r){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage(),), (route) => false,);
    });
  }

  Future<void> loginUser(String email, String password, BuildContext context,) async {
    state = true;
    try {
      final res =await _authRepository.loginUser(email, password);
      res.fold((l) {
        AppsHelper.showSnackBar(l,context);
      }, (userModel) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final userId = userModel.id ?? '';
        await prefs.setString("id", userId);
        // _ref.read(currentUserIdProvider.notifier).state = userId;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage(),), (route) => false,);
      });
    } catch (e) {
      AppsHelper.showSnackBar(e.toString(),context);
    }
  }

  Future<void> keepLogin(BuildContext context) async {

    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("id") && (prefs.getString("id")??'').isNotEmpty) {

      _ref.read(fireStoreProvider)
          .collection('users')
          .doc(prefs.getString("id"))
          .snapshots()
          .listen((event) async {
        if (event.exists) {
          // _ref.read(currentUserIdProvider.notifier).state = prefs.getString("id") ?? '';
          currentUserId=prefs.getString("id")??'';
          currentUser=UserModel.fromMap(event.data()!);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage(selectedIndex: 0,),), (route) => false,);
        }

      });
    }
    else {
      prefs.remove("id");
      // _ref.read(currentUserIdProvider.notifier).state = "";
      currentUserId = "";

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage(),), (route) => false,);
      }
    }
  }


}

