import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rever/components/const.dart';
import 'package:rever/developer/Advanced_settings.dart';
import 'package:rever/developer/notification_page.dart';
import 'package:rever/developer/online_search_page.dart';

import 'package:rever/src/bloc/theme/theme_bloc.dart';
import 'package:rever/src/core/constants/assets.dart';
import 'package:rever/src/core/di/service_locator.dart';
import 'package:rever/src/core/router/app_router.dart';
import 'package:rever/src/core/theme/themes.dart';
import 'package:rever/src/presentation/pages/config/settings_page.dart';
import 'package:rever/src/presentation/pages/home/search_page.dart';
import 'package:rever/src/presentation/pages/home/views/albums_view.dart';
import 'package:rever/src/presentation/pages/home/views/artists_view.dart';
import 'package:rever/src/presentation/pages/home/views/genres_view.dart';
import 'package:rever/src/presentation/pages/home/views/playlists_view.dart';
import 'package:rever/src/presentation/pages/home/views/songs_view.dart';
import 'package:rever/src/presentation/pages/playlists/favorites_page.dart';
import 'package:rever/src/presentation/pages/playlists/recents_page.dart';
import 'package:rever/src/presentation/widgets/player_bottom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int currentIndex = 0;
// ignore: unused_element
int _selectedIndex = 0;

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final OnAudioQuery _audioQuery = sl<OnAudioQuery>();
  late TabController _tabController;
  bool _hasPermission = false;

// Define _currentIndex here

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  /////////////////////

  final GreetingService greetingService = GreetingService();

  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
    _tabController = TabController(length: tabs.length, vsync: this);
    // Subscribe to connectivity changes
    // _checkConnection();
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   _updateConnectionStatus(result);
    // });
  }
//

  // void _updateConnectionStatus(ConnectivityResult result) {
  //   setState(() {
  //     switch (result) {
  //       case ConnectivityResult.wifi:
  //         'Online WiFi';
  //         break;
  //       case ConnectivityResult.mobile:
  //         'Local Playlist'; //'Online Mobile Data';
  //         break;
  //       case ConnectivityResult.none:
  //         'Offline';
  //         break;
  //       default:
  //         'Offline';
  //         break;
  //     }
  //   });
  // }

  // Future<void> _checkConnection() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   _updateConnectionStatus(connectivityResult);
  // }

