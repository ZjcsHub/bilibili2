import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingContainer extends StatelessWidget {
  final Widget? child;
  final bool isLoading;
  final bool cover;
  const LoadingContainer(
      {Key? key, this.child, required this.isLoading, this.cover = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [this.isLoading ? _loadingView() : Container()],
      );
    } else {
      return this.isLoading ? _loadingView() : child;
    }
  }

  _loadingView() {
    return Center(
      child: Lottie.asset('assets/loading.json'),
    );
  }
}
