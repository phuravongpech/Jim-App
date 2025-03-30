// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/theme/theme.dart';
// import 'package:frontend/widgets/action/jim_button.dart';
// import 'package:frontend/widgets/action/jim_icon_button.dart';
// import 'package:frontend/widgets/action/jim_text_button.dart';
// import 'package:frontend/widgets/navigation/jim_top_bar.dart';

// class WorkoutSummaryScreen extends StatelessWidget {
//   final String duration = "11:00";
//   final List<Map<String, dynamic>> exercises = [
//     {
//       "name": "Deadlift",
//       "setNumber": 4,
//       "setCount": 4,
//       "imageUrl": "https://v2.exercisedb.io/image/Rcp-zoSdFZbzfb"
//     },
//     // ... other exercise entries
//   ];

//   WorkoutSummaryScreen({super.key});

//   bool get isWorkoutComplete {
//     return exercises
//         .every((exercise) => exercise['setCount'] == exercise['setNumber']);
//   }

//   void _finishWorkout(BuildContext context) {
//     if (!isWorkoutComplete) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Workout Incomplete'),
//           content: const Text(
//               'Are you sure you want to finish without completing all exercises?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Confirm'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: JimTopBar(
//         title: "Workout Summary",
//         centerTitle: true,
//         leading: JimIconButton(
//           icon: Icons.arrow_back,
//           onPressed: () {},
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(JimSpacings.m),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(duration, style: JimTextStyles.title),
//                 const SizedBox(height: JimSpacings.m),
//                 Text("Duration", style: JimTextStyles.title),
//                 const SizedBox(height: JimSpacings.m),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(JimSpacings.m),
//               child: ListView.separated(
//                 itemCount: exercises.length,
//                 separatorBuilder: (context, index) => const Divider(
//                   thickness: 1,
//                   color: JimColors.stroke,
//                   height: JimSpacings.xl,
//                 ),
//                 itemBuilder: (context, index) {
//                   final exercise = exercises[index];
//                   final setCount = exercise['setCount'] ?? 0;
//                   final setNumber = exercise['setNumber'];

//                   return Padding(
//                     padding: const EdgeInsets.all(JimSpacings.m),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(exercise['name'],
//                                   style: JimTextStyles.title),
//                               const SizedBox(height: 4),
//                               setCount < setNumber
//                                   ? JimTextButton(
//                                       text: 'Enter',
//                                       onPressed: () {},
//                                     )
//                                   : Text(
//                                       "All sets complete",
//                                       style: JimTextStyles.body
//                                           .copyWith(color: JimColors.primary),
//                                     ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         CachedNetworkImage(
//                           imageUrl: exercise['imageUrl'],
//                           width: 120,
//                           height: 120,
//                           placeholder: (context, url) =>
//                               const CircularProgressIndicator(),
//                           errorWidget: (context, url, error) =>
//                               const Icon(Icons.error),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(JimSpacings.m),
//             child: JimButton(
//               text: "Finish Workout",
//               onPressed: () => _finishWorkout(context),
//               type:
//                   isWorkoutComplete ? ButtonType.primary : ButtonType.secondary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