//
  Future checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : checkAndRequestPermissions(retry: true);
  }

  final tabs = [
    'Songs',
    'Playlists',
    'Artists',
    'Albums',
    'Genres',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
            extendBody: true,
            backgroundColor: Themes.getTheme().secondaryColor,
            //drawer: _buildDrawer(context),
            appBar: _buildAppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _buildBody(context),
                ),
                const PlayerBottomAppBar(),
                Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,

                  //transparent color
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent, // Start with transparent color
                        Colors
                            .transparent, // Add more transparent colors if needed
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.0, 1.0], // Adjust stops as desired
                    ),
                  ),

                  // decoration: const BoxDecoration(
                  //   gradient: LinearGradient(
                  //     colors: [
                  //       Color.fromARGB(255, 0, 0, 0),
                  //       Color.fromARGB(200, 0, 0, 0),
                  //       Color.fromARGB(135, 0, 0, 0),
                  //       Color.fromARGB(80, 0, 0, 0),
                  //       Colors.transparent,
                  //     ],
                  //     begin: Alignment.bottomCenter,
                  //     end: Alignment.topCenter,
                  //     stops: [0.0, 0.3, 0.6, 0.75, 1.0],
                  //   ),
                  // ),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Row(
                    children: [
                      BottomNavBarItem(
                        title: 'Home',
                        icon: 'home.png',
                        onTap: () {
                          _onItemTapped(0);
                        },
                        index: 0,
                      ),
                      BottomNavBarItem(
                        title: 'Streaming',
                        icon: 'search.png',
                        onTap: () {
                          // _onItemTapped(1);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OnlineSearchPage()));
                        },
                        index: 1,
                      ),
                      BottomNavBarItem(
                        title: 'Your Library',
                        icon: 'library.png',
                        onTap: () {
                          //_onItemTapped(2);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FavoritesPage()));
                        },
                        index: 2,
                      ),
                      BottomNavBarItem(
                        // title: 'Settings',
                        // icon: 'settings.png',
                        title: 'Advanced',
                        icon: 'settings.png',
                        onTap: () {
                          //_onItemTapped(3);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdvancedSettings()));
                        },
                        index: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //adptive to phone
            floatingActionButton: GestureDetector(
              onTap: () {
                // return, show an error message if the name is empty
                Fluttertoast.showToast(msg: 'Playlist name cannot be empty');
                return;
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 170.0), // Adjust the value as needed
                child: SizedBox(
                  width: 50.0, // Set your desired width
                  height: 50.0, // Set your desired height
                  child: FloatingActionButton(
                    onPressed: () {
                      Fluttertoast.showToast(msg: 'Coming soon');
                      return;
                      // Your onPressed code here
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const SettingsPage()));
                    },
                    backgroundColor: Colors.transparent.withOpacity(0.50),
                    child: Icon(
                      Icons.mic_outlined,
                      size: 40,
                      color: Colors.green[900],
                    ),
                  ),
                ),
              ),
            ));

        // return Scaffold(
        //   // current song, play/pause button, song progress bar, song queue button
        //   //bottomNavigationBar: const PlayerBottomAppBar(),
        //   //I used container, hence it was unnecessary currently
        //   bottomNavigationBar: Column(
        //     children: [
        //       const PlayerBottomAppBar(),
        //       Container(
        //         height: 65,
        //         width: MediaQuery.of(context).size.width,
        //         decoration: const BoxDecoration(
        //           gradient: LinearGradient(
        //             colors: [
        //               Color.fromARGB(255, 0, 0, 0),
        //               Color.fromARGB(200, 0, 0, 0),
        //               Color.fromARGB(135, 0, 0, 0),
        //               Color.fromARGB(80, 0, 0, 0),
        //               Colors.transparent,
        //             ],
        //             begin: Alignment.bottomCenter,
        //             end: Alignment.topCenter,
        //             stops: [0.0, 0.3, 0.6, 0.75, 1.0],
        //           ),
        //         ),
        //         padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        //         child: Row(
        //           children: [
        //             BottomNavBarItem(
        //               title: 'Home',
        //               icon: 'home.png',
        //               onTap: () {
        //                 _onItemTapped(0);
        //               },
        //               index: 0,
        //             ),
        //             BottomNavBarItem(
        //               title: 'Searh',
        //               icon: 'search.png',
        //               onTap: () {
        //                 _onItemTapped(1);
        //               },
        //               index: 1,
        //             ),
        //             BottomNavBarItem(
        //               title: 'Your Library',
        //               icon: 'library.png',
        //               onTap: () {
        //                 _onItemTapped(2);
        //               },
        //               index: 2,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ), //const PlayerBottomAppBar(),
        //   extendBody: true,
        //   backgroundColor: Themes.getTheme().secondaryColor,
        //   drawer: _buildDrawer(context),
        //   appBar: _buildAppBar(),
        //   body: _buildBody(context),
        // );
      },
    );
  }

  Ink _buildBody(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        gradient: Themes.getTheme().linearGradient,
      ),
      child: _hasPermission
          ? Column(
              children: [
                //search
                const SearchGesture(),
                TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  controller: _tabController,
                  tabs: tabs.map((e) => Tab(text: e)).toList(),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      SongsView(),
                      PlaylistsView(),
                      ArtistsView(),
                      AlbumsView(),
                      GenresView(),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text('No permission to access library'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    // permission request
                    await Permission.storage.request();
                  },
                  child: const Text('Retry'),
                )
              ],
            ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Themes.getTheme().primaryColor, //.withOpacity(0.5),
      title: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 9),
        child: Row(
          children: [
            Expanded(
                // Wrap the Text widget with Expanded
                child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                greetingService.getGreeting(),
                style: TextStyle(
                  color: Colors.green[900],
                  fontWeight: FontWeight.w700, //700
                  fontFamily: "Raleway",
                  fontStyle: FontStyle.normal,
                  fontSize: 23.0, //23
                ),
                textAlign: TextAlign.left,
              ),
            )),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationPage()));
          },
          icon: Icon(Icons.notifications_none,
              size: 28,
              color: Colors.white.withOpacity(
                  0.7) //color: Themes.getTheme().secondaryColor.withOpacity(0.7),
              ),
          // icon: const IconButtonWidget(
          //   icon: 'bell.png', //Icon(Icons.speaker_group)
          // ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RecentsPage()));
          },
          icon: Icon(Icons.history_outlined,
              size: 26.0,
              color: Colors.white.withOpacity(
                  0.7) //color: Themes.getTheme().secondaryColor.withOpacity(0.9)
              ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingsPage()));
          },
          icon: Icon(Icons.settings, //.speaker,
              size: 25,
              color: Colors.white.withOpacity(
                  0.8) //Themes.getTheme().secondaryColor.withOpacity(2.0)
              ),
          // icon: const IconButtonWidget(
          //   icon: 'bell.png', //Icon(Icons.speaker_group)
          // ),
        )
        // GestureDetector(
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => const MediaPlayerApp()));
        //     // Replace 'MediaPlayerApp' with the actual class name of your destination page
        //     // Navigator.push(
        //     //   context,
        //     //   MaterialPageRoute(
        //     //     builder: (context) => const MediaPlayerApp(),
        //     //   ),
        //     // );
        //   },
        //   child: const IconButtonWidget(
        //     icon: 'bell.png',
        //   ),
        // ),
        // Flexible(
        //   child: IconButtonWidget(
        //     icon: 'bell.png',
        //   ),
        // ),
        //'''''''''''''''''''''''''''''''''
        // const Flexible(
        //   child: IconButtonWidget(
        //     icon: 'history.png',
        //   ),
        // ),
        //---------------------
        // const Flexible(
        //   child: IconButtonWidget(
        //     icon: 'connect-device.png',
        //   ),
        // ),
        // Add other icons as needed
      ],
    );
  }

