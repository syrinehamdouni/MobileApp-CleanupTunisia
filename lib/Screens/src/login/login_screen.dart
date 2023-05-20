
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tunisiacleanup/Screens//Screens/Dashboard/timeline.dart';
import 'package:tunisiacleanup/Screens/src/login/signup_screen.dart';
import '../constants/colors.dart';
import '../utils/theme/theme_helper.dart';
import '../utils/widgets/upside.dart';
import 'forgot_password_page.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
                  imgUrl: "assets/images/login/login.png",
                ),
                const PageTitleBar(title: 'Connectez-vous à votre compte'),
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
                        const Text(
                          'CleanUp',
                          style: TextStyle(fontSize: 50,  fontFamily: 'Plante', color: Color(0xFF006064)),
                        ),
                        const Text(
                          "Tunisie",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'OpenSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 30.0),
                        Form(
                            key: _formKey,
                            child: Container(
                              width: 400,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 30,),
                                    Container(
                                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                      child: TextFormField(controller: _emailController,
                                        decoration: ThemeHelper().textInputDecoration('Adresse email', 'Entrer votre Email',),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (val) {
                                          if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                            return "Entrez une adresse mail valide";
                                          }
                                          return null;
                                        },
                                      ),

                                    ),

                                    SizedBox(height: 30.0),
                                    Container(
                                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                      child: TextFormField(controller: _passwordController,
                                        obscureText: true,
                                        decoration: ThemeHelper().textInputDecoration('Mot de passe', 'Entrez votre mot de passe'),
                                        validator: (value) {
                                          RegExp regex = RegExp(r'^.{6,}$');
                                          if (value!.isEmpty) {
                                            return "le mot de passe ne peut pas être vide!";
                                          }
                                          if (!regex.hasMatch(value)) {
                                            return ("entrer un mot de passe valide! ");
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                      ),



                                    const SizedBox(height: 15.0),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10,0,10,20),
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                        },
                                        child: const Text( "Oublié mot de passe?", style: TextStyle( color: Colors.grey, ),
                                        ),
                                      ),
                                    ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: const LinearGradient(colors: [MyColors.primaryColor, MyColors.colorScheme]),
                                  ),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: Text(
                                        'S\'identifier'.toUpperCase(),
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          UserCredential userCredential = await signInWithEmailAndPassword(
                                            _emailController.text.trim(),
                                            _passwordController.text.trim(),
                                          );
                                          // Navigate to the dashboard page
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(builder: (context) => Timeline()),
                                                (route) => false,
                                          );
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'user-not-found') {
                                            showAlertDialog(context, 'Erreur', 'Aucun utilisateur trouvé pour cet e-mail.');
                                          } else if (e.code == 'wrong-password') {
                                            showAlertDialog(context, 'Erreur', 'Mot de passe erroné fourni pour cet utilisateur.');
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ),




                                    Container(
                                      margin: EdgeInsets.fromLTRB(10,20,10,20),
                                      //child: Text('Vous n'avez pas de compte'),
                                      child: Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(text: "Vous n\'avez pas de compte? "),
                                                TextSpan(
                                                  text: 'Créer un compte',
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                                                    },
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.btnColor ),
                                                ),
                                              ]
                                          )
                                      ),
                                    ),
                                  ],
                                )
                            )

                        ),
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




