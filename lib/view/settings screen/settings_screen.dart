import 'dart:developer';

import 'package:beat/view/splash%20screen/splash_screen.dart';
import 'package:beat/widget%20functions/widget_functions.dart';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


const emial = 'harikrishnancr1725@gmail.com';
const subjectEmail = 'Abou Beats App';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 36, 19, 60),
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Center(
                child: Image(
              image: const AssetImage('assets/images/settings (1).png'),
              height: screenHeight * 0.16,
            )),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            const Text(
              'Version : 1.0.0',
              style: TextStyle(
                  color: Color.fromARGB(174, 184, 182, 182),
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
            // SizedBox(
            //   height: screenHeight * 0.03,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text('Communication',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.mail,
                        size: 24,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      GestureDetector(
                        onTap: () async{
                          final uriContact = 'mailto:$emial?subject=${Uri.encodeFull(subjectEmail)}';

                          try {
                              if (await canLaunchUrl(Uri.parse(uriContact))) {
                                await launchUrl(Uri.parse(uriContact));  
                              }
                            } catch (e) {
                              log(e.toString());
                            }
                          log('contact us');
                        },
                        child: const Text('Contact Us',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.5,
                                color: Colors.white)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.message,
                        size: 24,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      GestureDetector(
                        onTap: () async {
                          log('Feedba');
                          const urls =
                              'https://play.google.com/store/apps/details?id=in.music.beat';
                          try {
                            if (await canLaunchUrl(Uri.parse(urls))) {
                              await launchUrl(Uri.parse(urls));
                            }
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        child: const Text('Feedback',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.5,
                                color: Colors.white)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.001,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.notifications_active,
                        size: 24,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      const Text(
                        'Notifications',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.5,
                            color: Colors.white),
                      ),
                      SizedBox(width: screenWidth * 0.200),
                      ValueListenableBuilder(
                          valueListenable: notification,
                          builder: (context, value, child) {
                            return Switch(
                              activeTrackColor: secondaryColour,
                              activeColor: secondaryColour,
                              inactiveTrackColor: secondaryColour,
                              value: notification.value,
                              autofocus: true,
                              onChanged: ((value) {
                                notification.value = value;
                                audioPlayer.showNotification = value;
                              }),
                            );
                          })
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                thickness: 1.5,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08, vertical: screenWidth * 0.01),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text('Info',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.privacy_tip,
                            size: 20,
                            color: Colors.white,
                          )),
                      TextButton(
                          onPressed: () async {
                            log('Feedba');
                            const urls =
                                'https://www.app-privacy-policy.com/live.php?token=KCQD0h2AcRvI3fwegQRq47FTabbGtGyj';
                            try {
                              if (await canLaunchUrl(Uri.parse(urls))) {
                                await launchUrl(Uri.parse(urls));
                              }
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                          child: const Text('PRIVACY POLICY',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.white))),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            // log('share');  
                            // Share.share('check out my website https://example.com', subject: 'Look what I made!');
                          },
                          icon: const Icon(
                            Icons.share,
                            size: 20,
                            color: Colors.white,
                          )),
                      TextButton(
                          onPressed: () {
                            log('share');  
                            Share.share('https://play.google.com/store/apps/details?id=in.music.beat', subject: 'Look what I made!');
                          },
                          child: const Text('SHARE',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.white))),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            aboutAlertDialogBox(context);
                          },
                          icon: const Icon(
                            Icons.info,
                            size: 20,
                            color: Colors.white,
                          )),
                      TextButton(
                          onPressed: () {
                            aboutAlertDialogBox(context);
                          },
                          child: const Text('ABOUT',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.white))),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> aboutAlertDialogBox(ctx) {
    return showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(12),
          title: const ListTile(
            contentPadding: EdgeInsets.all(0),
            minVerticalPadding: 0,
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/beats-logo.png'),
            ),
            title: Text(
              "BEATS",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.2),
            ),
            subtitle: Text(
                "It is a Ad free Music player Play all Music from your Local Storage",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(209, 111, 110, 110))),
          ),
          actions: [
            TextButton(
              onPressed: () {
                licenceMusicApp(context);
              },
              child: const Text("License"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Close"))
          ],
        );
      },
    );
  }

  licenceMusicApp(ctx) {
    showLicensePage(
        context: ctx,
        applicationName: "Beats",
        applicationIcon: Image.asset(
          "assets/images/beats-logo.png",
          width: screenHeight * 0.1,
          height: screenHeight * 0.1,
        ));
  }
}
