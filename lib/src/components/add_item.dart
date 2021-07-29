import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:quotation/src/components/profile_image.dart';
// import 'package:intl/intl.dart';

class AddItemForm extends StatefulWidget {
  final List<Map<String, dynamic>>? columns;
  Map<String, dynamic> initValues;
  final String header;
  AddItemForm({this.columns, required this.initValues, required this.header});

  @override
  AddItemFormState createState() {
    return AddItemFormState();
  }
}

class AddItemFormState extends State<AddItemForm> {
  bool autoValidate = true;
  final _formKey = GlobalKey<FormBuilderState>();

  // final ValueChanged _onChanged = (val) => print(val);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.header, textAlign: TextAlign.center),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _formKey,
                    // enabled: false,
                    autovalidateMode: AutovalidateMode.disabled,
                    initialValue: widget.initValues,
                    skipDisabled: true,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 15),
                        new ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.columns?.length,
                            itemBuilder: (context, index) {
                              return getFormField(widget.columns![index]);
                            })
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          color: Theme.of(context).colorScheme.secondary,
                          onPressed: () {
                            if (_formKey.currentState?.saveAndValidate() ??
                                false) {
                              print(_formKey.currentState?.value);
                              Navigator.pop(
                                  context, _formKey.currentState?.value);
                            } else {
                              print(_formKey.currentState?.value);
                              print('validation failed');
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _formKey.currentState?.reset();
                          },
                          // color: Theme.of(context).colorScheme.secondary,
                          child: Text(
                            'Reset',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  getFormField(Map<String, dynamic> column) {
    final type = column["type"];
    switch (type) {
      case "text":
        return FormBuilderTextField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          name: column["_key"],
          decoration: InputDecoration(
            labelText: column["label"],
          ),
          onChanged: (val) {},
          validator: column["isRequired"]
              ? column["keyboardType"] == TextInputType.number
                  ? FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                    ])
                  : FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ])
              : FormBuilderValidators.compose([]),
          keyboardType: column["keyboardType"],
          textInputAction: TextInputAction.next,
        );
      case "profile":
      case "image":
        return Text('Default'); //ProfileImage(imagePath: "");
      case "list":
        return Text('Default');
      default:
        return FormBuilderTextField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          name: column["_key"],
          decoration: InputDecoration(
            labelText: column["label"],
          ),
          onChanged: (val) {},
        );
    }
  }
}
