import 'package:classbloom/feature/auth/screen/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/validators.dart';
import '../../../core/global_variable/global_variable.dart';
import '../../../core/widgets/text.dart';
import '../../../model/user_model.dart';
import '../controller/auth_controller.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {

  TextEditingController userName=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController confirmpassword=TextEditingController();

  final _formKey = GlobalKey<FormState>();
  createUser(){
    if(_formKey.currentState!.validate()){
      UserModel createdUser=UserModel(
        userName: userName.text,
        email: email.text,
        password: password.text,
        reference: null,
        id:'',
      );
      ref.read(AuthControllerProvider.notifier).createUser(context,usermodel: createdUser);
      clear();
    }else if(userName.text.isEmpty){
      return AppsHelper.showSnackBar("Enter username", context);
    }else if(email.text.isEmpty){
      return AppsHelper.showSnackBar("Enter your email", context);
    }else if(userName.text.isEmpty){
      return AppsHelper.showSnackBar("Enter password", context);
    }
  }
  clear(){
    _formKey.currentState?.reset();
  }
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height:h*0.025,),
                  TextFormField(
                    controller:userName,
                    keyboardType: TextInputType.text,
                    // textCapitalization: TextCapitalization.words,
                    textInputAction:TextInputAction.newline,
                    style: TextStyle(
                      fontSize: w*0.04,
                      fontWeight: FontWeight.w500,
                    ),
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    validator:(value) => AppValidators.fieldValidate(value,"UserName"),
                    decoration: InputDecoration(
                      labelText:"UserName" ,
                      labelStyle: TextStyle(
                          fontSize:  w*0.04,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey
                      ),
                      // prefixIcon: Icon(Icons.account_box_sharp),
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
                  SizedBox(height: h*0.025,),
                  TextFormField(
                    controller:email,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: w*0.04,
                      fontWeight: FontWeight.w500,
                    ),
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    validator:(value) => AppValidators.validateEmail(value),
                    decoration: InputDecoration(
                      labelText:"Email" ,
                      labelStyle: TextStyle(
                          fontSize: w*0.04,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey
                      ),
                      // prefixIcon: Icon(Icons.email_outlined),
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
                  SizedBox(height: h*0.025,),
                  TextFormField(
                    controller:password,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction:TextInputAction.newline,
                    style: TextStyle(
                      fontSize: w*0.04,
                      fontWeight: FontWeight.w500,
                    ),
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    validator:(value) => AppValidators.validatePassword(value),
                    decoration: InputDecoration(
                      labelText:"Password" ,
                      labelStyle: TextStyle(
                          fontSize:  w*0.04,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey
                      ),
                      // prefixIcon: Icon(Icons.lock),
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
                  SizedBox(height: h*0.025,),
                  TextFormField(
                    controller:confirmpassword,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction:TextInputAction.newline,
                    style: TextStyle(
                      fontSize: w*0.04,
                      fontWeight: FontWeight.w500,
                    ),
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    validator:(value){
                      if (confirmpassword.text !=
                          password.text) {
                        return "Password does not match";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText:"ConfirmPassword" ,
                      labelStyle: TextStyle(
                          fontSize:  w*0.04,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey
                      ),
                      // prefixIcon: Icon(Icons.lock),
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
                  SizedBox(height:h*0.07,),
                  InkWell(
                    onTap: () {
                      createUser();
                    },
                    child: Container(
                      height: h*0.065,
                      width: w*1,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(w*0.07),
                      ),
                      child: const Center(child: Text("Sign Up",style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                  SizedBox(height: h*0.015,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Do you have account? ",style: TextStyle(color: Colors.grey),),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                          },
                          child: const Text("Login",style: TextStyle(color: Colors.blue),))
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
