import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player/controller/audio_controller_cubit.dart';
import 'package:youtube_player/shared/theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePage extends StatefulWidget {
  final String? id;
  const YoutubePage({super.key, this.id});

  @override
  State<YoutubePage> createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> with WidgetsBindingObserver {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  bool isToggled = false;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  final bool _isPlayerReady = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      context.read<AudioCubit>().playAudio();
    }
    if (state == AppLifecycleState.resumed) {
      context.read<AudioCubit>().stopAudio();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: red,
        appBar: AppBar(
          backgroundColor: abuabu,
          title: Text(
            "Youtube Player",
            style: textpoppins,
          ),
        ),
        body: LayoutBuilder(
          builder: (context, p1) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: p1.maxWidth * 0.03,
                  right: p1.maxWidth * 0.03,
                  top: p1.maxHeight * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    _videoMetaData.title,
                    style: textpoppins.copyWith(
                        fontSize: p1.maxWidth * 0.1, color: abuabu),
                  ),
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    topActions: <Widget>[
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _controller.metadata.title,
                          style: textpoppins.copyWith(
                              fontSize: p1.maxWidth * 0.04, color: abuabu),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                    onEnded: (data) {},
                    bottomActions: [
                      CurrentPosition(),
                      ProgressBar(
                        isExpanded: true,
                        colors: const ProgressBarColors(
                            playedColor: red, handleColor: red),
                      ),
                      FullScreenButton(
                        controller: _controller,
                        color: abuabu,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Volume",
                        style: textpoppins.copyWith(color: abuabu),
                      ),
                      Expanded(
                        child: Slider(
                          inactiveColor: abuabu,
                          value: _volume,
                          min: 0.0,
                          max: 100.0,
                          divisions: 10,
                          label: '${(_volume).round()}',
                          onChanged: _isPlayerReady
                              ? (value) {
                                  setState(() {
                                    _volume = value;
                                  });
                                  _controller.setVolume(_volume.round());
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Nyalakan di Background",
                  //       style: textpoppins.copyWith(color: abuabu),
                  //     ),
                  //     Switch(
                  //       value: isToggled,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           isToggled = value;
                  //           if (isToggled) {
                  //             context.read<AudioCubit>().playAudio();
                  //           }
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
