import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Refresher extends StatelessWidget {
  final Widget child;
  final VoidCallback onRefresh;

  Refresher({
    this.child,
    @required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: child,
      );
    }
    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
      refreshIndicatorExtent: 100,
      refreshTriggerPullDistance: 100,
    );
  }
}
