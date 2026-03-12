import 'package:flutter/material.dart';

class AutoHideKeyboard extends StatelessWidget {
  final Widget child;

  const AutoHideKeyboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    void hideKeyboard() {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return GestureDetector(
      onTap: hideKeyboard,
      // onTapDown: (_) => hideKeyboard(),
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}


// HOW TO USE

/* @override
Widget build(BuildContext context) {
  return AutoHideKeyboard( // Sabse upar wrap karein
    child: Scaffold(
      appBar: AppBar(title: Text("My Form")),
      body: Column(
        children: [
          TextField(decoration: InputDecoration(labelText: "Name")),
          TextField(decoration: InputDecoration(labelText: "Email")),
          // Jab user yahan niche khali jagah tap karega, keyboard hide ho jayega
        ],
      ),
    ),
  );
} */