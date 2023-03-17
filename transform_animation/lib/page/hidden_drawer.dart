import 'package:flutter/material.dart';

class HiddenDrawer extends StatelessWidget {
  const HiddenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.blue),
        const Align(
          alignment: Alignment.bottomCenter,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        // height: 44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {},
                iconSize: 32,
                icon: const Icon(
                  Icons.timelapse_outlined,
                  color: Colors.white70,
                )),
            const SizedBox(
              width: 30.0,
            ),
            IconButton(
                onPressed: () {},
                iconSize: 32,
                icon: const Icon(
                  Icons.alarm,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
