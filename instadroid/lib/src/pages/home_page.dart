import 'package:flutter/material.dart';
import 'package:instadroid/src/models/publicacion_model.dart';
import 'package:instadroid/src/pages/profile_page.dart';
import 'package:instadroid/src/pages/timeline_page.dart';
import 'package:instadroid/src/providers/publicaciones_provider.dart';
import 'package:instadroid/src/theme/mytheme.dart';
import 'package:instadroid/src/widgets/app_title.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create : (_) => _Navegacion(),
      child: Scaffold(
        appBar: AppBar(
          title: Transform(
            transform:  Matrix4.translationValues(-80.0, 0.0, 0.0),
            child: AppTitle(
              color: Colors.black,
              size: 35.0,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(Icons.map, color: Colors.black),
              onPressed: () async {
                final publicacionesProvider = PublicacionesProvider();
                final List<Publicacion> listaPublis = await publicacionesProvider.listarPublicaciones();
                Navigator.pushNamed(context, 'mapa', arguments: listaPublis);
              },
            ),
          ],
        ),
        body: _Pages(),
        floatingActionButton: FloatingActionButton( 
          child: Icon(Icons.camera_alt, color: Colors.white),
          backgroundColor: myTheme.buttonColor,
          onPressed: (){
            //Navegación a la página de subir foto
            Navigator.pushNamed(context, 'foto');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: _BottomNavigation() ,
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacion = Provider.of<_Navegacion> (context);

    return PageView(
      controller: navegacion.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        TimelinePage(),
        ProfilePage(),
      ],
    );
  }
}


class _BottomNavigation extends StatefulWidget {
  @override
  __BottomNavigationState createState() => __BottomNavigationState();
}

class __BottomNavigationState extends State<_BottomNavigation> {

  int _index; 
  
  @override
  void initState() { 
    super.initState();
    _index = 0;
  }
  @override
  Widget build(BuildContext context) {
    final navegacion = Provider.of<_Navegacion> (context);

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(55, 70, 91, 1.0),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (newIndex){
          setState(() {
            _index = newIndex;
          });
          navegacion.currentPage = newIndex;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_index == 0)
                ? myTheme.buttonColor 
                : Colors.white,
            ),
            label: '',
          ), 
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_index == 1)
                ? myTheme.buttonColor 
                : Colors.white,
            ),
            label: '',
          ), 
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: (_index == 2)
                ? myTheme.buttonColor 
                : Colors.white,
            ),
            label: '',
          ), 
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outline_rounded,
              color: (_index == 3)
                ? myTheme.buttonColor 
                : Colors.white,
            ),
            label: '',
          ), 
        ],
      ),
    );
  }
}


class _Navegacion with ChangeNotifier {

  int _currentPage = 0;
  PageController _pageController = PageController();

  int get currentPage => this._currentPage;

  set currentPage (int newIndex){
    this._currentPage = newIndex;
    this._pageController.animateToPage(
      newIndex, 
      duration: Duration(milliseconds:250), 
      curve: Curves.easeOut
    );
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
