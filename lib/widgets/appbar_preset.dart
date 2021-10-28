import 'package:flutter/material.dart';

class AppBarPreset extends StatelessWidget with PreferredSizeWidget {
  final Widget appBartitle;
  List<Widget>? appActions = <Widget>[];
  Widget? leading;

  AppBarPreset({required this.appBartitle, this.appActions, this.leading});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      foregroundColor: Theme.of(context).primaryColor,
      title: appBartitle,
      actions: appActions,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
