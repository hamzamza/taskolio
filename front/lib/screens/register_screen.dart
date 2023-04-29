import 'package:flutter/material.dart';
import 'package:front/controllers/auth_controller.dart';
import 'package:front/helpers/colors.dart';
import 'package:front/screens/login_scren.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key});

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
                height: size.height * 0.7,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Text(
                          "Register and start managing your tasks with ease",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            textStyle: TextStyle(
                              shadows: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.5),
                                  spreadRadius: 10,
                                  blurRadius: 20,
                                  // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GetBuilder<AuthController>(builder: (auth) {
                        return Column(children: [
                          CustomTextField(
                            hint: "Username",
                            onChange: (value) {
                              auth.setUsername(value);
                            },
                          ),
                          CustomTextField(
                            hint: "Email",
                            onChange: (value) {
                              auth.setEmail(value);
                            },
                          ),
                          CustomTextfieldsecret(
                            hint: "Password",
                            onchange: (value) {
                              auth.setPassword(value);
                            },
                          ),
                          CustomTextfieldsecret(
                            hint: "Confurm Password",
                            onchange: (value) {
                              auth.setCopyPassword(value);
                            },
                          ),
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
                                List<dynamic> registered =
                                    await auth.register();
                                if (registered[0] == true) {
                                  Get.back();
                                } else {
                                  Get.snackbar(
                                      "Registration Error", registered[1],
                                      backgroundColor: Colors.red[300],
                                      colorText: LightGrey,
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2),
                                      animationDuration:
                                          const Duration(milliseconds: 100),
                                      margin: const EdgeInsets.all(20),
                                      icon: Icon(Icons.dangerous_sharp));
                                }
                              },
                              child: Container(
                                child: auth.Iswaiting
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          "Register",
                                          style: GoogleFonts.roboto(
                                            color: LightGrey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
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
                                    "Already have an Account ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const LoginScreen());
                                    },
                                    child: const Text(
                                      "Sign In",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 247, 79, 67)),
                                    ),
                                  )
                                ],
                              )),
                        ]);
                      })
                    ]))));
  }
}
