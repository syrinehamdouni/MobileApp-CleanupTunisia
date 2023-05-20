
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../constants/colors.dart';
import 'package:tunisiacleanup/Screens//Screens/Dashboard/timeline.dart';
import '../utils/theme/theme_helper.dart';
import '../utils/widgets/upside.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  const ForgotPasswordVerificationPage({super.key});

  @override
  _ForgotPasswordVerificationPageState createState() =>
      _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState
    extends State<ForgotPasswordVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _pinSuccess = false;
  String _verificationCode = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(
                  imgUrl: "assets/images/login/verification.png",
                ),
                const PageTitleBar(title: 'Vérification de mot de passe'),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SafeArea(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Vérification',
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF006064)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Entrez le code de vérification que nous venons de vous envoyer sur votre adresse e-mail.',
                                        style: TextStyle(
                                          // fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40.0),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      OTPTextField(
                                        length: 4,
                                        width: 300,
                                        fieldWidth: 50,
                                        style: const TextStyle(fontSize: 30),
                                        textFieldAlignment:
                                        MainAxisAlignment.spaceAround,
                                        fieldStyle: FieldStyle.underline,
                                        onCompleted: (pin) {
                                          setState(() {
                                            _verificationCode = pin;
                                            _pinSuccess = true;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 50.0),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: "Si vous n'avez pas reçu de code! ",
                                              style: TextStyle(
                                                color: Colors.black38,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Renvoyer',
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return ThemeHelper().alartDialog("Réussi",
                                                          "Code de vérification renvoyé avec succès.",
                                                          context);
                                                    },
                                                  );
                                                },
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 40.0),
                                      Container(
                                        decoration: _pinSuccess ?  BoxDecoration(
                                            gradient: const LinearGradient( colors: [MyColors.primaryColor,MyColors.colorScheme],), borderRadius: BorderRadius.circular(15)):ThemeHelper().buttonBoxDecoration(context, "#AAAAAA","#757575"),
                                        child: ElevatedButton(
                                          style: ThemeHelper().buttonStyle(),
                                          onPressed: _pinSuccess ? () {
                                            Navigator.of(context).pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) => const Timeline()
                                                ),
                                                    (Route<dynamic> route) => false
                                            );
                                          } : null,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                40, 10, 40, 10),
                                            child: Text(
                                              "Vérifier".toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}