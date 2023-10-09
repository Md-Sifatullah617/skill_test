import 'dart:async';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _isIconCross = false;
  bool _showOptions = false;
  List<Widget> navIcons = [
    const Icon(
      Icons.home,
      size: 30,
    ),
    const Icon(
      Icons.search,
      size: 30,
    ),
    const Icon(
      Icons.add,
      size: 30,
    ),
    const Icon(
      Icons.favorite,
      size: 30,
    ),
    const Icon(
      Icons.person,
      size: 30,
    ),
  ];
  void _toggleOptions() {
    setState(() {
      _isIconCross = !_isIconCross;
      Timer(const Duration(milliseconds: 250), () {
        setState(() {
          _showOptions = !_showOptions;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: const Text('Skill Test'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _isIconCross ? h * 0.26 : 0,
                width: w * 0.6,
                decoration: BoxDecoration(
                  color: const Color(0xff7e83e0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                  children: [
                    Column(
                      children: [
                        SizedBox(height: h * 0.02),
                        ListTile(
                          title: const Text('Mood check-in',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          trailing: const Icon(Icons.mood, color: Colors.white),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('Voice note',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          trailing: const Icon(Icons.mic, color: Colors.white),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('Add photo',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          trailing:
                              const Icon(Icons.camera_alt, color: Colors.white),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: h * 0.065),
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              onTap: _toggleOptions,
              child: Container(
                  height: w * 0.16,
                  width: w * 0.17,
                  decoration: BoxDecoration(
                      color: const Color(0xff7e83e0),
                      borderRadius: _isIconCross
                          ? _showOptions
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )
                              : BorderRadius.circular(20)
                          : BorderRadius.circular(20)),
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: _isIconCross ? 0.50 : 0,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 35,
                    ),
                  )),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Stack(
        children: [
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 3,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 350),
              opacity: _isIconCross ? 0 : 1,
              child: Container(height: 50, width: w * 0.4, color: Colors.white),
            ),
          ),
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 3,
            child: AnimatedOpacity(
              duration: Duration(
                  milliseconds: _isIconCross
                      ? 0
                      : _showOptions
                          ? 0
                          : 100),
              curve: Curves.bounceInOut,
              opacity: _isIconCross
                  ? 1
                  : _showOptions
                      ? 1
                      : 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: _showOptions ? 300 : 0),
                curve: Curves.easeInOut,
                height: 50,
                width: w * 0.4,
                color: const Color(0xff7e83e0),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 4,
              height: 70,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...List.generate(
                          navIcons.length,
                          (index) => IconButton(
                                onPressed: () {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                                icon: navIcons[index],
                                color: _currentIndex == index
                                    ? const Color(0xff7e83e0)
                                    : Colors.grey,
                              ))
                    ],
                  ),
                  for (int i = 0; i < 5; i++)
                    if (i == _currentIndex)
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          bottom: 10,
                          left:
                              (MediaQuery.of(context).size.width / 5 * i) + 35,
                          child: const Icon(
                            Icons.circle,
                            size: 10,
                          )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
