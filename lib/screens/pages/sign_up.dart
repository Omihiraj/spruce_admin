import 'package:clean_admin/components/constants.dart';
import 'package:clean_admin/screens/pages/login.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/img.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, top: 10.0, right: 0.0, bottom: 10.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: 725.0,
                  width: 458.0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 0.0, right: 34.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 34.0),
                          child: Container(
                            width: 300,
                            height: 135,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("img/logo.png"),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 90.0,
                                  top: 120.0,
                                  right: 0.0,
                                  bottom: 0.0),
                              child: Text(
                                "Signup with your email",
                                style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "NAME",
                          style: TextStyle(
                              color: secondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          height: 38,
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Name',
                              border: const OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.only(left: 10.0, top: 5.0),
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color(0xFF4B506D).withOpacity(0.4)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "ADDRESS",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          height: 38.0,
                          child: TextField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(left: 10.0, top: 5.0),
                              filled: true,
                              hintText: 'Address',
                              border: const OutlineInputBorder(),
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color(0xFF4B506D).withOpacity(0.4)),
                            ),
                            obscureText: obscureText,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "DATE OF BIRTH",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          height: 38.0,
                          child: TextField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(left: 10.0, top: 5.0),
                              filled: true,
                              hintText: 'MM/DD/YYYY',
                              border: const OutlineInputBorder(),
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color(0xFF4B506D).withOpacity(0.4)),
                            ),
                            obscureText: obscureText,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "EMAIL",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          height: 38.0,
                          child: TextField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(left: 10.0, top: 5.0),
                              filled: true,
                              hintText: 'Email',
                              border: const OutlineInputBorder(),
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color(0xFF4B506D).withOpacity(0.4)),
                            ),
                            obscureText: obscureText,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "MOBILE NUMBER",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          height: 38.0,
                          width: 394.0,
                          child: TextField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(left: 10.0, top: 5.0),
                              filled: true,
                              hintText: 'Mobile Number',
                              border: const OutlineInputBorder(),
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color(0xFF4B506D).withOpacity(0.4)),
                            ),
                            obscureText: obscureText,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "PAYMENT METHOD",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 38.0,
                                  width: 295.0,
                                  child: TextField(
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 10.0, top: 5.0),
                                      filled: true,
                                      hintText: 'Card Number',
                                      border: const OutlineInputBorder(),
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF4B506D)
                                              .withOpacity(0.4)),
                                    ),
                                    obscureText: obscureText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 11.0),
                                  child: SizedBox(
                                    height: 38.0,
                                    width: 88.0,
                                    child: TextField(
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            left: 10.0, top: 5.0),
                                        filled: true,
                                        hintText: 'MM/YY',
                                        border: const OutlineInputBorder(),
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF4B506D)
                                                .withOpacity(0.4)),
                                      ),
                                      obscureText: obscureText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 38.0,
                                  width: 84.0,
                                  child: TextField(
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 7.0, top: 5.0),
                                      filled: true,
                                      hintText: 'CVV/CVC',
                                      border: const OutlineInputBorder(),
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF4B506D)
                                              .withOpacity(0.4)),
                                    ),
                                    obscureText: obscureText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: SizedBox(
                                    height: 38.0,
                                    width: 300.0,
                                    child: TextField(
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            left: 10.0, top: 5.0),
                                        filled: true,
                                        hintText: 'Card holder Name',
                                        border: const OutlineInputBorder(),
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF4B506D)
                                                .withOpacity(0.4)),
                                      ),
                                      obscureText: obscureText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.7), //color of shadow
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(0.5, 1),
                                  )
                                ],
                              ),

                              height: 48,
                              width: 385,
                              // color: primaryColor,
                              child: const Center(
                                  child: Text(
                                'Create account',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                            child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
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
                                          const LoginPage(),
                                    ));
                              },
                              child: const Text(
                                "Log In",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        )),
                      ],
                    ),
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
