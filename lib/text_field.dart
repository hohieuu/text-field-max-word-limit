import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    Key key,
    this.maxWordLimit,
  }) : super(key: key);
  final int maxWordLimit;
  @override
  State<MyTextField> createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${textEditingController.text.wordCount}/${widget.maxWordLimit}'),
        TextField(
          controller: textEditingController,
          inputFormatters: [
            WordLimitingTextInputFormatter(maxLength: widget.maxWordLimit)
          ],
          maxLines: 5,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }
}

class WordLimitingTextInputFormatter extends TextInputFormatter {
  final int maxLength;
  WordLimitingTextInputFormatter({this.maxLength});
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (maxLength == null || maxLength < 0) {
      return newValue;
    }
    if (newValue.text.wordCount > maxLength) {
      return oldValue;
    }
    return newValue;
  }
}

extension StringWordCount on String {
  int get wordCount {
    final spaceOrNewLineReg = RegExp(r'[ \s]+');
    final formatted = trim();
    if (formatted.isEmpty) {
      return 0;
    }
    return formatted.split(spaceOrNewLineReg).length;
  }
}
