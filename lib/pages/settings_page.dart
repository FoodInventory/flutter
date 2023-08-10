import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('Paramètres'),
          tiles: [
            SettingsTile(
              title: const Text('Compte'),
              leading: const Icon(Icons.account_circle),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: const Text('Thème'),
              leading: const Icon(Icons.color_lens),
              onPressed: (BuildContext context) {},
            ),
          ],
        ),
        SettingsSection(
          title: const Text('Informations'),
          tiles: [
            SettingsTile(
              title: const Text('A propos'),
              leading: const Icon(Icons.info),
              onPressed: (BuildContext context) {
                showGeneralDialog(
                    context: context,
                    pageBuilder: (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                    ) {
                      // dialog de presentation de l'application avec l'icon, le nom et la version
                      return AlertDialog(
                        content: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.inventory_rounded,
                              size: 50,
                            ),
                            Text(
                              'Food Inventory',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Version 1.0.0'),
                            SizedBox(height: 10),
                            Text(
                              '© 2021 - bastianfbr',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
              },
            ),
            SettingsTile(
              title: const Text('Licences'),
              leading: const Icon(Icons.verified_user),
              onPressed: (BuildContext context) {
                showLicensePage(context: context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
