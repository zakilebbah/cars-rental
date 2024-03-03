import 'package:car_renting/pages/home/homePage.dart';
import 'package:car_renting/pages/logIn/logInPage.dart';
import 'package:car_renting/providers/SignUpProvider.dart';
import 'package:car_renting/utils/utilFunctions.dart';
import 'package:car_renting/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _signUp(SignUpProvider provider) async {
    try {
      if (_formKey.currentState!.validate()) {
        Map msg = await provider.signUpUser(
            _emailController.text, _passController.text, _nameController.text);
        if (mounted) {
          if (msg["type"] == "error") {
            MyFunct.showErrorMessage(msg["message"], context);
          } else {
            MyFunct.showMessage(msg["message"], context);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        MyFunct.showErrorMessage(e.toString(), context);
      }
    }
  }

  // void _signUpGoogle() async {
  //   UserCredential? user = await _authService.signInWithGoogle();
  //   print(
  //       "void _signUpGoogle()oid _signUpGoogle()oid _signUpGoogle()oid _signUpGoogle() ");
  //   if (user != null) {
  //     print(user.user!.email!);
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child:
            Consumer<SignUpProvider>(builder: (context, signUpProvider, child) {
          return Scaffold(
            body: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Text(
                      //   "Sign up with",
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey.shade700,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      //   textAlign: TextAlign.left,
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     GestureDetector(
                      //         onTap: () {
                      //           _signUpGoogle();
                      //         },
                      //         child: Container(
                      //           margin: const EdgeInsets.only(right: 25),
                      //           // padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
                      //           alignment: Alignment.center,
                      //           width: 65,
                      //           height: 65,
                      //           decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius:
                      //                 const BorderRadius.all(Radius.circular(10)),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                   color: Colors.grey.shade300,
                      //                   spreadRadius: 4,
                      //                   blurRadius: 15)
                      //             ],
                      //           ),
                      //           child: const Text(
                      //             "G",
                      //             style: TextStyle(
                      //                 fontSize: 36,
                      //                 color: Color.fromARGB(255, 0, 126, 230),
                      //                 fontWeight: FontWeight.w900),
                      //           ),
                      //         )),
                      //     Container(
                      //       alignment: Alignment.center,
                      //       width: 65,
                      //       height: 65,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius:
                      //             const BorderRadius.all(Radius.circular(10)),
                      //         boxShadow: [
                      //           BoxShadow(
                      //               color: Colors.grey.shade300,
                      //               spreadRadius: 4,
                      //               blurRadius: 15)
                      //         ],
                      //       ),
                      //       child: const Text(
                      //         "F",
                      //         style: TextStyle(
                      //             fontSize: 36,
                      //             color: Color.fromARGB(255, 0, 126, 230),
                      //             fontWeight: FontWeight.w900),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: _nameController,
                          validator: nameValidation,
                          onChanged: nameValidation,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              labelText: 'User Name',
                              hintText: 'Enter Your Name',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              )),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: emailValidation,
                          onChanged: emailValidation,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              labelText: 'Email',
                              hintText: 'Enter Email',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              )),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passController,
                          validator: passwordValidation,
                          onChanged: passwordValidation,
                          obscureText: signUpProvider.passwordVisible,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            labelText: 'Password',
                            hintText: 'Enter Password',
                            errorMaxLines: 4,
                            suffixIcon: IconButton(
                              icon: Icon(signUpProvider.passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                signUpProvider.passVisible();
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(36, 16, 36, 16),
                            backgroundColor:
                                const Color.fromARGB(255, 0, 126, 230),
                            elevation: 0,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          onPressed: () {
                            _signUp(signUpProvider);
                          },
                          child: signUpProvider.loading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Create an Account",
                                  style: TextStyle(fontSize: 20),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          GestureDetector(
                            child: const Text("Log In",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400)),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const LogInPage()),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  )),
                )),
          );
        }));
  }
}
