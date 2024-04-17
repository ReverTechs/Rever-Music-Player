import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rever/src/bloc/favorites/favorites_bloc.dart';
import 'package:rever/src/bloc/home/home_bloc.dart';
import 'package:rever/src/bloc/player/player_bloc.dart';
import 'package:rever/src/bloc/playlists/playlists_cubit.dart';
import 'package:rever/src/bloc/recents/recents_bloc.dart';
import 'package:rever/src/bloc/scan/scan_cubit.dart';
import 'package:rever/src/bloc/search/search_bloc.dart';
import 'package:rever/src/bloc/song/song_bloc.dart';
import 'package:rever/src/bloc/theme/theme_bloc.dart';
import 'package:rever/src/core/di/service_locator.dart';
import 'package:rever/src/data/repositories/player_repository.dart';
import 'package:rever/src/data/services/hive_box.dart';

import 'src/app.dart';

Future<void> main() async {
  // initialize flutter engine
  WidgetsFlutterBinding.ensureInitialized();

  // initialize dependency injection
  init();

  // set portrait orientation
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  // ask for permission to access media if not granted
  if (!await Permission.mediaLibrary.isGranted) {
    await Permission.mediaLibrary.request();
  }

  // initialize hive
  await Hive.initFlutter();
  await Hive.openBox(HiveBox.boxName);

  // initialize audio service
  await sl<JustAudioPlayer>().init();

  // run app
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ThemeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SongBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<FavoritesBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PlayerBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<RecentsBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ScanCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<PlaylistsCubit>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
