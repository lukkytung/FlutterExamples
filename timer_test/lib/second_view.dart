import 'package:flutter/material.dart';
import 'package:timer_test/my_timer.dart';

class SecondView extends StatefulWidget {
  const SecondView({super.key});

  @override
  State<SecondView> createState() => _SecondViewState();
}

class _SecondViewState extends State<SecondView> {
  int focusSec = 60;
  int restSec = 30;
  int curFocus = 60;
  int curRest = 30;

  @override
  void initState() {
    super.initState();

    if (MyTimer().isActive && !MyTimer().isCounting) {
      MyTimer().runTimer(type: MyTimerControlType.normal);
    }

    MyTimer().addListener(() {
      curFocus = focusSec - MyTimer().curFocus;
      curRest = restSec - MyTimer().curRest;

      switch (MyTimer().state) {
        case MyTimerState.normal:
          curFocus = MyTimer().curFocus;
          curRest = MyTimer().curRest;
          if (curFocus == 0 && curRest == 0) {
            curFocus = focusSec;
            curRest = restSec;
          }
          break;
        case MyTimerState.focus:
          print("==========专注倒计时：$curFocus");
          break;
        case MyTimerState.focusFinish:
          print("==========专注结束");
          curFocus = 0;
          break;
        case MyTimerState.rest:
          print("==========休息倒计时：$curRest");
          break;
        case MyTimerState.restFinish:
          print("==========休息结束");
          curFocus = focusSec;
          curRest = restSec;
          break;
        case MyTimerState.start:
          print("=======【开始倒计时】======");
          break;
        case MyTimerState.refresh:
          print("=======【刷新重置】======");
          curFocus = focusSec;
          curRest = restSec;
          break;
        case MyTimerState.stop:
          print("=======【停止倒计时】======");
          curFocus = focusSec;
          curRest = restSec;
          break;
        case MyTimerState.pause:
          print("=======【暂停倒计时】======");
          break;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    MyTimer().removeListener(() {});
  }

  void _startOrPause() {
    MyTimer().runTimer(
      type: MyTimer().isCounting
          ? MyTimerControlType.pause
          : MyTimerControlType.start,
      focusValue: focusSec,
      restValue: restSec,
    );
    // 刷新按钮状态
    setState(() {});
  }

  void _stop() {
    // 重置UI
    MyTimer().runTimer(type: MyTimerControlType.stop);
  }

  void _refresh() {
    MyTimer().runTimer(
      type: MyTimerControlType.refresh,
      focusValue: focusSec,
      restValue: restSec,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'TimerManager',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'Focus:$curFocus',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Rest:$curRest',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _stop,
                  child: const Icon(Icons.stop),
                ),
                FloatingActionButton(
                  onPressed: _refresh,
                  child: const Icon(Icons.refresh),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _startOrPause();
                  },
                  child: MyTimer().isCounting
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
