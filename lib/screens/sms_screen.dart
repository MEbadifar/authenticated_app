import 'dart:math';

import 'package:authenticated_app/widget/my_button_widget.dart';
import 'package:authenticated_app/widget/my_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

// ignore: must_be_immutable
class SmsScreen extends StatefulWidget {
  const SmsScreen({Key? key}) : super(key: key);

  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  bool isVisible = false;
  int activeCode = 0;
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
              onPressed: () async {
                if (isVisible == false) {
                  if (phoneController.text.isNotEmpty) {
                    setState(() {
                      isVisible = true;
                      activeCode = 10000 +
                          Random().nextInt(
                              89999); // code random ba 10000 jam mishavad va baraye user as tarigh SMS send mishavad
                      Uri url = Uri.parse(
                          'https://api.kavenegar.com/v1/TOKEN/verify/lookup.json?receptor=PHONE&token=CODE&template=PATTERN');
                      //mesal : 'https://api.kavenegar.com/v1/32494A5670454D75716B4347634E5159374B7A736C6247446D6271784B764C555A6845714A694B717266773D/verify/lookup.json?receptor=${phoneController}&token=${activeCode}&template=hosseini-test');
                      //Bejaye TOKEN meghdare token gerefte shode as site ra vared mikonim
                      //bejaye PHONE ${phoneController} ra midahim
                      //bejaye CODE as ${activeCode} estefade mikonim
                      //bejaye PATTERN as site servise SMS va olgoye tarif shode ,bakhshe name ra estefade mikonim
                      http.post(url);
                    });
                  }
                } else {
                  if (activeCodeController.text == activeCode.toString()) {
                    //save kardane mojaweze worud (code send shode) baraye Telefon nammber
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('isActive', true);

                    //bastane safhe va vared safheye diege mishe
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
