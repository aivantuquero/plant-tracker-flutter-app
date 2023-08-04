import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:convert';
import 'package:plantapp/preference_service.dart';
import 'package:intl/intl.dart';

class ReminderForm extends StatefulWidget {
  final int index;
  final String plantName;

  const ReminderForm({super.key, required this.index, required this.plantName});
  @override
  State<ReminderForm> createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Reminder"),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: FormBuilder(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  FormBuilderTextField(
                      name: 'plantName',
                      initialValue: widget.plantName,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'Plant Name', border: OutlineInputBorder())),
                  const SizedBox(height: 20),
                  FormBuilderDateTimePicker(
                    name: "timeToRemind",
                    initialValue: DateTime.now(),
                    inputType: InputType.both,
                    decoration: const InputDecoration(
                      labelText: "Time to remind",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  FormBuilderCheckbox(
                    name: "repeat",
                    initialValue: false,
                    title: const Text("Repeat everyday"),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState?.save();
                      if (_formKey.currentState?.validate() ?? false) {
                        final List<String>? plantReminders = PreferencesService.sharedPreferencesInstance.getStringList('remindDatas');
                        var remindData = {
                          'plantName': _formKey.currentState?.value['plantName'],
                          'timeToRemind': DateFormat('yyyy-MM-dd HH:mm:ss').format(_formKey.currentState?.value['timeToRemind']),
                          'repeat': _formKey.currentState?.value['repeat']
                        };
                        String remindDataString = jsonEncode(remindData);
                        if (plantReminders == null) {
                          await PreferencesService.sharedPreferencesInstance.setStringList('remindDatas', [remindDataString]);
                        } else {
                          plantReminders.add(remindDataString);
                          await PreferencesService.sharedPreferencesInstance.setStringList('remindDatas', plantReminders);
                        }
                      } else {
                        print("validation failed");
                      }
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
