import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Number Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SFUIDisplay',
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool showNextStep = false;
  bool showClearIcon = false;
  String unformattedText;
  TextEditingController _phoneNumberController = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});

  void _validatePhoneNumber(String text) {
    unformattedText = maskFormatter.getUnmaskedText();
    setState(() {
      showNextStep = unformattedText.length == 10 ? true : false;
      showClearIcon = unformattedText.length > 0 ? true : false;
    });
  }

  void _clearText() {
    setState(() {
      _phoneNumberController.clear();
      unformattedText = '';
      showNextStep = false;
      showClearIcon = false;
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get Started',
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: 120.0,
            ),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              onChanged: _validatePhoneNumber,
              inputFormatters: [maskFormatter],
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: showClearIcon ? Icon(Icons.clear) : Container(),
                  color: Colors.black54,
                  onPressed: _clearText,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                ),
                hintText: '(201) 555-0123',
                hintStyle: TextStyle(color: Colors.black38),
                helperText: 'Enter your phone number',
                helperStyle: TextStyle(fontSize: 14.0, color: Colors.black38),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 60,
                height: 60,
                //alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: showNextStep
                        ? Colors.blue.shade500
                        : Colors.grey.shade300,
                    //primary: showNextStep ? Colors.blue : Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  onPressed: () {
                    print('Next Step');
                  },
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
