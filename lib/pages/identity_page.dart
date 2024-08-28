// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class IdentityPage extends StatelessWidget {
  const IdentityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'img/background.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: Positioned(
              top: 50, // Adjust as needed
              left: 50, // Adjust as needed
              child: Image.asset(
                'img/logo.png',
                fit: BoxFit.cover,
                height: 130, // Set the size as needed
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 480, left: 157),
            child: Text(
              "Login",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: Colors.white),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 360,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(245, 220, 249, 255),
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/donor_login');
                      },
                      child: const Text(
                        "DONOR",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(245, 96, 90, 90),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.7,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 360,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(245, 220, 249, 255),
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/shop_login');
                      },
                      child: const Text(
                        "SHOP",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(245, 96, 90, 90),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.7,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      8, 8, 8, 16), // Add padding below the last button
                  child: SizedBox(
                    width: 360,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(245, 220, 249, 255),
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/charity_login');
                      },
                      child: const Text(
                        "CHARITY",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(245, 96, 90, 90),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.7,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
