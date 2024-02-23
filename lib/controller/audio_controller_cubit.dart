import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class AudioCubit extends Cubit<bool> {
  final _yt = YoutubeExplode();
  final player = AudioPlayer();
  Future<String> getAudioUrl(String videoId) async {
    var streamManifest = await _yt.videos.streamsClient.getManifest(videoId);
    var audioOnlyStreams = streamManifest.audioOnly;
    var audioStream = audioOnlyStreams.withHighestBitrate();
    return audioStream.url.toString();
  }

  Future<String> getTitle(String videoId) async {
    var streamManifest = await _yt.videos.get(videoId);
    var videotitle = streamManifest.title;

    return videotitle;
  }

  AudioCubit() : super(false);

  void setUrl({String? url}) async {
    var link = await getAudioUrl(url!);
    var title = await getTitle(url);
    final playlist = ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse(link),
          tag: MediaItem(
            id: "1",
            album: "none",
            title: title,
          ))
    ]);
    player.setAudioSource(playlist);
  }

  void playAudio() {
    player.play();
  }

  void stopAudio() {
    player.stop();
  }
}
