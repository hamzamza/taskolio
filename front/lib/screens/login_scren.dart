import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/controllers/auth_controller.dart';
import 'package:front/helpers/colors.dart';
import 'package:front/screens/main_screen.dart';
import 'package:front/screens/register_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScrollController _scrollController = ScrollController();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: size.width,
          leading: Container(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      " Taskol.",
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      "io",
                      style: GoogleFonts.robotoMono(
                        color: goodRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              )),
          backgroundColor: LightGrey,
        ),
        backgroundColor: LightGrey,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "  Login and start managing your tasks with ease",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        textStyle: TextStyle(shadows: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.5),
                            spreadRadius: 10,
                            blurRadius: 20,
                            // changes position of shadow
                          ),
                        ])),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset("assets/icons/loginsvg.svg",
                    width: size.width),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<AuthController>(builder: (auth) {
                  return Column(
                    children: [
                      CustomTextField(
                        hint: " username ",
                        onChange: (value) {
                          auth.setUsername(value);
                        },
                      ),
                      CustomTextfieldsecret(
                          onchange: (value) {
                            auth.setPassword(value);
                            // TODO: onchage
                          },
                          hint: " password "),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            foregroundColor: LightBlack,
                            backgroundColor: Colors.red[300],
                            alignment: Alignment.centerLeft,
                            elevation: 10,
                            shadowColor: Colors.red[300],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 18),
                          ),
                          onPressed: () async {
                            bool logedin = await auth.login();
                            if (logedin == true) {
                              Get.to(const MainScreen());
                            } else {
                              Get.snackbar(
                                "Login Error",
                                "Invalid username or password",
                                backgroundColor: Colors.red[400],
                                colorText: LightGrey,
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 5),
                                animationDuration:
                                    const Duration(milliseconds: 500),
                                margin: const EdgeInsets.all(20),
                              );
                            }
                            //TODO:  PROCESS LOGIN
                          },
                          child: Container(
                            child: auth.Iswaiting
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                    ),
                                  )
                                : Center(
                                    child: Text("Login",
                                        style: GoogleFonts.roboto(
                                          color: LightGrey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  ),
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account yet ",
                                style: TextStyle(color: Colors.white),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(const RegisterScreen());
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 247, 79, 67)),
                                ),
                              )
                            ],
                          ))
                    ],
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                    child: Text(
                  "or Sign In with",
                  style: TextStyle(color: Colors.white),
                )),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset(
                          "assets/images/facebook.png",
                          width: 65,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset(
                          "assets/images/google.png",
                          width: 65,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class CustomTextField extends StatefulWidget {
  final Function onChange;
  final String hint;

  const CustomTextField({
    Key? key,
    required this.onChange,
    required this.hint,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late String _text;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _text = '';
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _isFocused ? goodRed : Colors.transparent,
          width: 2,
        ),
        color: const Color.fromARGB(69, 163, 163, 163),
      ),
      child: TextField(
        focusNode: _focusNode,
        onChanged: (value) {
          setState(() {
            _text = value;
          });
          widget.onChange(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.white38),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class CustomTextfieldsecret extends StatefulWidget {
  CustomTextfieldsecret({
    Key? key,
    required this.onchange,
    required this.hint,
  }) : super(key: key);

  final Function onchange;
  final String hint;

  @override
  _CustomTextfieldsecretState createState() => _CustomTextfieldsecretState();
}

class _CustomTextfieldsecretState extends State<CustomTextfieldsecret> {
  bool eyeopen = false;
  bool isFocused = false;

  @override
  void initState() {
    eyeopen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isFocused ? goodRed : Colors.transparent,
          width: 2,
        ),
        color: const Color.fromARGB(69, 163, 163, 163),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                widget.onchange(value);
              },
              obscureText: !eyeopen,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: const TextStyle(color: Colors.white38),
              ),
              style: const TextStyle(color: Colors.white),
              onTap: () {
                setState(() {
                  isFocused = true;
                });
              },
              onTapOutside: (value) {
                setState(() {
                  isFocused = false;
                });
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                eyeopen = !eyeopen;
              });
            },
            child: eyeopen
                ? const Icon(
                    Icons.remove_red_eye,
                    color: goodRed,
                  )
                : const Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                  ),
          ),
        ],
      ),
    );
  }
}
