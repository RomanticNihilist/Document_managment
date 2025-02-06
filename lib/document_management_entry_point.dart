import 'package:document_management_main/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'data/profile_page_menu_data.dart';
import 'dart:io';
import 'package:menu_submenu_sidebar_dropdown_accordian_package/menu_submenu_sidebar_dropdown_accordian_package.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class DocumentManagementEntryPoint extends StatefulWidget {
  const DocumentManagementEntryPoint({super.key});

  @override
  State<DocumentManagementEntryPoint> createState() =>
      _DocumentManagementEntryPointState();
}

class _DocumentManagementEntryPointState
    extends State<DocumentManagementEntryPoint> {
  bool _isDarkMode = false;
  late ColorScheme _colorScheme;
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    themeMode = ThemeMode.system;
    _colorScheme = ColorScheme.fromSwatch(
      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
    );
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = themeMode == ThemeMode.light ? true : false;
      themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
      _colorScheme = ColorScheme.fromSwatch(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      );
    });
  }

  void _updateTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
      themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
      _colorScheme = ColorScheme.fromSwatch(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      );
    });
  }

  void _updateColorScheme(ColorScheme newScheme) {
    setState(() {
      _colorScheme = newScheme;
    });
  }

  void _onMenuItemSelected(Widget widget) {
    setState(() {
      // Handle navigation or widget replacement based on selection
      // For example, navigate to a new page
// Reset or set based on selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Document Management',
      theme: ThemeData.from(
        colorScheme: _colorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.from(
        colorScheme: _colorScheme.copyWith(brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: themeMode,
      navigatorObservers: [routeObserver],
      home: Scaffold(
        drawer: Drawer(
          child: MenuWithSubMenu(
            menuItems: menuItems,
            themeMode: themeMode,
            colorScheme: _colorScheme,
            updateTheme: _updateTheme,
            updateColorScheme: _updateColorScheme,
            // onMenuItemSelected: _onMenuItemSelected,
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Document Management",
            style: TextStyle(color: _colorScheme.primary),
          ),
          actions:const [
             Padding(
              padding:  EdgeInsets.fromLTRB(0.0, 0.0, 22.0, 0.0),
              child:  SearchBarWidget(),
            ),
          ],
        ),
        body: BottomNavigation(
          colorScheme: _colorScheme,
          themeMode: themeMode,
          isDarkMode: _isDarkMode,
          updateTheme: _updateTheme,
          updateColorScheme: _updateColorScheme,
        ),
      ),
    );
  }
}
