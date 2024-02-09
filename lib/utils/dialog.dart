import 'package:flutter/material.dart';

import 'mybutton.dart';

class dialoguebox extends StatelessWidget {
  final controller;

  final VoidCallback oncancel;
  final VoidCallback onsave;
  dialoguebox(
      {super.key,
      required this.controller,
      required this.onsave,
      required this.oncancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.purple,
      content: Container(
        height: 120,

        //get user input
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'add a task'),
            ),

            //buttons save and cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                Mybutton(text: 'save', onPressed: onsave),

                const SizedBox(
                  width: 8,
                ),
                //cancel button
                Mybutton(text: 'cancel', onPressed: oncancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
