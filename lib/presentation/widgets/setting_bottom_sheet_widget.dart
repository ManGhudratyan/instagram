// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class SettingBottomSheetWidget extends StatelessWidget {
  const SettingBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: 430,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        final titles = [
                          'Dark Mode',
                          'Your activity',
                          'Archive',
                          'QR code',
                          'Saved',
                          'Close Friends',
                          'Favorites',
                        ];
                        final icons = [
                          Icons.light_mode,
                          Icons.lock_clock_rounded,
                          Icons.archive,
                          Icons.qr_code,
                          Icons.saved_search_sharp,
                          Icons.save_alt,
                          Icons.favorite_border,
                        ];
                        return Card(
                          child: ListTile(
                            leading: Icon(icons[index]),
                            title: Text(titles[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
