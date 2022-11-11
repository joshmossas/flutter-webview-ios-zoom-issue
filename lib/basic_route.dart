import 'package:flutter/material.dart';

class BasicRoute extends PageRouteBuilder {
  final Widget page;
  BasicRoute(this.page) : super(pageBuilder: (_, __, ___) => page);
}
