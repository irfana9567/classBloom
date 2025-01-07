

import 'package:classbloom/feature/home/screen/quiz_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../core/constants/color_const.dart';
import '../../../core/global_variable/global_variable.dart';
import '../../../core/widgets/custom_list_tile.dart';
import '../../../core/widgets/text.dart';
import '../../../core/widgets/text_form_field.dart';
import '../../../model/question_model.dart';
import '../../account/controller/account_controller.dart';

class AddQuestions extends ConsumerStatefulWidget {
  const AddQuestions({super.key,this.title});
  final String? title;

  @override
  ConsumerState<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends ConsumerState<AddQuestions> {
  addQuestions(){
    if(_formKey.currentState!.validate()){
      QuestionModel addedQn=QuestionModel(
        question: questionController.text,
        id: "",
        reference: null,
        correctAnswer: answerController.text.trim(),
        delete: false,
        options: [
          optionOneController.text.trim(),
          optionTwoController.text.trim(),
          optionThreeController.text.trim(),
          optionFourController.text.trim()
        ],
        uploadDate: DateTime.now(),
      );
      ref.read(homeControllerProvider.notifier).addQns(context, questionmodel: addedQn);
      clear();
    }else if(questionController.text.isEmpty){
      return AppsHelper.showSnackBar("Enter the question", context);
    }
    else if(optionOneController.text.isEmpty||optionTwoController.text.isEmpty||optionThreeController.text.isEmpty||optionFourController.text.isEmpty){
      return AppsHelper.showSnackBar("Please enter the options", context);
    }
    else if(answerController.text.isEmpty){
      return AppsHelper.showSnackBar("Enter the correct answer", context);
    }
  }

  clear(){
    _formKey.currentState?.reset();
  }

  TextEditingController questionController = TextEditingController();
  TextEditingController optionOneController = TextEditingController();
  TextEditingController optionTwoController = TextEditingController();
  TextEditingController optionThreeController = TextEditingController();
  TextEditingController optionFourController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  RoundedLoadingButtonController addExamController = RoundedLoadingButtonController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Palette.whiteColor,
      appBar: AppBar(
        title: const Text("Add Questions"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w*0.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: w*0.26,
                  decoration: BoxDecoration(
                    color: Palette.whiteColor,
                    borderRadius: BorderRadius.circular(w * 0.02),
                    border: Border.all(
                        color: Palette.blackColor
                    ),
                  ),
                  child: TextFormField(
                    controller: questionController,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    maxLines: null,
                    decoration: InputDecoration(
                      label: const Text("Enter the question here.."),
                      prefixIcon: Padding(
                        padding:  EdgeInsets.all(w*0.02),
                        child:  const Text("Q",style: TextStyle(fontWeight: FontWeight.w700),),
                      ),
                      labelStyle: TextStyle(fontFamily: fount,
                        color: Palette.blackColor,
                        fontSize: MediaQuery.of(context).size.width > 600
                            ? 14 // Web or larger screen size
                            : 16,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: w*0.05,right: w*0.05),
                    ),
                  ),
                ),
                SizedBox(height: h*0.02,),
                CustomTextInput(
                  controller: optionOneController,
                  // bgColour: Palette.secondaryColor,
                  borderColour: Palette.blackColor,
                  label: "Option 1",
                  labelColour: Palette.blackColor,
                  // prefixIcon: Padding(
                  //   padding:  EdgeInsets.all(w*0.02),
                  //   child:  const Text("1",style: TextStyle(fontWeight: FontWeight.w700),),
                  // ),
                  keyboardType: TextInputType.multiline,
                  textInputAction:TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                ),
                SizedBox(height: h*0.02,),
                CustomTextInput(
                  controller: optionTwoController,
                  // bgColour: Palette.secondaryColor,
                  borderColour: Palette.blackColor,
                  label: "Option 2",
                  labelColour: Palette.blackColor,
                  // prefixIcon: Padding(
                  //   padding:  EdgeInsets.all(w*0.02),
                  //   child:  const Text("2",style: TextStyle(fontWeight: FontWeight.w700),),
                  // ),
                  keyboardType: TextInputType.multiline,
                  textInputAction:TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                ),
                SizedBox(height: h*0.02,),
                CustomTextInput(
                  controller: optionThreeController,
                  // bgColour: Palette.secondaryColor,
                  borderColour: Palette.blackColor,
                  label: "Option 3",
                  labelColour: Palette.blackColor,
                    //         prefixIcon:Padding(
                    //       padding: EdgeInsets.all(w * 0.01), // Reduce padding for web
                    //   child: ConstrainedBox(
                    //     constraints: BoxConstraints(minWidth: w * 0.04, minHeight: w * 0.04),
                    //     child: const Text(
                    //       "3",
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: 14, // Add explicit font size for web
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    keyboardType: TextInputType.multiline,
                  textInputAction:TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                ),
                SizedBox(height: h*0.02,),
                CustomTextInput(
                  controller: optionFourController,
                  // bgColour: Palette.secondaryColor,
                  borderColour: Palette.blackColor,
                  label: "Option 4",
                  labelColour: Palette.blackColor,
                  // prefixIcon: Padding(
                  //   padding:  EdgeInsets.all(w*0.02),
                  //   child:  const Text("4",style: TextStyle(fontWeight: FontWeight.w700),),
                  // ),
                  keyboardType: TextInputType.multiline,
                  textInputAction:TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                ),
                SizedBox(height: h*0.02,),
                const Text("Correct Answer",
                  style: TextStyle(
                      fontWeight: FontWeight.w600),),
                SizedBox(height: h*0.02,),
                CustomTextInput(
                  controller: answerController,
                  // bgColour: Palette.secondaryColor,
                  borderColour: Palette.blackColor,
                  label: "Enter correct answer..",
                  labelColour: Palette.blackColor,
                  // prefixIcon: Padding(
                  //   padding:  EdgeInsets.all(w*0.02),
                  //   child:  const Text("A",style: TextStyle(fontWeight: FontWeight.w700),),
                  // ),
                  keyboardType: TextInputType.multiline,
                  textInputAction:TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                ),
                SizedBox(height: h*0.02,),
                Center(
                  child: SizedBox(
                    width: w*0.35,
                    child: ElevatedButton(
                        onPressed: () {
                          addQuestions();
                        },
                        style: ElevatedButton.styleFrom(
                          // foregroundColor: Palette.primaryColor,
                          backgroundColor: Palette.greyColor,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // side: const BorderSide(
                            //   color: Palette.blackColor,
                            // ),

                          ),),
                        child:
                        const Center(child: Text("Add Question",style: TextStyle(color: Palette.blackColor),))
                    ),
                  ),
                ),
                SizedBox(height: h*0.03,),
                ref.watch(getQn).when(
                  data: (data) {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return  Container(
                          height: w*0.2,
                          decoration: BoxDecoration(
                              color: Palette.blueColor,
                              borderRadius: BorderRadius.circular(w*0.02)
                          ),
                          child: ListTile(
                            leading: Text(
                                "Q${index+1}",
                                style: TextStyle(
                                  color: Palette.blackColor,
                                  fontSize:w * 0.03, // Adjust according to screen width
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.visible, // Ensures the text doesn't truncate
                              ),
                            title:Center(child: Text(data[index].question)) ,
                            trailing: InkWell(
                                onTap: () {
                                  print(data.length);
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize:w * 0.03, // Adjust according to screen width
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.visible, // Ensures the text doesn't truncate
                                ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height:h*0.02,
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),),
                // CustomListTile(
                //   bgColor:Colors.blue[100],
                //   leading:  Text("Q",style: TextStyle(color: Palette.blackColor,
                //       fontWeight: FontWeight.w600,fontSize: w*0.06),),
                //   title:  RichText(
                //     text: TextSpan(
                //       text: "What is the primary goal of prompt engineering in AI?",
                //       style: GoogleFonts.urbanist(
                //         color: Palette.blackColor,
                //         fontWeight: FontWeight.w600,),
                //     ),
                //   ),
                //   trailing: GestureDetector(
                //     onTap: () {
                //       // Navigator.push(context, MaterialPageRoute(builder: (context) => const EditQuestion(),));
                //     },
                //     child: Text(
                //       "Edit",
                //       style: TextStyle(
                //           color: Colors.red,
                //           fontSize: w*0.04,
                //           fontWeight: FontWeight.w600
                //       ),
                //     ),
                //   ) ,
                // ),
                SizedBox(height: h*0.1,),

                RoundedLoadingButton(
                  color:  Palette.blackColor,
                  controller: addExamController,
                  onPressed: () {

                    Navigator.pop(context);
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const QuizScreen(),));
                  },
                  child: Container(
                    height: w * 0.12,
                    width: w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.055),
                        color: Palette.blackColor),
                    child:  const Center(
                      child: CustomTextWidget(
                        text: "Submit",
                        color: Palette.whiteColor,
                      ),
                    ),
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
