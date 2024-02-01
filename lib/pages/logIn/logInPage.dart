import 'package:car_renting/pages/SignUp/SignUpPage.dart';
import 'package:car_renting/pages/home/homePage.dart';
import 'package:car_renting/providers/logInProvider.dart';
import 'package:car_renting/utils/utilFunctions.dart';
import 'package:car_renting/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class logInPage extends StatefulWidget {
  const logInPage({super.key});

  @override
  State<logInPage> createState() => _logInPageState();
}

class _logInPageState extends State<logInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> localAuth() async {
    try {
      final LocalAuthentication auth = LocalAuthentication();
      bool isBiometricAvailable = await auth.canCheckBiometrics;
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      if (isBiometricAvailable && availableBiometrics.isNotEmpty) {
        bool authenticated = await auth.authenticate(
          localizedReason: 'Authentication for car renting',
          options: const AuthenticationOptions(
            stickyAuth: true,
          ),
        );
        if (authenticated && mounted) {
          MyFunct.showMessage(
              "Welcome ! ${FirebaseAuth.instance.currentUser!.displayName!}",
              context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        MyFunct.showErrorMessage(e.toString(), context);
      }
    }
  }

  void _initUser() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    _emailController.text = currentUser!.email!;
  }

  @override
  void initState() {
    super.initState();

    if (FirebaseAuth.instance.currentUser != null) {
      _initUser();
      localAuth();
    }
  }

  void _logIn(LogInProvider provider) async {
    try {
      if (_formKey.currentState!.validate()) {
        Map? msg =
            await provider.logIn(_emailController.text, _passController.text);
        if (mounted) {
          if (msg!["type"] == "error") {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child:
            Consumer<LogInProvider>(builder: (context, loginProvider, child) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
              child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 5,
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
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
                              obscureText: loginProvider.passwordVisible,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                labelText: 'Password',
                                hintText: 'Enter Password',
                                errorMaxLines: 4,
                                suffixIcon: IconButton(
                                  icon: Icon(loginProvider.passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    loginProvider.passVisible();
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(36, 16, 36, 16),
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
                                _logIn(loginProvider);
                              },
                              child: loginProvider.loading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      "Log In",
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
                                "Don't have an account?",
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              GestureDetector(
                                child: const Text("Sign Up",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SignUpPage()));
                                },
                              ),
                            ],
                          )
                        ],
                      ))),
            ),
          );
        }));
  }
}
