import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shazam_clone/providers/song_provider.dart';
import 'package:shazam_clone/song.dart';
import 'package:shazam_clone/widgets/grabbing_widget.dart';
import 'package:shazam_clone/widgets/snapping_sheet_content_widget.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  late AnimationController animationController;
  final ScrollController listViewController = ScrollController();
  var breather = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.addListener(() {
      setState(() {
        breather = animationController.value;
      });
    });
    animationController.forward();

    super.initState();
  }

  bool animate = false;

  @override
  Widget build(BuildContext context) {
    final size = 200 - 20.0 * breather;
    bool success = context.watch<SongProvider>().success;
    if (success) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context)
            .push(createRoute(song: context.read<SongProvider>().currenSong));
      });
    }
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 4, 13, 19),
        body: SnappingSheet(
          lockOverflowDrag: true,
          grabbing: const GrabbingWidget(),
          grabbingHeight: 90,
          sheetBelow: SnappingSheetContent(
            draggable: true,
            childScrollController: listViewController,
            child: SnappingSheetContentWidget(
              listViewController: listViewController,
            ),
          ),
          child: LayoutBuilder(builder: (_, constraints) {
            final width = constraints.biggest.width;
            final height = constraints.biggest.height;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  context.read<SongProvider>().recongnizing
                      ? Positioned(
                          top: height * .1,
                          right: width * .03,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 63, 63, 63),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              context.read<SongProvider>().stop();
                            },
                            icon: const Icon(Icons.close),
                            label: const Text(
                              "Cancel",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        )
                      : Positioned(
                          top: height * .19,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.mic,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Tap to Shazam",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 40,
                  ),
                  Positioned(
                    child: AvatarGlow(
                      endRadius: 600.0,
                      animate: context.read<SongProvider>().recongnizing,
                      duration: const Duration(milliseconds: 3000),
                      repeat: true,
                      showTwoGlows: true,
                      child: GestureDetector(
                        onTap: () => context.read<SongProvider>().start(),
                        child: Material(
                          shape: const CircleBorder(),
                          child: Container(
                            padding: const EdgeInsets.all(50),
                            height: size,
                            width: size,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 63, 63, 63),
                            ),
                            child: Image.asset(
                              "assets/images/shazam.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  context.read<SongProvider>().recongnizing
                      ? Positioned(
                          bottom: height * .1,
                          child: SizedBox(
                            width: 300,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: 50,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Listening for music",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Make sure your music device can hear the song clearly",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 195, 194, 194),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            );
          }),
        ));
  }

  Route createRoute({required song}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Song(song: song),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
