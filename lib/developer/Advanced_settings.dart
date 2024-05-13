// ignore: file_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rever/src/core/router/app_router.dart';
import 'package:rever/src/core/theme/themes.dart';
import 'package:url_launcher/url_launcher.dart';

//spotify link
final Uri _urL = Uri.parse(
    'https://open.spotify.com/playlist/37i9dQZF1E4AahE2TFt8Cv?si=uvUgAGIkR42EGGQl6M_Myg&utm_source=copy-link');

class AdvancedSettings extends StatefulWidget {
  const AdvancedSettings({super.key});

  @override
  State<AdvancedSettings> createState() => _AdvancedSettingsState();
}

class _AdvancedSettingsState extends State<AdvancedSettings> {
/////////
  Future<void> _launchUrl() async {
    if (!await launchUrl(_urL)) {
      throw Exception('Could not launch $_urL');
    }
  }

  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Themes.getTheme().secondaryColor,
      extendBody: true,
      backgroundColor: Themes.getTheme().secondaryColor,
      appBar: AppBar(
        backgroundColor: Themes.getTheme().secondaryColor,
        title: const Text('Advanced Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Listening on',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'This phone',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle button press
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No access. Upgrade to Pro')),
                );
              },
              // ignore: sort_child_properties_last
              child: const Icon(Icons.mic_outlined, size: 40),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent.withOpacity(0.5),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select a device',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const Text(
              'Use your mobile device as a remote control.',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(
              height: 7,
            ),
            ListTile(
              leading: const Icon(Icons.read_more_outlined),
              title: const Text('Go to normal'),
              onTap: () async {
                Navigator.of(context).pushNamed(AppRouter.settingsRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline_outlined),
              title: const Text('Create free acount'),
              onTap: () async {
                //  Navigator.of(context).pushNamed(AppRouter.settingsRoute);
                Fluttertoast.showToast(msg: 'Available in Pro mode only');
                return;
              },
            ),
            GestureDetector(
              onTap: () {
                _launchUrl(); // Call the function using ()
              },
              child: const ListTile(
                leading: Icon(Icons.music_note_outlined),
                title: Text('Coding'),
                //  onTap: () async {
                //  Navigator.of(context).pushNamed(AppRouter.settingsRoute);
                //  },
              ),
            )
            //  GestureDetector(onTap: () {

            //  }, child: const Text('Go to normal settings.', style: TextStyle(fontSize: 20),),)
          ],
        ),
      ),
    );
  }
}
