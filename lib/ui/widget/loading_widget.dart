import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String msg;
  const LoadingWidget({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          Text(msg),
        ],
      ),
    );
  }
}