/////////////modified overflow of pixels
  // AppBar _buildAppBar() {
  //   return AppBar(
  //     backgroundColor: Themes.getTheme().primaryColor,
  //     title: Padding(
  //       padding: const EdgeInsets.only(left: 12, right: 12, bottom: 9),
  //       child: Row(
  //         children: [
  //           Text(greetingService.getGreeting(),
  //               style: TextStyle(
  //                   color: Colors.green[900],
  //                   fontWeight: FontWeight.w700,
  //                   fontFamily: "Raleway",
  //                   fontStyle: FontStyle.normal,
  //                   fontSize: 23.0),
  //               textAlign: TextAlign.left),
  //         ],
  //       ),
  //     ),
  //     actions: const [
  //       // Expanded(child: SizedBox()),
  //       Flexible(
  //         child: IconButtonWidget(
  //           icon: 'bell.png',
  //         ),
  //       ),
  //       Flexible(
  //         child: IconButtonWidget(
  //           icon: 'history.png',
  //         ),
  //       ),
  //       // Flexible(
  //       //   child: IconButtonWidget(
  //       //     icon: 'settings.png',
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }

  ///
  // AppBar _buildAppBar() {
  //   return AppBar(
  //     backgroundColor: Themes.getTheme().primaryColor,
  //     title: Padding(
  //       padding: const EdgeInsets.only(left: 12, right: 12, bottom: 9),
  //       child: Row(
  //         children: [
  //           Text(greetingService.getGreeting(),
  //               style: TextStyle(
  //                   color: Colors.green[900],
  //                   fontWeight: FontWeight.w700,
  //                   fontFamily: "Raleway",
  //                   fontStyle: FontStyle.normal,
  //                   fontSize: 23.0),
  //               textAlign: TextAlign.left),
  //           const Expanded(child: SizedBox()),
  //           const IconButtonWidget(
  //             icon: 'bell.png',
  //           ),
  //           const IconButtonWidget(
  //             icon: 'history.png',
  //           ),
  //           const IconButtonWidget(
  //             icon: 'settings.png',
  //           ),
  //         ],
  //       ),
  //     ),
  //     // title: Text(greetingService.getGreeting(),
  //     //     style:
  //     //         TextStyle(color: Colors.green[900], fontWeight: FontWeight.bold)),
  //     // search button
  //     actions: const [
  //       // Text(_connectionStatus),
  //       // Text(_isOnline ? 'Local Playlist' : 'Offline')
  //       // IconButton(
  //       //   onPressed: () {
  //       //     Navigator.of(context).pushNamed(AppRouter.searchRoute);
  //       //   },
  //       //   icon: const Icon(Icons.search_outlined),
  //       //   tooltip: 'Search music',
  //       // ),
  //     ],
  //   );
  // }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return DrawerHeader(
                decoration: BoxDecoration(
                  color: Themes.getTheme().primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        Assets.logo,
                        height: 64,
                        width: 64,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Ŕever Music',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // themes
          ListTile(
            leading: const Icon(Icons.color_lens_outlined),
            title: const Text('Themes'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.themesRoute);
            },
          ),
          // settings
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.settingsRoute);
            },
          )
        ],
      ),
    );
  }
}

