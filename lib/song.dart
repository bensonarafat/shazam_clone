import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shazam_clone/models/song_model.dart';
import 'package:shazam_clone/widgets/grabbing_widget.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import 'providers/song_provider.dart';

class Song extends StatefulWidget {
  final SpotifySongModel song;
  const Song({
    super.key,
    required this.song,
  });

  @override
  State<Song> createState() => _SongState();
}

class _SongState extends State<Song> {
  late SpotifySongModel song;
  final ScrollController listViewController = ScrollController();
  @override
  void initState() {
    song = widget.song;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SnappingSheet(
        lockOverflowDrag: true,
        grabbingHeight: 150,
        grabbing: const GrabbingWidget(),
        sheetBelow: SnappingSheetContent(
          draggable: true,
          childScrollController: listViewController,
          child: Container(),
        ),
        child: LayoutBuilder(builder: (_, BoxConstraints box) {
          return Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: box.maxHeight / 1.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(song.album!.images![0].url!),
                fit: BoxFit.cover,
              ),
            ),
            child: customAppBar(context),
          );
        }),
      ),
    );
  }

  Container customAppBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(146, 255, 254, 254),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(146, 255, 254, 254),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.music_note,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(146, 255, 254, 254),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(146, 255, 254, 254),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
