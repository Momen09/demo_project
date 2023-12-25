import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDefault = AdaptiveTheme.of(context).isDefault;
    return SafeArea(child: Scaffold(
      body: Center(child: LoadingAnimationWidget.bouncingBall(
        color: isDefault?Colors.black:Colors.white,
        size: 100,
      ),
      ),),
    );
  }
}
