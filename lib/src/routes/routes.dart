import 'package:flutter/material.dart';
//import 'package:ptu/src/pages/area_or_hability_detail_page.dart';
import 'package:estacionamiento/src/pages/auth/auth_layout.dart';
import 'package:estacionamiento/src/pages/auth/login_page.dart';
//import 'package:ptu/src/pages/examen_page.dart';
//import 'package:ptu/src/pages/home_page.dart';
//import 'package:ptu/src/pages/subject_overview_page.dart';
//import 'package:ptu/src/pages/terms_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
   // '/': (BuildContext context) => HomePage(),
    // 'profile': (BuildContext context) => ProfilePage(),
    'auth': (BuildContext context) => AuthLayout(),
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
  Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  Navigator.pushNamed(context, 'login');
}

goHome(context) {
  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  //Navigator.pushNamed(context, 'login');
}



goArrears(context) {
  Navigator.pushNamedAndRemoveUntil(context, 'arrears', (route) => false);
  //Navigator.pushNamed(context, 'login');
}

goInternalProtocols(context) {
  Navigator.pushNamedAndRemoveUntil(context, 'protocols', (route) => false);
  //Navigator.pushNamed(context, 'login');
}

goJustification(context) {
  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  //Navigator.pushNamed(context, 'login');
}

goReports(context) {
  Navigator.pushNamedAndRemoveUntil(context, 'reports', (route) => false);
  //Navigator.pushNamed(context, 'login');
}

goHistory(context) {
  Navigator.pushNamedAndRemoveUntil(context, 'history', (route) => false);
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
