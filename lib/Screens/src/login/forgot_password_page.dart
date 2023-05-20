
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/theme/theme_helper.dart';
import '../utils/widgets/upside.dart';
import 'forgot_password_verification_page.dart';
import 'login_screen.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {

      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen()
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('A password reset link has been sent to your email'),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      }
      setState(() {
        _isLoading = false;
      });
    }
  }


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
                  imgUrl: "assets/images/login/Password.png",
                ),
                const PageTitleBar(title: 'Récupération de mot de passe'),
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
                            margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Oublié mot de passe?',
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF006064)
                                        ),
                                        // textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 10,),
                                      Text('Entrez l\'adresse e-mail associé à votre compte.',
                                        style: TextStyle(
                                          // fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54
                                        ),
                                        // textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 10,),
                                      Text('Nous vous enverrons un code de vérification par e-mail pour vérifier votre authenticité.',
                                        style: TextStyle(
                                          color: Colors.black38,
                                          // fontSize: 20,
                                        ),
                                        // textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40.0),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: TextFormField(controller: _emailController,
                                          decoration: ThemeHelper().textInputDecoration("Email", "Entrez l\'adresse e-mail"),
                                          keyboardType: TextInputType.emailAddress,
                                          validator: (val){
                                            if (val == null || val.isEmpty){
                                              return "L\'email ne peut pas être vide";
                                            }
                                            else if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                              return "Entrez une adresse mail valide";
                                            }
                                            return null;
                                          },
                                        ),
                                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                      ),
                                      SizedBox(height: 40.0),
                                      Container(
                                        decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          gradient: new LinearGradient(colors: [MyColors.primaryColor, MyColors.colorScheme]),
                                        ),
                                        child: ElevatedButton(
                                          style: ThemeHelper().buttonStyle(),
                                          onPressed: _isLoading ? null : _resetPassword,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                            child: _isLoading
                                                ? CircularProgressIndicator()
                                                : Text(
                                              'Envoyer'.toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),


                                      SizedBox(height: 30.0),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(text: "Rappelez-vous votre mot de passe? "),
                                            TextSpan(
                                              text: 'Connexion',
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => LoginScreen()),
                                                  );
                                                },
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,color: MyColors.btnColor
                                              ),
                                            ),
                                          ],
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