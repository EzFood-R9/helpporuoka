// ignore_for_file: prefer_const_constructors

import 'package:ezfood/sivut/home_page.dart';
import 'package:ezfood/sivut/login_page.dart';
import 'package:flutter/material.dart';
import 'package:ezfood/sivut/favourites.dart';
import 'package:ezfood/sivut/settings.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:ezfood/sivut/auth_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

bool _iconbool = false;

IconData _iconLight = Icons.wb_sunny;
IconData _icondark = Icons.nightlight;

ThemeData _lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.light,
);
ThemeData _darkTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  brightness: Brightness.dark,
);

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  String searchValue = '';
  final List<String> _suggestions = [
    'pahaa ruokaa helposti',
    'kova nälkä on',
    'helppo ruoka alle 1 euro'
  ];
  List<Widget> pages = [
    Favourites(),
    HomePage(),
    settings(),
    LoginPage(
      onTap: () {},
    )
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _iconbool ? _darkTheme : _lightTheme,
        home: Scaffold(
          appBar: EasySearchBar(
            onSearch: (value) => setState(() => searchValue = value),
            suggestions: _suggestions,
            title: const Text(''),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _iconbool = !_iconbool;
                    });
                  },
                  icon: Icon(_iconbool ? _icondark : _iconLight))
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/tausta.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: pages[currentPage],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              debugPrint('Floating Action button');
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: NavigationBar(
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.favorite), label: 'Favourites'),
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.settings), label: 'Settings'),
              NavigationDestination(icon: Icon(Icons.lock), label: 'Login'),
            ],
            onDestinationSelected: (int index) {
              setState(() {
                currentPage = index;
              });
            },
            selectedIndex: currentPage,
          ),
        ));
  }
}
