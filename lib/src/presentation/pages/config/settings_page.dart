import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rever/Developer/developer.dart';
import 'package:rever/developer/Advanced_settings.dart';
import 'package:rever/src/bloc/theme/theme_bloc.dart';
import 'package:rever/src/core/constants/assets.dart';
import 'package:rever/src/core/router/app_router.dart';
import 'package:rever/src/core/theme/themes.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://t.me/+IUdMUMnAUA1jMGE0');

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //
  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _getPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();

    setState(() {
      _packageInfo = info;
    });
  }

/////////
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Themes.getTheme().secondaryColor,
          appBar: AppBar(
            backgroundColor: Themes.getTheme().primaryColor,
            elevation: 0,
            title: const Text(
              'Settings',
            ),
          ),
          body: Ink(
            padding: const EdgeInsets.fromLTRB(
              0,
              16,
              0,
              16,
            ),
            decoration: BoxDecoration(
              gradient: Themes.getTheme().linearGradient,
            ),
            child: ListView(
              children: [
                //join my telegram group
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl(); // Call the function using ()
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 100,
                        margin: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(Assets.logo),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Ŕever Music",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                //telegram link
                // GestureDetector(
                //   onTap: () {
                //     _launchUrl;
                //   },
                //   child: Row(
                //     children: [
                //       Container(
                //         width: 80, //128.0,
                //         height: 100, // 128.0,
                //         margin: const EdgeInsets.only(
                //           top: 5, //24.0,
                //           bottom: 5, //64.0,
                //         ),
                //         clipBehavior: Clip.antiAlias,
                //         decoration: const BoxDecoration(
                //           color: Colors.black26,
                //           shape: BoxShape.circle,
                //         ),
                //         //child: Image.asset("assets/developer_image.png"),
                //         child: Image.asset(Assets
                //             .logo), // Assets.developer), // Change the image path accordingly
                //       ),
                //       const SizedBox(
                //         width: 10,
                //       ),
                //       const Text("Ŕever Music",
                //           style: TextStyle(
                //               fontSize: 25, fontWeight: FontWeight.bold)),
                //     ],
                //   ),
                // ),
                // scan music (ignores songs which don't satisfy the requirements)
                ListTile(
                  leading: const Icon(Icons.wifi_tethering_outlined),
                  title: const Text('Scan music'),
                  subtitle: const Text(
                    'Ignore songs which don\'t satisfy the requirements',
                  ),
                  onTap: () async {
                    Navigator.of(context).pushNamed(AppRouter.scanRoute);
                  },
                ),
                // language
                // TODO: add language selection
                ListTile(
                  leading: const Icon(Icons.language_outlined),
                  title: const Text('Language'),
                  onTap: () async {
                    Fluttertoast.showToast(
                        msg: 'Create ReverMusic account to use');
                    return;
                  },
                ),
                // theme
                ListTile(
                  leading: const Icon(Icons.color_lens_outlined),
                  title: const Text('Themes'),
                  onTap: () async {
                    Navigator.of(context).pushNamed(AppRouter.themesRoute);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline_outlined),
                  title: const Text('Developer Options'),
                  onTap: () async {
                    // Navigate to the DeveloperOptions screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DeveloperOptions()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings_accessibility_rounded),
                  title: const Text('Advanced Settings'),
                  onTap: () async {
                    // Navigator.of(context).pushNamed(AppRouter.themesRoute);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdvancedSettings()));
                  },
                ),

                // package info
                _buildPackageInfoTile(context),
              ],
            ),
          ),
        );
      },
    );
  }

////////url

  ///
  ListTile _buildPackageInfoTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: const Text('Version'),
      subtitle: Text(
        _packageInfo.version,
      ),
      onTap: () async {
        // show package info
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('App info'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${_packageInfo.appName}',
                ),
                const Text('Package: Null (revertechsoft.com)'
                    //'Package: ${_packageInfo.packageName}',
                    ),
                Text(
                  'Version: ${_packageInfo.version}',
                ),
                Text(
                  'Build number: ${_packageInfo.buildNumber}',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
