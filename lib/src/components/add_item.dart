import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// import 'package:intl/intl.dart';
typedef void SignalingStateCallback(dynamic data);

class AddItemForm extends StatefulWidget {
  final List<Map<String, dynamic>>? columns;
  Map<String, dynamic> initValues;
  final String header;
  final String actionLabel;
  final bool isCallBack;
  final SignalingStateCallback? callBack;
  AddItemForm(
      {this.columns,
      required this.initValues,
      required this.header,
      this.isCallBack =false,
      this.callBack,
      this.actionLabel = 'Submit'});

  @override
  AddItemFormState createState() {
    return AddItemFormState();
  }
}

class AddItemFormState extends State<AddItemForm> {
  bool autoValidate = true;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  dynamic getFormValue(GlobalKey<FormBuilderState> form, String field) {
    if(form.currentState!.fields.containsKey(field) == false)
      return null;
    else {
       // !["currentState"]["value"];
      return form.currentState!.fields[field];
    }
  }

  void setFormValue(GlobalKey<FormBuilderState> form, String field, dynamic value) {
    if(form == null || form.currentState!.fields.containsKey(field) == false)
      return;

    setState(() {
      // form.currentState?.setAttributeValue(field, value);
    });
  }

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
                              if (widget.isCallBack) {
                                widget.callBack!(_formKey.currentState?.value);
                              } else {
                                Navigator.pop(
                                    context, _formKey.currentState?.value);
                              }
                            } else {
                              print(_formKey.currentState?.value);
                              print('validation failed');
                            }
                          },
                          child: Text(
                            widget.actionLabel,
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
          onChanged: (val) {
            getFormValue(_formKey, "totalPrice");
          },
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
