// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../model/question_model.dart';
//
// class QuizScreen extends StatefulWidget {
//   const QuizScreen({Key? key}) : super(key: key);
//
//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }
//
// class _QuizScreenState extends State<QuizScreen> {
//   List<QuestionModel> questions = [];
//   int currentQuestionIndex = 0;
//   int score = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchQuestions().then((data) {
//       setState(() {
//         questions = data;
//       });
//     });
//   }
//
//   Future<List<QuestionModel>> fetchQuestions() async {
//     final querySnapshot = await FirebaseFirestore.instance.collection('questions').get();
//     return querySnapshot.docs
//         .map((doc) => QuestionModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
//         .toList();
//   }
//
//   void nextQuestion() {
//     if (currentQuestionIndex < questions.length - 1) {
//       setState(() {
//         currentQuestionIndex++;
//       });
//     }
//   }
//
//   void skipQuestion() {
//     nextQuestion();
//   }
//
//   void selectAnswer(String selectedOption) {
//     if (selectedOption == questions[currentQuestionIndex].answer) {
//       score++;
//     }
//     nextQuestion();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (questions.isEmpty) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     final currentQuestion = questions[currentQuestionIndex];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz (${currentQuestionIndex + 1}/${questions.length})'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Q${currentQuestionIndex + 1}: ${currentQuestion.question}',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             Column(
//               children: [
//                 _buildOptionButton(currentQuestion.optionOne),
//                 _buildOptionButton(currentQuestion.optionTwo),
//                 _buildOptionButton(currentQuestion.optionThree),
//                 _buildOptionButton(currentQuestion.optionFour),
//               ],
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: skipQuestion,
//                   child: const Text('Skip'),
//                 ),
//                 currentQuestionIndex == questions.length - 1
//                     ? ElevatedButton(
//                   onPressed: () {
//                     // Show final score
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Quiz Completed'),
//                         content: Text('Your Score: $score/${questions.length}'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               Navigator.pop(context);
//                             },
//                             child: const Text('Close'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   child: const Text('Submit'),
//                 )
//                     : ElevatedButton(
//                   onPressed: nextQuestion,
//                   child: const Text('Next'),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOptionButton(String option) {
//     return ElevatedButton(
//       onPressed: () => selectAnswer(option),
//       style: ElevatedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       ),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Text(
//           option,
//           style: const TextStyle(fontSize: 16),
//         ),
//       ),
//     );
//   }
// }
