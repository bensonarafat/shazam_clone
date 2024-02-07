import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:flutter/material.dart';
import 'package:shazam_clone/constants.dart';
import 'package:shazam_clone/models/song_model.dart';
import 'package:shazam_clone/repository/song_repository.dart';

class SongProvider extends ChangeNotifier {
  SongProvider() {
    initAcr();
  }

  final AcrCloudSdk arc = AcrCloudSdk();
  late SpotifySongModel currenSong;
  bool recongnizing = false;
  bool success = false;

  Future<void> initAcr() async {
    try {
      arc
        ..init(
          host: host,
          accessKey: accessKey,
          accessSecret: secretKey,
          setLog: false,
          requestTimeout: const Duration(minutes: 1),
        )
        ..songModelStream.listen(searchSong);
    } catch (_) {
      print(_.toString());
    }
  }

  void searchSong(SongModel song) async {
    final metaData = song.metadata;
    print(song.status?.msg);
    if (metaData != null && metaData.music != null) {
      if (metaData.music!.isNotEmpty) {
        String? trackId =
            metaData.music![0].externalMetadata?.spotify?.track?.id;
        try {
          final response = await SongRepository.getTrack(trackId: trackId!);
          if (response != null) {
            currenSong = response;
            success = true;

            recongnizing = false;
            notifyListeners();
          } else {
            recongnizing = false;
            success = false;
            notifyListeners();
          }
        } catch (_) {
          recongnizing = false;
          success = false;
          notifyListeners();
        }
      } else {
        recongnizing = false;
        success = false;
        notifyListeners();
      }
    } else {
      print("Error 4");

      recongnizing = false;
      success = false;
      notifyListeners();
    }
  }

  void start() async {
    try {
      recongnizing = true;
      success = false;
      notifyListeners();
      await arc.start();
    } catch (_) {
      print("Start Error ${_.toString()}");
    }
  }

  void stop() async {
    try {
      recongnizing = false;
      success = false;
      notifyListeners();
      await arc.stop();
    } catch (_) {
      print("Stop Error ${_.toString()}");
    }
  }
}
