// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubit/theme_cubit.dart';

class SettingBottomSheetWidget extends StatefulWidget {
  const SettingBottomSheetWidget({super.key});

  @override
  State<SettingBottomSheetWidget> createState() =>
      _SettingBottomSheetWidgetState();
}

class _SettingBottomSheetWidgetState extends State<SettingBottomSheetWidget> {
  bool isTurnSwitch = false;

  @override
  void initState() {
    super.initState();
    isTurnSwitch = ThemeMode.dark == context.read<ThemeCubit>().state.themeMode;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            Icons.menu,
            color: Theme.of(context).colorScheme.onSurface,
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
                              if (isTurnSwitch)
                                Icons.dark_mode
                              else
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
                                leading: Icon(
                                  icons[index],
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                title: Text(
                                  titles[index],
                                ),
                                trailing: index == 0
                                    ? Switch(
                                        value: isTurnSwitch,
                                        onChanged: (val) {
                                          context
                                              .read<ThemeCubit>()
                                              .updateTheme(
                                                val
                                                    ? ThemeMode.dark
                                                    : ThemeMode.light,
                                              );
                                          setState(() {
                                            isTurnSwitch = val;
                                          });
                                        },
                                      )
                                    : null,
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
      },
    );
  }
}
