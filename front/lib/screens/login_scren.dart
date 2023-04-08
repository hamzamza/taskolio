import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/controllers/auth_controller.dart';
import 'package:front/helpers/colors.dart';
import 'package:front/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScrollController _scrollController = ScrollController();
    return Scaffold(
        backgroundColor: LightGrey,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Ready to get things done? Login and start managing your tasks with ease",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
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
                  late String username = '';
                  late String password = '';
                  return auth.Iswaiting
                      ? Container(
                          height: 160,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          ),
                        )
                      : Container(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Focus(
                                  onFocusChange: (isFocused) {
                                    if (isFocused) {
                                      // scroll to the bottom of the screen
                                      _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeIn,
                                      );
                                    }
                                  },
                                  child: TextField(
                                    onChanged: (value) {
                                      username = value;
                                      //TODO: onchange
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: "  Username ",
                                        hintStyle:
                                            TextStyle(color: Colors.white38)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Focus(
                                  onFocusChange: (isFocused) {
                                    if (isFocused) {
                                      // scroll to the bottom of the screen
                                      _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeIn,
                                      );
                                    }
                                  },
                                  child: TextField(
                                    onChanged: (value) {
                                      password = value;
                                      // TODO: onchage
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: "  Password ",
                                        hintStyle:
                                            TextStyle(color: Colors.white38)),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    foregroundColor: LightBlack,
                                    backgroundColor: Colors.red[300],
                                    alignment: Alignment.centerLeft,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 60, vertical: 18),
                                    minimumSize: Size.zero),
                                onPressed: () async {
                                  bool logedin =
                                      await auth.login(username, password);
                                  if (logedin == true) {
                                    Get.to(MainScreen());
                                  }
                                  //TODO:  PROCESS LOGIN
                                },
                                child: Container(
                                  child: Text("Login",
                                      style: GoogleFonts.roboto(
                                        color: LightGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                })
              ],
            ),
          ),
        ));
  }
}
