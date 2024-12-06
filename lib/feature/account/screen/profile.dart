
import 'package:classbloom/core/constants/color_const.dart';
import 'package:classbloom/core/constants/validators.dart';
import 'package:classbloom/core/widgets/drawer.dart';
import 'package:classbloom/core/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/global_variable/global_variable.dart';
import '../../../model/user_model.dart';
import '../controller/account_controller.dart';
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  StateProvider isEditPressed=StateProvider((ref) => false,);
  StateProvider isChangedData=StateProvider((ref) => false,);

  UserModel? userData;

  getData()async{
    userData=await ref.read(homeControllerProvider.notifier).getUser();
    nameController.text=userData!.userName;
    emailController.text=userData!.email;
  }

  updateData()async{
    if(_formKey.currentState!.validate()) {
      UserModel updatedData = userData!.copyWith(
        userName: nameController.text,
        email: emailController.text,
      );
      final isChangeData = ref.watch(isChangedData);
      if(isChangeData){
        ref.read(homeControllerProvider.notifier).updateUser(
            context, updatedData);
      }else{
        AppsHelper.showSnackBar("Please edit details", context);
      }


    }else{
      if(nameController.text.isEmpty){
        return AppsHelper.showSnackBar("Enter your name", context);
      }
      if(emailController.text.isEmpty){
        return AppsHelper.showSnackBar("Enter your email", context);
      }
    }
  }


  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final isEditPress = ref.watch(isEditPressed);
    final isChangeData = ref.watch(isChangedData);
    return Scaffold(
      appBar:  AppBar(
        title: isEditPress? const Text("Edit Profile"):const Text("Profile"),
        actions: [
          if(!isEditPress) SizedBox(
            child: InkWell(
                onTap: () {
                  ref.read(isEditPressed.notifier).state=true;
                },
                child: Padding(
                  padding:  EdgeInsets.all(w*0.05),
                  child:const Icon(Icons.edit),
                )),
          ),

        ],
      ),
      drawer: const CAppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left:w*0.05,right: w*0.05,top: w*0.13),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller:nameController,
                  readOnly: !isEditPress,
                  onChanged: (value) {
                    ref.read(isChangedData.notifier).state=true;
                  },
                  autovalidateMode:AutovalidateMode.onUserInteraction,
                  validator:(value) => AppValidators.fieldValidate(value,"name"),
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                ),
                SizedBox(height: w*0.05,),
                TextFormField(
                  controller:emailController,
                  readOnly: !isEditPress,
                  onChanged: (value) {
                    ref.read(isChangedData.notifier).state=true;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => AppValidators.validateEmail(value),
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                ),
                SizedBox(height: w*0.25,),
                if(isEditPress)SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style:ElevatedButton.styleFrom(backgroundColor: Palette.blackColor),
                      onPressed: () {
                        updateData();
                      },
                      child: const Text("Update",style: TextStyle(color: Palette.whiteColor),)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}









