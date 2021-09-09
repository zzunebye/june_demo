import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.purple, Colors.deepPurpleAccent]),
            ),
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: FittedBox(
                      child: Icon(Icons.verified_user),
                    ),
                  ),
                ),
                title: Text('Junyoung',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                subtitle: Text('+852 95401225',
                    style: TextStyle(color: Colors.white60, fontSize: 12)),
                trailing: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.alt_route),
            ),
            title: Text('Preference'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.view_list),
            ),
            title: Text('Job List'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.app_settings_alt),
            ),
            title: Text('Setting'),
          ),
        ],
      ),
    );
  }
}
