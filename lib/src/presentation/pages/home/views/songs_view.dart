import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rever/src/bloc/home/home_bloc.dart';
import 'package:rever/src/bloc/player/player_bloc.dart';
import 'package:rever/src/core/di/service_locator.dart';
import 'package:rever/src/core/extensions/string_extensions.dart';
import 'package:rever/src/core/theme/themes.dart';
import 'package:rever/src/data/repositories/player_repository.dart';
import 'package:rever/src/data/services/hive_box.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rever/src/presentation/widgets/song_list_tile.dart';

class SongsView extends StatefulWidget {
  const SongsView({super.key});

  @override
  State<SongsView> createState() => _SongsViewState();
}

class _SongsViewState extends State<SongsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final audioQuery = sl<OnAudioQuery>();
  final songs = <SongModel>[];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetSongsEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) async {
        if (state is SongsLoaded) {
          setState(() {
            songs.clear();
            songs.addAll(state.songs);
            isLoading = false;
          });

          Fluttertoast.showToast(
            msg: '${state.songs.length} songs found',
          );
        }
      },
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // number of songs
                      Text(
                        '${songs.length} songs',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      // sort button
                      Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Container(
                              height: 30,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Themes.getTheme()
                                      .secondaryColor
                                      .withOpacity(
                                          0.5), // Colors.grey.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          const SortBottomSheet(),
                                    );
                                  },
                                  child: Text(
                                    'Filters',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white.withOpacity(
                                            0.8) // Color(0xD2F9F7F7),
                                        ),
                                  ),
                                ),
                              )))
                      // IconButton(
                      //   onPressed: () {
                      //     showModalBottomSheet(
                      //       context: context,
                      //       isScrollControlled: true,
                      //       builder: (context) => const SortBottomSheet(),
                      //     );
                      //   },

                      //  icon: const Icon(Icons.sort),
                      // ),
                    ],
                  ),
                ),
                // shuffle, play
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.shuffle),
                                const SizedBox(width: 8),
                                Text(
                                  'Shuffle',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            onTap: () {
                              // enable shuffle
                              context.read<PlayerBloc>().add(
                                    PlayerSetShuffleModeEnabled(true),
                                  );

                              // get random song
                              final randomSong =
                                  songs[Random().nextInt(songs.length)];

                              // play random song
                              context.read<PlayerBloc>().add(
                                    PlayerLoadSongs(
                                      songs,
                                      sl<JustAudioPlayer>()
                                          .getMediaItemFromSong(randomSong),
                                    ),
                                  );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.play_arrow),
                                const SizedBox(width: 8),
                                Text(
                                  'Play',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            onTap: () {
                              // disable shuffle
                              context.read<PlayerBloc>().add(
                                    PlayerSetShuffleModeEnabled(false),
                                  );

                              // play first song
                              context.read<PlayerBloc>().add(
                                    PlayerLoadSongs(
                                      songs,
                                      sl<JustAudioPlayer>()
                                          .getMediaItemFromSong(songs[0]),
                                    ),
                                  );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: AnimationLimiter(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<HomeBloc>().add(GetSongsEvent());
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          final song = songs[index];

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: FlipAnimation(
                              child: SongListTile(
                                song: song,
                                songs: songs,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  int currentSortType = Hive.box(HiveBox.boxName).get(
    HiveBox.songSortTypeKey,
    defaultValue: SongSortType.TITLE.index,
  );
  int currentOrderType = Hive.box(HiveBox.boxName).get(
    HiveBox.songOrderTypeKey,
    defaultValue: OrderType.ASC_OR_SMALLER.index,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Sort by',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        for (final songSortType in SongSortType.values)
          RadioListTile<int>(
            visualDensity: const VisualDensity(
              horizontal: 0,
              vertical: -4,
            ),
            value: songSortType.index,
            groupValue: currentSortType,
            title: Text(
              songSortType.name.capitalize().replaceAll('_', ' '),
            ),
            onChanged: (value) {
              setState(() {
                currentSortType = value!;
              });
            },
          ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Order by',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        for (final orderType in OrderType.values)
          RadioListTile<int>(
            visualDensity: const VisualDensity(
              horizontal: 0,
              vertical: -4,
            ),
            value: orderType.index,
            groupValue: currentOrderType,
            title: Text(
              orderType.name.capitalize().replaceAll('_', ' '),
            ),
            onChanged: (value) {
              setState(() {
                currentOrderType = value!;
              });
            },
          ),
        const SizedBox(height: 16),
        // cancel, apply button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.read<HomeBloc>().add(
                          SortSongsEvent(
                            currentSortType,
                            currentOrderType,
                          ),
                        );
                  },
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
