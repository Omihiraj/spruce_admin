import 'package:clean_admin/components/constants.dart';
import 'package:clean_admin/screens/pages/sign_up.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: 530.0,
                width: 360.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, top: 10.0, right: 32.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 318,
                        height: 144,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/img_1.png"),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 30.0, top: 120.0, right: 0.0, bottom: 0.0),
                          child: Text(
                            "Enter your email and password below",
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "EMAIL",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Emai Address',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "PASSWORD",
                            style: TextStyle(
                                color: secondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 150,
                          ),
                          Text(
                            "Fogot Password",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: _obscureText
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: secondaryColor,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: secondaryColor,
                                  ),
                            onPressed: () {
                              setState(() => _obscureText = !_obscureText);
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                      ),
                      const SizedBox(
                        height: 24,
                      ),

                      const SizedBox(
                        height: 24,
                      ),
                      // GestureDetector(
                      //   onTap: (){
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (BuildContext context) => SideMenu(),
                      //         ));
                      //   },
                      //   child: Container(

                      //     height: 48,
                      //     width: 316,
                      //     color: primaryColor,
                      //     child: const Center(child: Text('Log In',style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'mulish'),)),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Dont have an account?",
                              style: TextStyle(
                                color: Color(0xFF9FA2B4),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const SignupPage(),
                                      ));
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
