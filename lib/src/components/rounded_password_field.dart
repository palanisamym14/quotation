import 'package:flutter/material.dart';
import 'package:quotation/src/components/text_field_container.dart';
import 'package:quotation/src/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final Map<String, String>? setValue;
  final String? name;

  const RoundedPasswordField({
    Key? key,
    this.onChanged,
    this.setValue,
    this.name
  }) : super(key: key);
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isHidden = true;
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: _isHidden,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        validator: passwordValidator,
        onSaved: (val)=> widget.setValue![widget.name!] = val!,
        decoration: InputDecoration(
            hintText: "Password",
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: InkWell(
                onTap: _togglePasswordView,
                child: Icon(
                  _isHidden ? Icons.visibility : Icons.visibility_off,
                  color: kPrimaryColor,
                )),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            )),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
