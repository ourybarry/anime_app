import 'package:anime/ui/themes/custom_colors.dart';
import 'package:flutter/material.dart';

typedef void OnRetryCallback();

class ErrorRetry extends StatelessWidget {
  final String heading;
  final String message;
  final OnRetryCallback onRetryPressed;
  const ErrorRetry(
      {Key? key,
      required this.heading,
      required this.message,
      required this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(children: [
          Icon(Icons.error),
          Column(
            children: [
              Text(
                heading,
                style: TextStyle(color: CustomColors.PRIMARY_COLOR),
              ),
              Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
              TextButton(onPressed: onRetryPressed, child: Text('Retry'))
            ],
          ),
        ]),
      ),
    );
  }
}
