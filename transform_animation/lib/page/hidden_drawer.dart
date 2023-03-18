import 'package:flutter/material.dart';

class HiddenDrawer extends StatelessWidget {
  const HiddenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            // color: Colors.blue,
            gradient: RadialGradient(
              radius: 1.0,
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 209, 209, 209),
              ],
            ),
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Material(
            color: Colors.transparent,
            child: CustomTabbar(),
          ),
        ),
      ],
    );
  }
}

class CustomTabbar extends StatefulWidget {
  const CustomTabbar({super.key});

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 80,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {},
              iconSize: 32,
              icon: const Icon(
                Icons.timelapse_outlined,
                color: Colors.grey,
              )),
          const SizedBox(
            height: 30.0,
          ),
          IconButton(
              onPressed: () {},
              iconSize: 32,
              icon: const Icon(
                Icons.alarm,
                color: Colors.grey,
              ))
        ],
      ),
    );
  }
}
