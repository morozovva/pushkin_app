import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../helpers/colors.dart';

class MyAudioPlayer extends StatefulWidget {
  const MyAudioPlayer({super.key, required this.url});

  final String url;

  @override
  State<MyAudioPlayer> createState() => _MyAudioPlayerState();
}

class _MyAudioPlayerState extends State<MyAudioPlayer> {
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  final audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    setAudio();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        _isPlaying = event == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        _duration = event;
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        _position = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  Future setAudio() async {
    audioPlayer.setSourceUrl(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        color: ThemeColors.lightGray,
        height: 50,
        child: Row(children: [
          IconButton(
            onPressed: () async {
              if (_isPlaying) {
                await audioPlayer.pause();
              } else {
                await audioPlayer.resume();
              }
            },
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
          ),
          Expanded(
            flex: 1,
            // width: 90,
            child: Text(
              "${_printDuration(_position)} / ${_printDuration(_duration)}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            flex: 2,
            child: Slider(
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds.toDouble(),
              onChanged: (val) async {
                final position = Duration(seconds: val.toInt());
                await audioPlayer.seek(position);
                await audioPlayer.resume();
              },
            ),
          ),
        ]),
      ),
    );
  }
}
