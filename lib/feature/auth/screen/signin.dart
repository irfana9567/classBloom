import 'dart:async';

import 'package:classbloom/core/constants/image_const.dart';
import 'package:classbloom/feature/auth/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../core/global_variable/global_variable.dart';
import '../controller/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();

  login() {
    if (_formKey.currentState!.validate()) {
      ref.read(AuthControllerProvider.notifier).loginUser(
          email.text.trim(), password.text.trim(), context);
    }
  }
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: h*0.2,
                  width: w*0.4,
                  child: SvgPicture.asset(iconConst.logo,color: Colors.black,),
                ),
                SizedBox(height: h*0.05,),
                TextFormField(
                  controller:email,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: w*0.04,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    labelText:"Email",
                    labelStyle: TextStyle(
                        fontSize:  w*0.04,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey
                    ),
                    border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(w*0.02)
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey
                        )
                      // )
                    ),
                  ),
                ),
                SizedBox(height: h*0.05,),
                TextFormField(
                  controller:password,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: w*0.04,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    labelText:"Password" ,
                    labelStyle: TextStyle(
                        fontSize:  w*0.04,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey
                    ),
                    border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(w*0.02)
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey
                        )
                      // )
                    ),
                  ),
                ),
                SizedBox(height: h*0.04,),
                RoundedLoadingButton(
                  color:Colors.black ,
                  controller: btnController,
                  onPressed: () {
                    login();
                  },
                  child: const Text('Log in', style: TextStyle(color: Colors.white)),
                ),
                // InkWell(
                //   onTap: () {
                //     login();
                //   },
                //   child: Container(
                //     height: AppSize.scrHeight*0.065,
                //     width: AppSize.scrWidth*1,
                //     decoration: BoxDecoration(
                //         color: Colors.blue[700],
                //       borderRadius: BorderRadius.circular(AppSize.scrWidth*0.07)
                //     ),
                //     child: const Center(child: Text("Log in",style: TextStyle(color: Colors.white),)),
                //   ),
                // ),
                SizedBox(height: h*0.15,),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup(),));
                  },
                  child: Container(
                    height: h*0.065,
                    width: w*1,
                    decoration: BoxDecoration(
                      // color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(w*0.07),
                        border: Border.all(color: Colors.black)
                    ),
                    child: const Center(child: Text("Create new account",style: TextStyle(color: Colors.black),)),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
