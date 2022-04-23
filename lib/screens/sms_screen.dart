import 'package:authenticated_app/widget/my_button_widget.dart';
import 'package:authenticated_app/widget/my_textfield_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmsScreen extends StatefulWidget {
  const SmsScreen({Key? key}) : super(key: key);

  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  bool isVisible = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController activeCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('احراز هویت'),
        centerTitle: true,
        leading: const Icon(Icons.sms_outlined),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            MyTextField(
              controller: phoneController,
              hintText: 'شماره تلفن',
              type: TextInputType.number,
            ),
            Visibility(
              visible: isVisible,
              child: MyTextField(
                controller: activeCodeController,
                hintText: 'کد فعال سازی',
                type: TextInputType.number,
              ),
            ),
            ButtonWidget(
              text: isVisible ? 'فعال سازی' : 'ارسال کد',
              onPressed: () {
                setState(() {
                  isVisible = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
