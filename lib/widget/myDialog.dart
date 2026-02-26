import 'package:flutter/material.dart';

class MyDialog extends Dialog {
  final String title;
  final String content;
  final Function()? onTap;

  const MyDialog({
    super.key, 
    required this.title,
    required this.content,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 240,
          height: 240,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title, 
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: onTap,
                        child: Icon(Icons.close),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Text(content, style: TextStyle(fontSize: 14),),
              )
            ],
          ),
        ),
      ),
    );
  }
}