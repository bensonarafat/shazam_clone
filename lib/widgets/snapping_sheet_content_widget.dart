import 'package:flutter/material.dart';

class SnappingSheetContentWidget extends StatelessWidget {
  final ScrollController listViewController;
  const SnappingSheetContentWidget(
      {super.key, required this.listViewController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: listViewController,
      child: Container(
        color: const Color.fromARGB(255, 4, 13, 19),
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Music",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 5,
              ),
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 5,
                right: 5,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 27, 38),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Shazams",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 253, 253),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Color.fromARGB(255, 201, 200, 200),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 5,
                bottom: 10,
              ),
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 5,
                right: 5,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 27, 38),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Artists",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Color.fromARGB(255, 201, 200, 200),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Recent Shazams",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  mainAxisExtent: 340,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 11, 27, 38),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 180,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/track.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color.fromARGB(203, 11, 27, 38),
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "After You (feat. Calle Lehmann)",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Gryffin",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/spotify.png",
                            width: 60,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
