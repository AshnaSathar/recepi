// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/constants/color_constants.dart';
// import 'package:flutter_application_1/constants/text_style.dart';
// import 'package:go_router/go_router.dart';

// void showEmailVerificationBottomSheet(BuildContext context) {
//   TextEditingController emailController = TextEditingController();
//   bool isEmailValid = false;

//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Container(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "Enter your email",
//                   style: TextStyles.normalText.copyWith(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   "We'll send you an OTP for validation.",
//                   style: TextStyles.normalText.copyWith(
//                     color: Colors.black54,
//                     fontSize: 14,
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Email Input Field
//                 TextField(
//                   controller: emailController,
//                   style: TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     labelText: "Email",
//                     labelStyle: TextStyle(color: Colors.black),
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.4),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.black),
//                     ),
//                     prefixIcon: Icon(Icons.email, color: Colors.black),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   onChanged: (value) {
//                     setState(() {
//                       isEmailValid = RegExp(
//                         r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
//                       ).hasMatch(value.trim());
//                     });
//                   },
//                 ),
//                 SizedBox(height: 20),

//                 ElevatedButton(
//                   onPressed: isEmailValid
//                       ? () {
//                           print(
//                               "Sending OTP to ${emailController.text.trim()}");
//                           Navigator.pop(context);
//                           showOTPVerificationBottomSheet(context);
//                         }
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: ColorConstants.primaryColor,
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text("Verify", style: TextStyles.h6),
//                       SizedBox(width: 8),
//                       Icon(Icons.arrow_forward, color: Colors.white),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }

// void showOTPVerificationBottomSheet(BuildContext context) {
//   List<TextEditingController> otpControllers =
//       List.generate(4, (index) => TextEditingController());
//   List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
//   bool isOTPComplete = false;
//   int timerSeconds = 60;
//   Timer? timer;

//   void startTimer(StateSetter setState) {
//     timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (timerSeconds > 0) {
//         setState(() => timerSeconds--);
//       } else {
//         timer.cancel();
//       }
//     });
//   }

//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           if (timer == null) {
//             startTimer(setState);
//           }

//           return Container(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "OTP Sent",
//                   style: TextStyles.normalText.copyWith(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   "A 4-digit OTP has been sent to your email.",
//                   style: TextStyles.normalText.copyWith(
//                     color: Colors.black54,
//                     fontSize: 14,
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // OTP Input Fields
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(4, (index) {
//                     return Container(
//                       width: 50,
//                       height: 50,
//                       margin: EdgeInsets.symmetric(horizontal: 5),
//                       child: TextField(
//                         controller: otpControllers[index],
//                         focusNode: focusNodes[index],
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center,
//                         keyboardType: TextInputType.number,
//                         maxLength: 1,
//                         decoration: InputDecoration(
//                           counterText: "",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                         ),
//                         onChanged: (value) {
//                           if (value.isNotEmpty && index < 3) {
//                             FocusScope.of(context)
//                                 .requestFocus(focusNodes[index + 1]);
//                           } else if (value.isEmpty && index > 0) {
//                             FocusScope.of(context)
//                                 .requestFocus(focusNodes[index - 1]);
//                           }

//                           setState(() {
//                             isOTPComplete = otpControllers.every(
//                                 (controller) => controller.text.isNotEmpty);
//                           });
//                         },
//                       ),
//                     );
//                   }),
//                 ),
//                 SizedBox(height: 20),

//                 // Timer Display
//                 Text(
//                   "Time left: 00:${timerSeconds.toString().padLeft(2, '0')}",
//                   style: TextStyles.normalText.copyWith(
//                     color: timerSeconds > 10 ? Colors.black : Colors.red,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Submit Button (Enabled only when OTP is complete)
//                 ElevatedButton(
//                   onPressed: isOTPComplete
//                       ? () {
//                           String enteredOTP = otpControllers
//                               .map((controller) => controller.text)
//                               .join();
//                           print("Entered OTP: $enteredOTP");
//                           Navigator.pop(context);
//                           context.go('/registration-page');
//                         }
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: ColorConstants.primaryColor,
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Text("Submit", style: TextStyles.h6),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   ).whenComplete(() => timer?.cancel());
// }
