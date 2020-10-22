import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function callback;

  const CalcButton({
    Key key,
    this.text,
    this.fillColor,
    this.textColor = 0xFFFAFBFF,
    this.textSize = 28,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[200].withOpacity(0.2),
            offset: Offset(2.0, 2.0),
            blurRadius: 15.0,
          ),
          BoxShadow(
            color: Colors.grey[200].withOpacity(0.2),
            offset: Offset(-2.0, -2.0),
            blurRadius: 15.0,
          ),
        ],
      ),



      margin: EdgeInsets.all(10),
      child: SizedBox(
        width: 70,
        height: 75,
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: fillColor != null ? Color(fillColor) : null,
          textColor: Color(textColor),

          onPressed: () {
            callback(text);
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: textSize,
            ),
          ),
        ),
      ),
    );
  }
}