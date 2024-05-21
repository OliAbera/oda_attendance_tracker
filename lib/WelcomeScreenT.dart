import 'package:flutter/material.dart';
import 'package:oda_attendace_tracker/loginScreenT.dart';
import 'package:oda_attendace_tracker/regscreenT.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class WelcomeScreenT extends StatelessWidget {
  const WelcomeScreenT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 27, 2, 85),
                Color.fromARGB(244, 124, 3, 104),
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              const Text(
                'Welcome to teacher\'s page',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreenT()),
                  );
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegScreenT()),
                  );
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSocialMediaIcon('lib/images/Google.png', 'https://accounts.google.com'),
                  _buildSocialMediaIcon('lib/images/Facebook.png', 'https://www.facebook.com'),
                  _buildSocialMediaIcon('lib/images/X.png', 'https://twitter.com'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaIcon(String imagePath, String url) {
    return GestureDetector(
      onTap: () {
        _launchSocialMediaSignIn(url);
      },
      child: Column(
        children: [
          const Text(
            'Login with:',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12,),
          Image(image: AssetImage(imagePath)),
        ],
      ),
    );
  }
  // Method to launch social media sign-in page
  void _launchSocialMediaSignIn(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}