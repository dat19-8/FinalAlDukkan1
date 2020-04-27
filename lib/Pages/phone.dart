import 'package:finaldukkan1/globals.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Pages/page3.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhonePage extends StatelessWidget{

  String _smsVerificationCode;


  _verifyPhoneNumber(BuildContext context) async {
    phoneNumber = "+961" + _phoneNumberController.text;
    print('phoneNumber : $phoneNumber');
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 5),
        verificationCompleted: (authCredential) => _verificationComplete(authCredential, context),
        verificationFailed: (authException) => _verificationFailed(authException, context),
        codeAutoRetrievalTimeout: (verificationId) => _codeAutoRetrievalTimeout(verificationId),
        // called when the SMS code is sent
        codeSent: (verificationId, [code]) => _smsCodeSent(verificationId, [code]));
  }
  _verificationComplete(AuthCredential authCredential, BuildContext context) {
    print('in _verificationComplete');
    FirebaseAuth.instance.signInWithCredential(authCredential).then((authResult) {
      final snackBar = SnackBar(content: Text("Success!!! UUID is: " + authResult.user.uid));
      Scaffold.of(context).showSnackBar(snackBar);

    });

//print (phoneNumber);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>ThirdPage())
    );
  }

  _smsCodeSent(String verificationId, List<int> code) {
    // set the verification code so that we can use it to log the user in
    _smsVerificationCode = verificationId;
  }

  _verificationFailed(AuthException authException, BuildContext context) {
    final snackBar = SnackBar(content: Text("Exception!! message:" + authException.message.toString()));
    Scaffold.of(context).showSnackBar(snackBar);

  }

  _codeAutoRetrievalTimeout(String verificationId) {
    // set the verification code so that we can use it to log the user in
    _smsVerificationCode = verificationId;

  }

  final TextEditingController _phoneNumberController =
  new TextEditingController();




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(27, 38, 44, 100),
        title: Center(
          child: Text(
            'الدكان',
            style: TextStyle(color: Colors.white, fontSize: 50.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                  child: Image.asset("images/cart-512.png"),
                  padding: EdgeInsets.only(top:20.0),
                  width: 180.0,
                  height: 180.0,
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "أدخل رقم هاتفك",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),

                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 50.0,
                  padding: EdgeInsets.only(left:55.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberController,
                    cursorColor: Colors.black,
                    autofocus: true,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), 
                    decoration: InputDecoration(  
                      border: InputBorder.none,
                      hintText: 'Phone Number', 
                      hintStyle: TextStyle(color: Color.fromRGBO(200, 200, 200, 100)),
                      prefix: Container(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "+961",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    
                    autovalidate: true,
                    autocorrect: false,
                    maxLengthEnforced: true,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: 175.0,
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: RaisedButton(
                        color: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          "واصل",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (_phoneNumberController.text.length != 8) {
                            Alert(
                                context: context,
                                title: 'رقم الهاتف غير صحيح')
                                .show();
                          } else {
                            
                            tempPhone = "+961" + _phoneNumberController.text;
                            print("tempPhone: $tempPhone");
                            // _verifyPhoneNumber(context);
                            Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => ThirdPage()));
                          }
                        },

                        padding: EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
