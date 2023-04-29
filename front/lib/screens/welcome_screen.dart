import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/helpers/colors.dart';
import 'package:front/screens/login_scren.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: LightGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Welcome to Taskolio!",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              textAlign: TextAlign.center,
              " The perfect app to help you manage all your tasks and projects in one place.",
              style: GoogleFonts.roboto(
                color: Colors.grey[200],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          SvgPicture.asset(
            "assets/icons/welcome.svg",
            height: size.height * 0.45,
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
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                minimumSize: Size.zero),
            onPressed: () {
              Get.to(LoginScreen());
            },
            child: Container(
              child: Text(
                "Get Started ",
                style: GoogleFonts.roboto(
                  color: LightGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
