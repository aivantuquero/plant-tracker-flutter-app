import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:plantapp/preference_service.dart';
import 'package:intl/intl.dart';

class AddPlantForm extends StatefulWidget {
  const AddPlantForm({super.key});

  @override
  State<AddPlantForm> createState() => _AddPlantFormState();
}

class _AddPlantFormState extends State<AddPlantForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  DateTime selectedDate = DateTime.now();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your plant has been added!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('What a marvelous plant you have!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FormBuilder(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              FormBuilderTextField(
                decoration: const InputDecoration(
                  labelText: 'Plant Name',
                  border: OutlineInputBorder(),
                ),
                name: 'plantName',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter plant name';
                  }
                  return null;
                },
                onSaved: (newValue) => print(newValue),
              ),
              const SizedBox(height: 20),
              FormBuilderDropdown(
                decoration: const InputDecoration(
                  labelText: 'Plant Location',
                  border: OutlineInputBorder(),
                ),
                elevation: 3,
                name: 'plantLocation',
                items: const [
                  DropdownMenuItem(
                    value: 'Indoor',
                    child: Text('Indoor'),
                  ),
                  DropdownMenuItem(
                    value: 'Outdoor',
                    child: Text('Outdoor'),
                  ),
                ],
                validator: (value) => value == null || value.isEmpty ? 'Please select location' : null,
                onSaved: (newValue) => print(newValue),
              ),
              const SizedBox(height: 20),
              FormBuilderDateTimePicker(
                name: "buyingDate",
                initialValue: DateTime.now(),
                inputType: InputType.date,
                decoration: const InputDecoration(
                  labelText: "Buying Date",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select buying date';
                  }
                  return null;
                },
                onSaved: (newValue) => print(newValue),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate() && _formKey.currentState!.value['plantLocation'] == 'Indoor') {
                        print(_formKey.currentState!.value);
                        print(_formKey.currentState!.value['plantName']);

                        final List<String>? plantNames = PreferencesService.sharedPreferencesInstance.getStringList('plantNames');
                        final List<String>? plantLocations = PreferencesService.sharedPreferencesInstance.getStringList('plantLocations');
                        final List<String>? buyingDates = PreferencesService.sharedPreferencesInstance.getStringList('buyingDates');

                        if (plantNames == null || plantNames.isEmpty) {
                          await PreferencesService.sharedPreferencesInstance.setStringList('plantNames', [_formKey.currentState!.value['plantName']]);
                          await PreferencesService.sharedPreferencesInstance
                              .setStringList('plantLocations', [_formKey.currentState!.value['plantLocation']]);
                          await PreferencesService.sharedPreferencesInstance.setStringList(
                              'buyingDates', [DateFormat.yMMMEd().format(DateTime.parse(_formKey.currentState!.value['buyingDate'].toString()))]);
                        } else {
                          plantNames.add(_formKey.currentState!.value['plantName']);
                          await PreferencesService.sharedPreferencesInstance.setStringList('plantNames', plantNames);

                          plantLocations!.add(_formKey.currentState!.value['plantLocation']);
                          await PreferencesService.sharedPreferencesInstance.setStringList('plantLocations', plantLocations);

                          buyingDates!.add(DateFormat.yMMMEd().format(DateTime.parse(_formKey.currentState!.value['buyingDate'].toString())));
                          await PreferencesService.sharedPreferencesInstance.setStringList('buyingDates', buyingDates);
                        }
                        print("from add plant form");
                        print(PreferencesService.sharedPreferencesInstance.getStringList('plantLocations'));
                      } else if (_formKey.currentState!.validate() && _formKey.currentState!.value['plantLocation'] == 'Outdoor') {
                        final List<String>? plantNames2 = PreferencesService.sharedPreferencesInstance.getStringList('plantNames2');
                        final List<String>? plantLocations2 = PreferencesService.sharedPreferencesInstance.getStringList('plantLocations2');
                        final List<String>? buyingDates2 = PreferencesService.sharedPreferencesInstance.getStringList('buyingDates2');

                        if (plantNames2 == null || plantNames2.isEmpty) {
                          await PreferencesService.sharedPreferencesInstance
                              .setStringList('plantNames2', [_formKey.currentState!.value['plantName']]);
                          await PreferencesService.sharedPreferencesInstance
                              .setStringList('plantLocations2', [_formKey.currentState!.value['plantLocation']]);
                          await PreferencesService.sharedPreferencesInstance.setStringList(
                              'buyingDates2', [DateFormat.yMMMEd().format(DateTime.parse(_formKey.currentState!.value['buyingDate'].toString()))]);
                        } else {
                          plantNames2.add(_formKey.currentState!.value['plantName']);
                          await PreferencesService.sharedPreferencesInstance.setStringList('plantNames2', plantNames2);

                          plantLocations2!.add(_formKey.currentState!.value['plantLocation']);
                          await PreferencesService.sharedPreferencesInstance.setStringList('plantLocations2', plantLocations2);

                          buyingDates2!.add(DateFormat.yMMMEd().format(DateTime.parse(_formKey.currentState!.value['buyingDate'].toString())));
                          await PreferencesService.sharedPreferencesInstance.setStringList('buyingDates2', buyingDates2);
                        }
                        print("from add plant form");
                        print(_formKey.currentState!.value['plantLocation']);
                        print(PreferencesService.sharedPreferencesInstance.getStringList('plantLocations2'));
                      }
                      await _showMyDialog();
                      _formKey.currentState!.reset();
                    },
                    child: const Text('Submit'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
