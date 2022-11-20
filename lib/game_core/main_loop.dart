import 'dart:isolate';

import 'package:time/time.dart';

bool _running = true;
final Duration tenMinutes = 10.minutes;

void mainLoop(SendPort sendPort) async {
  const double _fps = 50;
  const double _second = 1000;
  const double _updateTime = _second / _fps;
  double _updates = 0;

  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();
  Stopwatch _timerWatch = Stopwatch();
  _timerWatch.start();

  while (_running) {
    if (_loopWatch.elapsedMilliseconds > _updateTime) {
      _updates++;
      _loopWatch.reset();
      sendPort.send(true);
    }
    if (_timerWatch.elapsedMilliseconds > _second) {
      final d = DateTime.now();
      print('${d.hour}:${d.minute}:${d.second} -> FPS: $_updates');
      _updates = 0;
      _timerWatch.reset();
    }
  }
}

void stopLoop() {
  _running = false;
}
