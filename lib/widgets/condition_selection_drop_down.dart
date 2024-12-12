// import 'package:flutter/material.dart';
// import 'package:gluco_mate/providers/patient_data_provider.dart';
// import 'package:provider/provider.dart';
// class ConditionSelectionDropDown extends StatelessWidget {
//   ConditionSelectionDropDown({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PatientDataProvider>(
//       builder: (context, patientDataProvider, child) {
//         return DropdownButton(
//           items: patientDataProvider.conditionList,
//           onChanged: (value) {
//             patientDataProvider.selectCondition(value);
//           },
//         );
//       },
//     );
//   }
// }
