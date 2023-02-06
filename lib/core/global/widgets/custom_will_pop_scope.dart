import 'package:flutter/material.dart';

class CustomWillPopScope extends StatelessWidget {
  const CustomWillPopScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return Container();
          },
        );
        return shouldPop!;
      },
      child: child,
    );
  }
}
