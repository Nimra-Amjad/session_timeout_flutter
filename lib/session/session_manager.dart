import 'dart:async';

import 'package:flutter/material.dart';

class SessionManager extends StatefulWidget {
  final Widget child;
  final VoidCallback onSessionExpired;
  final Duration duration;
  final StreamController streamController;
  const SessionManager(
      {super.key,
      required this.child,
      required this.onSessionExpired,
      required this.duration,
      required this.streamController});

  @override
  State<SessionManager> createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager> {
  Timer? timer;
  StreamController? streamController;
  void sessionStart() {
    closeTimer();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(widget.duration, (timer) {
      widget.onSessionExpired();
      closeTimer();
    });
  }

  void closeTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamController = StreamController();
    streamController = widget.streamController;
    if (streamController != null) {
      streamController!.stream.listen((event) {
        if (event != null && event["timer"] as bool) {
          sessionStart();
        } else {
          closeTimer();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        sessionStart();
      },
      child: widget.child,
    );
  }
}
