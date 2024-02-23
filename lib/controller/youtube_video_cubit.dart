import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SetBackgroundCubit extends Cubit<String> {
  SetBackgroundCubit() : super("");

  void getVideoid(String url) {
    var videoId = YoutubePlayer.convertUrlToId(url);
    emit(videoId!);
  }
}
