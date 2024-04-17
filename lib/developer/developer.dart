import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rever/src/core/constants/assets.dart';
import 'package:rever/src/core/theme/themes.dart';

import 'package:url_launcher/url_launcher.dart';

class DeveloperOptions extends StatelessWidget {
  const DeveloperOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.getTheme().secondaryColor,
      appBar: AppBar(
        backgroundColor: Themes.getTheme().secondaryColor,
        elevation: 0.1,
        title: Text(
          "Developer Options",
          style: GoogleFonts.lato(
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: ListTileTheme(
            iconColor: const Color.fromARGB(255, 1, 14, 25),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    width: 128.0,
                    height: 128.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 64.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(Assets.developer)),
                const SizedBox(
                  height: 24,
                ),

                ListTile(
                  onTap: () {
                    // Open the email app with the recipient pre-filled
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'reverblessig@gmail.com',
                    );
                    launch(emailLaunchUri.toString());
                  },
                  leading: const Icon(
                    Icons.email_rounded,
                    size: 17,
                  ),
                  title: Text(
                    'reverblessig@gmail.com',
                    style: GoogleFonts.lato(fontSize: 16),
                  ),
                ),
                // ListTile(
                //   onTap: () {},
                //   leading: const Icon(
                //     Icons.email_rounded,
                //     size: 15,
                //   ),
                //   title: Text(
                //     'reverblessig@gmail.com',
                //     style: GoogleFonts.lato(fontSize: 16),
                //   ),
                // ),
                ExpansionTile(
                  leading: const Icon(
                    Icons.account_circle,
                    size: 17,
                  ),
                  title: Text(
                    'Social Media',
                    style: GoogleFonts.lato(fontSize: 16),
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                  controller: ExpansionTileController(),
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        const url =
                            'https://www.facebook.com/profile.php?id=100095262228182&mibextid=ZbWKwL';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: ListTile(
                        leading: const Icon(
                          Icons.facebook_rounded,
                          color: Color.fromARGB(255, 218, 85, 8),
                          size: 17,
                        ),
                        title: Text(
                          'Facebook',
                          style: GoogleFonts.lato(fontSize: 16),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        const url = 'https://wa.me/265984671670';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: ListTile(
                        leading: const Icon(
                          Icons.message_rounded,
                          size: 17,
                          color: Color.fromARGB(
                            255,
                            224,
                            60,
                            10,
                          ),
                        ),
                        title: Text(
                          'WhatsApp',
                          style: GoogleFonts.lato(fontSize: 16),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        const url = 'https://www.instagram.com/blessi-g ŕever';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: ListTile(
                        leading: const Icon(
                          Icons.message_rounded,
                          size: 15,
                          color: Color.fromARGB(255, 235, 54, 54),
                        ),
                        title: Text(
                          'Instagram',
                          style: GoogleFonts.lato(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  leading: const Icon(
                    Icons.apps,
                    size: 15,
                    color: Color.fromARGB(255, 233, 229, 6),
                  ),
                  title: Text(
                    'More Apps',
                    style: GoogleFonts.lato(fontSize: 16),
                  ),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text(
                      'Developer Options | Version RM 21.03.0',
                      style: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 1, 18, 32),
                          fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(const DeveloperOptions());
// }


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';

// class DeveloperOptions extends StatefulWidget {
//   const DeveloperOptions({super.key});

//   @override
//   State<DeveloperOptions> createState() => _DeveloperOptionsState();
// }

// class _DeveloperOptionsState extends State<DeveloperOptions> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ListTileTheme(
//         //textColor: Colors.white,
//         //textColor: Color.fromARGB(255, 2, 13, 22),
//         //iconColor: Colors.white,
//         iconColor: const Color.fromARGB(255, 1, 14, 25),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Container(
//               width: 128.0,
//               height: 128.0,
//               margin: const EdgeInsets.only(
//                 top: 24.0,
//                 bottom: 64.0,
//               ),
//               clipBehavior: Clip.antiAlias,
//               decoration: const BoxDecoration(
//                 color: Colors.black26,
//                 shape: BoxShape.circle,
//               ),
//               child: Image.asset(
//                 //'lib/Images/Luarnar.jpg',
//                 'assets/images/music-rever.png',
//               ),
//             ),
//             // Text(
//             //   "+265 984671670",
//             //   style: GoogleFonts.aBeeZee(color: Colors.orange.withOpacity(0.7)),
//             // ),
//             // Text(
//             //   'reverblessig@gmail.com',
//             //   style: GoogleFonts.aBeeZee(color: Colors.orange.withOpacity(0.7)),
//             // ),
//             const SizedBox(
//               height: 23,
//             ),
//             ListTile(
//               onTap: () {},
//               leading: const Icon(Icons.home),
//               title: Text(
//                 'Feedback: reverblessig@gmail.com',
//                 style: GoogleFonts.lato(fontSize: 13),
//               ),
//             ),
//             ExpansionTile(
//               //onTap: () {},
//               leading: const Icon(Icons.account_circle),
//               title: Text(
//                 'Social Media',
//                 style: GoogleFonts.lato(fontSize: 12),
//               ), // The location of the expansion arrow icon
//               controlAffinity: ListTileControlAffinity.trailing,
//               // The controller to programmatically expand or collapse the tile
//               controller: ExpansionTileController(),
//               children: [
//                 ///1st facebook

//                 GestureDetector(
//   behavior: HitTestBehavior.translucent,
//   onTap: () async {
//     const url = 'https://www.facebook.com/profile.php?id=100095262228182&mibextid=ZbWKwL';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   },
//   child:  ListTile(
//     leading: const Icon(
//       Icons.facebook_rounded,
//       color: Color.fromARGB(255, 218, 85, 8),
//     ),
//     title: Text(
//       'Facebook',
//       style: GoogleFonts.lato(fontSize: 12)
//     ),
//   ),
// ),

//                 GestureDetector(
//   onTap: () async {
//     const url = 'https://wa.me/265984671670';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   },
//   child:  ListTile(
//     leading: const Icon(
//       Icons.message_rounded,
//       color: Color.fromARGB(255, 224, 60, 10),
//     ),
//     title: Text(
//       'WhatsApp',
//        style: GoogleFonts.lato(fontSize: 12)
//       ),
//     ),
//   ),
// ),

//                 GestureDetector(
//   onTap: () async {
//     const url = 'https://www.instagram.com/blessi-g ŕever';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   },
//   child:  ListTile(
//     leading: const Icon(
//       Icons.message_rounded,
//       color: Color.fromARGB(255, 235, 54, 54),
//     ),
//     title: Text(
//       'Instagram',
//       style: GoogleFonts.lato(fontSize: 12)
//     ),
//   ),
// ),

//             const Spacer(),
//             DefaultTextStyle(
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: Colors.white54,
//               ),
//               child: Container(
//                 margin: const EdgeInsets.symmetric(
//                   vertical: 16.0,
//                 ),
//                 //child: Text('Terms of Service | Privacy Policy'),
//                 child: Text(
//                   'Developer Options | Version RM 21.03.0',
//                   style: GoogleFonts.roboto(
//                       color: const Color.fromARGB(255, 1, 18, 32),
//                       fontSize: 11),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
