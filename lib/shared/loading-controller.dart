import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rf_app/shared/color-helper.dart';

class LoadingController extends StatelessWidget {
  final double size;
  final Color? color;

  const LoadingController({Key? key, this.color, this.size = 42})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: SpinKitFadingCircle(
          color: color ?? primaryColor,
          size: size,
        ),
      );
}
