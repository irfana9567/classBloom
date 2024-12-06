
import 'dart:convert';

import 'package:classbloom/core/widgets/text.dart';
import 'package:classbloom/feature/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/user_model.dart';
import '../repository/account_repository.dart';
final homeControllerProvider =
StateNotifierProvider<HomeController, bool>((ref) {
  return HomeController(
    homeRepository: ref.watch(homeRepositoryProvider),
    ref: ref,
  );
});

class HomeController extends StateNotifier<bool> {

  final HomeRepository _homeRepository;
  final Ref _ref;

  HomeController({required HomeRepository homeRepository, required Ref ref})
      : _homeRepository = homeRepository,
        _ref = ref,
        super(false);


  build() {
    return false;
  }


  Future<UserModel> getUser() async {
    final userId= currentUserId;
    return _homeRepository.getUser(userId);
  }

  updateUser(BuildContext context,UserModel userModel) async {
    final userId= currentUserId;
    final res = await _homeRepository.updateSurveyor(uid: userId, userModel: userModel);
    res.fold((l) => AppsHelper.showSnackBar(l.message,context), (r) {
      AppsHelper.showSnackBar('Updated successfully!',context);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage(selectedIndex: 3,),), (route) => false,);
    });
  }
}




