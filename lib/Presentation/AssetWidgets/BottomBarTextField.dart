import 'package:flutter/material.dart';

class BottomBarTextField extends StatefulWidget {
  final String text;
  final Icon icon;
  final double horMargin;
  final double verMargin;
  final TextInputType inputType;
  final bool isPassword;
  final Function onChanged;

  BottomBarTextField(
      {this.icon,
      this.horMargin,
      this.verMargin,
      this.inputType,
      this.isPassword = false,
      this.text,
      @required this.onChanged});

  @override
  _BottomBarTextFieldState createState() => _BottomBarTextFieldState();
}

class _BottomBarTextFieldState extends State<BottomBarTextField> {
  bool iconVisibility = false;
  bool visibleIcon = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: widget.horMargin, vertical: widget.verMargin),
      child: TextFormField(
        onChanged: this.widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.text,
          prefixIcon: this.widget.icon,
          suffix: (iconVisibility)
              ? (visibleIcon)
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          visibleIcon = !visibleIcon;
                        });
                      },
                      child: Icon(
                        Icons.visibility,
                        color: Color(0xffff4f18),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          visibleIcon = !visibleIcon;
                        });
                      },
                      child: Icon(
                        Icons.visibility_off,
                        color: Color(0xffff4f18),
                      ),
                    )
              : null,
        ),
        keyboardType: widget.inputType,
        obscureText: (widget.isPassword) ? (visibleIcon) ? false : true : false,
        onTap: () {
          setState(() {
            if (widget.isPassword == true) {
              iconVisibility = true;
            }
          });
        },
      ),
    );
  }
}
