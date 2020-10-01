import 'package:flutter/material.dart';

class BottomBarTextField extends StatefulWidget {
  final String text;
  final Icon icon;
  final double horMargin;
  final double verMargin;
  final TextInputType inputType;
  final bool isPassword;
  final Function onChanged;
  final Function validator;
  final String errorText;

  BottomBarTextField(
      {this.icon,
      this.horMargin,
      this.verMargin,
      this.inputType,
      this.isPassword = false,
      this.text,
      this.validator,
      this.errorText,
      @required this.onChanged});

  @override
  _BottomBarTextFieldState createState() => _BottomBarTextFieldState();
}

class _BottomBarTextFieldState extends State<BottomBarTextField> {
  bool iconVisibility = false;
  bool visibleIcon = false;

  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.clear();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: widget.horMargin, vertical: widget.verMargin),
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          this.widget.onChanged(value);
        },
        decoration: InputDecoration(
          hintText: widget.text,
          errorText:
              (widget.validator != null && !widget.validator(controller?.text))
                  ? widget.errorText
                  : null,
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
                        color: Theme.of(context).primaryColor,
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
                        color: Theme.of(context).primaryColor,
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