//Greetings and offline on AppBar
class GreetingService {
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }
}
///////

class SearchGesture extends StatelessWidget {
  const SearchGesture({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigate to the settings page here
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SearchPage()));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 85, top: 1),
          child: SizedBox(
            width: 350.0,
            height: 47.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                // color: Colors.white.withOpacity(0.3),
                color: Colors.white.withOpacity(0.7),
                border: Border.all(
                    // color: Themes.getTheme() .primaryColor
                    ),
                //Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 36,
                    color: Color.fromARGB(164, 0, 0, 0),
                  ),
                  Expanded(
                      child: Text(
                    'Artist, songs, or podcasts.',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.833),
                        fontWeight: FontWeight.bold),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}

////////
// class SearchGesture extends StatelessWidget {
//   const SearchGesture({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to the settings page here
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const SearchPage()));
//       },
//       child: SizedBox(
//         width: 350.0,
//         height: 47.0,
//         child: DecoratedBox(
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.3),
//             border: Border.all(
//                 color: Themes.getTheme()
//                     .primaryColor), //Colors.black, width: 2.0),
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           child: const Row(
//             children: [
//               Icon(
//                 Icons.search,
//                 size: 40,
//               ),
//               Text('Artist, songs, or podcasts.')
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//botton Nav Bar
class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({
    super.key,
    this.onTap,
    required this.icon,
    required this.title,
    required this.index,
  });
  final Function()? onTap;
  final String icon;
  final String title;
  final int index;
  final int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        enableFeedback: false,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Column(
          children: [
            Image.asset(
              '$kAssetIconsWay/$icon',
              color: _selectedIndex != index
                  ? const Color(0xffababab)
                  : Colors.white,
            ),
            const SizedBox(
              height: 8,
            ),
            // title
            Text(title,
                style: TextStyle(
                    color: _selectedIndex != index
                        ? const Color(0xffababab)
                        : Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Raleway",
                    fontStyle: FontStyle.normal,
                    fontSize: 11.0)),
          ],
        ),
      ),
    );
  }
}
