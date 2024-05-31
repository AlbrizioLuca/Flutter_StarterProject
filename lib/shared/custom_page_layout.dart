import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/components/switchMode.dart';
import 'package:flutter_starter/screens/home_page.dart';
import 'package:flutter_starter/screens/profile_details.dart';
import 'package:flutter_starter/services/auth_service.dart';
import 'package:provider/provider.dart';

class CustomPageLayout extends StatefulWidget {
  const CustomPageLayout();

  @override
  State<CustomPageLayout> createState() => _CustomPageLayout();
}

class _CustomPageLayout extends State<CustomPageLayout> {
  int _selectedItem = 2;
  Widget mainView = HomePage();
  String mainTitle = "Accueil";

  void _onTap(int index) {
    if (!_isClickIndexValid(index)) {
      mainTitle = "Sans titre";
      mainView = Text("Not found");
      return;
    }

    setState(() {
      _selectedItem = index;
      mainView = _getPageBody(index);
      mainTitle = _getPageTitle(index);
    });
  }

  bool _isClickIndexValid(int index) {
    if (_screenTitle.length > index && _screenBodies.length > index) {
      return true;
    }
    return false;
  }

  List<Widget> _screenBodies = [
    // Text("Page Profil à venir"),
    ProfileDetails() as Widget,
    Text("Page Abonnements à venir"),
    // ListAbonnements() as Widget,
    HomePage() as Widget,
    // VideoTutorials() as Widget,
    Text("Page Tutoriels à venir"),
    // Settings() as Widget,
    Text("Page Settings à venir"),
  ];

  List<String> _screenTitle = [
    "Mon profil",
    "Mes abonnements",
    "Home",
    "Vidéo tutoriels",
    "Paramètres",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(mainTitle),
        actions: [
          SwitchMode(),
          TextButton(
              child: Icon(Icons.logout),
              onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Déconnexion"),
                        content: Text("Confirmez vous la déconnexion ?"),
                        actions: [
                          TextButton(
                            child: Text("Annuler",
                                style: TextStyle(color: Colors.red)),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text("Oui",
                                style: TextStyle(color: Colors.green)),
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<AuthService>(context, listen: false)
                                  .logout();
                            },
                          ),
                        ],
                      );
                    },
                  )),
        ],
      ),
      body: mainView,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        currentIndex: _selectedItem,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.list),
            label: "Abonnements",
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.house),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.film),
            label: "Tutoriels",
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.gear),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  String _getPageTitle(int index) {
    return _screenTitle.elementAt(index);
  }

  Widget _getPageBody(int index) {
    return _screenBodies.elementAt(index);
  }
}
