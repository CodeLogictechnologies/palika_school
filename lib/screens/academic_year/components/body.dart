import 'package:flutter/material.dart';
import 'package:palika_school/widgets/table/custom_button.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  void _handleChangeYear() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text(
              'Academic Year',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              'Changing academic year will affect the whole data.',
              // style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 25),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Academic Year",
              ),
              enabled: false,
              initialValue: '2080',
            ),
            SizedBox(height: 20),
            CustomButtom(text: 'Update', onPressed: _handleChangeYear)
          ],
        )),
      ),
    ));
  }
}
