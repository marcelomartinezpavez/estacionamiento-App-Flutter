//import 'package:ptu/src/pages/area_or_hability_detail_page.dart';
import 'package:estacionamiento/src/pages/auth/auth_layout.dart';
import 'package:estacionamiento/src/pages/home_layout.dart';
import 'package:flutter/material.dart';

//import 'package:ptu/src/pages/examen_page.dart';
//import 'package:ptu/src/pages/home_page.dart';
//import 'package:ptu/src/pages/subject_overview_page.dart';
//import 'package:ptu/src/pages/terms_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const HomeLayout(),
    // 'profile': (BuildContext context) => ProfilePage(),
    // '/': (BuildContext context) => HomePage(),
    // 'profile': (BuildContext context) => ProfilePage(),
    'auth': (BuildContext context) => const AuthLayout(),
    // 'subject_overview': (BuildContext context) => SubjectOverviewPage(
    //     argument: ModalRoute.of(context)!.settings.arguments),
    // 'area_or_hability_detail': (BuildContext context) => AreaOrHabilityDetailPage(
    //     argument: ModalRoute.of(context)!.settings.arguments),
    // 'examen': (BuildContext context) =>
    //     ExamenPage(argument: ModalRoute.of(context)!.settings.arguments),
    // 'terms': (BuildContext context) => TermsPage(),
  };
}

goLogin(context) {
  Navigator.pushReplacementNamed(context, 'auth');
  // Navigator.pushNamed(context, 'auth');
}

goHome(context) {
  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  //Navigator.pushNamed(context, 'login');
}

goProfilePage(context) {
  Navigator.pushNamed(context, 'profile');
}

//modales
goTerms(context) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: Center(child: Container(/*child: TermsPage()*/)),
          ));

  /* Navigator.push(context, MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return TermsPage();
      },
      fullscreenDialog: true,

  ));*/
}
