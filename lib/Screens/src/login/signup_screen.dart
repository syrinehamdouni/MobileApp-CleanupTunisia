import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tunisiacleanup/Screens/src/features/authentication/screens/splash_screen.dart';
import '../constants/colors.dart';
import '../utils/theme/theme_helper.dart';
import '../utils/widgets/upside.dart';
import 'package:tunisiacleanup/Screens//Screens/Dashboard/timeline.dart';

import 'login_screen.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkedValue = false;
  bool checkboxValue = false;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  final _firestore = FirebaseFirestore.instance;

  void onReady(){
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }



  //les controlleurs
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  void registerUeser(String _email,
  String _password,String _nom, String _prenom){

  }



  CollectionReference users =
  FirebaseFirestore.instance.collection('userscitoyen');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'Nom': _nomController.text,
      'prenom': _prenomController.text,
      'email': _emailController.text,
      'password': _passwordController.text, // 42
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
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
                  imgUrl: "assets/images/login/Profile.png",
                ),
                const PageTitleBar(title: 'Créer un nouveau compte'),
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
                          height: 20,
                        ),
                        const Text(
                          'CleanUp',
                          style: TextStyle(fontSize: 50,  fontFamily: 'Plante',color: Color(0xFF006064)),
                        ),
                        const Text(
                          "Tunisie",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'OpenSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),

                        SizedBox(height: 10.0),
                        Form(
                          key: _formKey,
                          child: Container(
                            width: 400,
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                Container(
                                  child: TextFormField(
                                    controller: _nomController,
                                    decoration: ThemeHelper().textInputDecoration('Nom ', 'Entrez votre nom de famille'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Champ obligatoire vide !";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      _nomController.text = value!;
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),

                                SizedBox(height: 30,),
                                Container(
                                  child: TextFormField(controller: _prenomController,
                                    decoration: ThemeHelper().textInputDecoration('Prénom', 'Entrez votre prénom'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Champ obligatoire vide !";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      _prenomController.text = value!;
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                  child: TextFormField(controller: _emailController,
                                    decoration: ThemeHelper().textInputDecoration("Adresse email", "Entrez votre email"),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (val) {
                                      if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                        return "Entrez une adresse mail valide";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _emailController.text = value!;
                                    },
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),

                                SizedBox(height: 20.0),
                                Container(
                                  child: TextFormField(
                                    controller: _passwordController,
                                        decoration: ThemeHelper().textInputDecoration('Mot de passe', 'Entrez votre mot de passe'),
                                      obscureText: true,
                                      validator: (value) {
                                        RegExp regex = RegExp(r'^.{6,}$');
                                        if (value!.isEmpty) {
                                          return "le mot de passe ne peut pas être vide!";
                                        }
                                        if (!regex.hasMatch(value)) {
                                          return ("le mot de passe doit contenir plus de 6 caracters! ");
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        _passwordController.text = value!;
                                      },
                                      keyboardType: TextInputType.visiblePassword),

                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),

                                SizedBox(height: 15.0),
                                FormField<bool>(
                                  builder: (state) {
                                    return Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Checkbox(
                                                value: checkboxValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    checkboxValue = value!;
                                                    state.didChange(value);
                                                  });
                                                }),
                                            Text("J'accepte tous les termes et conditions.", style: TextStyle(color: Colors.grey),),
                                          ],
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            state.errorText ?? '',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(color: Theme.of(context).colorScheme.error,fontSize: 12,),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  validator: (value) {
                                    if (!checkboxValue) {
                                      return 'Vous devez accepter les termes et conditions';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),

                            SizedBox(height: 20.0),
                            Container(
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: new LinearGradient(
                                  colors: [MyColors.primaryColor, MyColors.colorScheme],
                                ),
                              ),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    "Créer un Compte".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      addUser();
                                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                      print("created successfully");
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => Timeline()),
                                      );
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'email-already-in-use') {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Email déjà utilisé"),
                                              content: Text(
                                                "Cet email est déjà associé à un compte. Veuillez utiliser un autre email.",
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text("OK"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        print("Error ${e.toString()}");
                                      }
                                    } catch (e) {
                                      print("Error ${e.toString()}");
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
                                            TextSpan(text: "Vous avez déja un  compte? "),
                                            TextSpan(
                                              text: 'Connexion',
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                                },
                                              style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.btnColor ),
                                            ),
                                          ]
                                      )
                                  ),
                                ),


                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
            ]
      ),)
    )));
  }

  _setInitialScreen(User? user) {
    user == null ?Get.offAll(() => SplashScreen(title: 'CleanUp',)): Get.offAll(() => Timeline());
  }
}
