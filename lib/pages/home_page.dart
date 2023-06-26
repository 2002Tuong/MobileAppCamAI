import 'dart:ui';

import 'package:cloudgo_mobileapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<HomeScreen> {
  bool isExpanded = false;
  bool isChanged = false;
  BorderRadiusGeometry radius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 24,
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "DASHBOARD",
          style: GoogleFonts.robotoCondensed(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        leading: GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/logo.png"),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      body: SlidingUpPanel(
        color: const Color(0XFF465475),
        minHeight: 200,
        maxHeight: 330,
        onPanelSlide: (double slideAmount) {
          setState(() {
            isExpanded = slideAmount > 0.15;
            isChanged = slideAmount > 0.5;
          });
        },
        panelBuilder: (scrollController) =>
            _buildSlidingPanel(scrollController),
        body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 0),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          'HI NGUYÊN BUỔI SÁNG',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Một ngày làm việc vui vẻ nha !',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        borderRadius: radius,
      ),
    );
  }

  Widget _buildSlidingPanel(ScrollController scrollController) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          isChanged
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.expand_more,
                      size: 32,
                      color: Color.fromARGB(199, 172, 176, 184),
                    ),
                  ],
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.expand_less,
                      size: 32,
                      color: Color.fromARGB(199, 172, 176, 184),
                    ),
                  ],
                ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chức năng chính',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                Icon(
                  Icons.help,
                  size: 24,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Tạo button
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconWidgets(
                      iconPath: "assets/Icon_Notify.png",
                      text: 'Thông báo',
                      onPressed: demo,
                      vcolor: Color(0xff525F80),
                      isText: true,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconWidgets(
                      iconPath: "assets/Icon_AICam.png",
                      text: 'Check-in AI',
                      onPressed: demo,
                      vcolor: Color(0xff525F80),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconWidgets(
                      iconPath: "assets/Icon_Maps.png",
                      text: 'Check-in GPS',
                      onPressed: demo,
                      vcolor: Color(0xff525F80),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconWidgets(
                      iconPath: "assets/Icon_Documents.png",
                      text: 'ĐK nghỉ phép',
                      onPressed: demo,
                      vcolor: Color(0xffF9CA54),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isExpanded)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //Button
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconWidgets(
                          iconPath: "assets/Icon_Wifi.png",
                          text: 'Check-in WiFi',
                          onPressed: demo,
                          vcolor: Color(0xff525F80),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconWidgets(
                          iconPath: "assets/Icon_Log.png",
                          text: 'Log Check-in',
                          onPressed: demo,
                          vcolor: Color(0xff525F80),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconWidgets(
                          iconPath: "assets/Icon_Calendar.png",
                          text: 'Lịch làm việc',
                          onPressed: demo,
                          vcolor: Color(0xff525F80),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconWidgets(
                          iconPath: "assets/Icon_Edit.png",
                          text: 'Xét duyệt NV',
                          onPressed: demo,
                          vcolor: Color(0xff00FFC2),
                          isText: true,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/Logo_CloudGo.png")),
                  ],
                ),
              ]),
            ),
        ],
      ),
    );
  }
}

void demo() {}
