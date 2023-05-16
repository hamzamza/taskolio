import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:front/helpers/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/background_profile_screen.png",
              ),
              alignment: Alignment.topCenter)),
      padding: const EdgeInsets.only(
        top: 25,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Column(
          children: [
            //Custom app bar
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 15, bottom: 50, left: 20),
                child: Row(children: [
                  clickedIcon(const Icon(Icons.arrow_back_ios_new_outlined), 13,
                      () {}, const Color.fromARGB(52, 0, 0, 0))
                ])),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.only(top: 120),
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                        color: Lightwhite,
                      ),
                      //TODO: fatimas part add list of text fields
                      child: Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  border: Border.all(
                                      width: 1, color: Colors.redAccent)),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    MyCustomForm(
                                      hinttext: "Username",
                                      icon:
                                          const Icon(Icons.verified_user_sharp),
                                      label: "username",
                                      onchange: (value) {},
                                      inittext: "",
                                    ),
                                    MyCustomForm(
                                      hinttext: "Email",
                                      icon: const Icon(Icons.email),
                                      label: "Email",
                                      onchange: (value) {},
                                      inittext: "",
                                    ),
                                    MyCustomForm(
                                      hinttext: "Password",
                                      icon: const Icon(Icons.lock),
                                      label: "Password",
                                      onchange: (value) {},
                                      inittext: "",
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: const Size.fromHeight(60),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.edit_note_rounded,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "submit",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size.fromHeight(60),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    backgroundColor: Colors.red[700],
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "logout",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: -60,
                      child: Stack(
                        children: [
                          rowndedImage(
                              "assets/images/user_image.jpeg", 120, context),
                          Positioned(
                            child: clickedIcon(
                                const Icon(Icons.edit_outlined), 4, () {
// upload image screen
                              showDialog(
                                barrierColor:
                                    const Color.fromARGB(186, 0, 0, 0),
                                context: context,
                                builder: (BuildContext context) {
                                  return const UploadImageScreeen();
                                },
                              );
// end upload image screen
                            }, Colors.blue),
                            bottom: 0,
                            right: 0,
                          )
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

// components
clickedIcon(Icon icon, double padding, Function whenClickDo, color) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          foregroundColor: Colors.black87,
          backgroundColor: color,
          alignment: Alignment.centerLeft,
          elevation: 0,
          padding: EdgeInsets.all(padding),
          minimumSize: Size.zero),
      onPressed: () {
        whenClickDo();
      },
      child: Container(
        child: icon,
      ),
    );

Widget rowndedImage(String url, double? size, context) => Container(
    decoration: const BoxDecoration(
        color: Lightwhite,
        borderRadius: BorderRadius.all(Radius.circular(700))),
    child: GestureDetector(
      onTap: () {
        showDialog(
          barrierColor: const Color.fromARGB(186, 0, 0, 0),
          context: context,
          builder: (BuildContext context) {
            return ImagePopup(imageUrl: url);
          },
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(700))),
        child: Image.asset(
          url,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    ));

class ImagePopup extends StatelessWidget {
  final String imageUrl;

  const ImagePopup({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class UploadImageScreeen extends StatelessWidget {
  const UploadImageScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(0),
              width: double.infinity,
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color.fromARGB(255, 43, 134, 7),
                  ),
                  onPressed: () {},
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform.scale(
                          scale: 1.6,
                          child: const Icon(
                            Icons.upload_sharp,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Selectionner une image",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ])),
            ),
            Container(
              margin: const EdgeInsets.all(0),
              width: double.infinity,
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color.fromARGB(172, 244, 76, 54),
                  ),
                  onPressed: () {},
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform.scale(
                          scale: 1.6,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Supprimer l'Image",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm(
      {super.key,
      required this.hinttext,
      required this.label,
      required this.inittext,
      required this.onchange,
      required this.icon});
  final String hinttext;
  final String label;
  final String inittext;
  final Icon icon;
  final Function onchange;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: TextEditingController()..text = inittext,
          onChanged: (value) {
            onchange(value);
          },
          decoration: InputDecoration(
            icon: icon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 4, color: Color.fromARGB(31, 229, 229, 229)),
              borderRadius: BorderRadius.circular(50.0),
            ),
            hintText: hinttext,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
