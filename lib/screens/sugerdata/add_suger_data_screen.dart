import 'package:flutter/material.dart';
import 'package:gluco_mate/widgets/common_text_form_field.dart';

class AddSugerDataScreen extends StatefulWidget {
  AddSugerDataScreen({super.key});

  @override
  State<AddSugerDataScreen> createState() => _AddSugerDataScreenState();
}

class _AddSugerDataScreenState extends State<AddSugerDataScreen> {
  final sugerLevelController = TextEditingController();

  List<DropdownMenuItem<String>> conditionList = const [
    DropdownMenuItem(
      value: 'Morning Before Breakfast',
      child: Text('Morning Before Breakfast'),
    ),
    DropdownMenuItem(
      value: 'Morning After 2 Hours',
      child: Text('Morning After 2 Hours'),
    ),
    DropdownMenuItem(
      value: 'Afternoon Before Lunch',
      child: Text('Afternoon Before Lunch'),
    ),
    DropdownMenuItem(
      value: 'Afternoon After 2 hours',
      child: Text('Afternoon After 2 hours'),
    ),
    DropdownMenuItem(
      value: 'Evening Before Dinner',
      child: Text('Evening Before Dinner'),
    ),
    DropdownMenuItem(
      value: 'Evening After 2 Hours',
      child: Text('Evening After 2 Hours'),
    ),
    DropdownMenuItem(
      value: 'Mid Night',
      child: Text('Mid Night'),
    ),
  ];

  String? selectedCondition = 'Morning Before Breakfast';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        leading: Icon(Icons.close, size: 30,),
        title: const Text(
          'New Record',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Divider(),
                ),
                const SizedBox(width: 12,),
                const Text(
                  'Condition',
                  style: TextStyle(fontSize: 16, color: Colors.black26,fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 12,),
                const Expanded(
                  child: Divider(),
                ),
              ],
            )
            ,const SizedBox(height: 18),
            Center(
              child: Container(
                width: 220, // Set a fixed width for the dropdown
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black12,
                ),
                child: DropdownButton<String>(
                  menuMaxHeight: 300,
                  value: selectedCondition,
                  items: conditionList,
                  onChanged: (value) {
                    setState(() {
                      selectedCondition = value;
                    });
                  },
                  isExpanded: true,
                  icon: Padding(
                    padding: const EdgeInsets.only(right:4.0),
                    child: const Icon(Icons.arrow_drop_down, color: Colors.grey, size: 28,),
                  ),
                  dropdownColor: Colors.white,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  iconSize: 20,
                  selectedItemBuilder: (BuildContext context) {
                    return conditionList.map<Widget>((DropdownMenuItem<String> item) {
                      return Center(
                        child: Text(
                          item.value!,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            CommonTextFormField(
              controller: sugerLevelController,
            ),
          ],
        ),
      ),
    );
  }
}
