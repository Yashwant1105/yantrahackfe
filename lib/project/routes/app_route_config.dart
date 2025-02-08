import 'package:amateurs/screens/camera_screen.dart';
import 'package:amateurs/screens/contributions_screen.dart';
import 'package:amateurs/screens/factory_login.dart';
import 'package:amateurs/screens/factory_main.dart';
import 'package:amateurs/screens/factory_signup.dart';
import 'package:amateurs/screens/recycle_screen.dart';
import 'package:amateurs/screens/user_login.dart';
import 'package:amateurs/screens/user_main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:amateurs/screens/user_signup.dart';
import 'app_route_constants.dart';

class MyAppRouter {
  static GoRouter returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: MyAppRouteConstants.UserLoginRouteName,
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(child: UserLogin());
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.UserSignupRouteName,
          path: '/usersignup',
          pageBuilder: (context, state) {
            return MaterialPage(child: UserSignUp());
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.FactorySignupRouteName,
          path: '/factorysignup',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: FactorySignup()); //change to FactorySignUp
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.CameraScanRouteName,
          path: '/camera',
          pageBuilder: (context, state) {
            return MaterialPage(child: CameraScreen()); //change to CameraScan
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.FactoryLoginRouteName,
          path: '/factorylogin',
          pageBuilder: (context, state) {
            return MaterialPage(child: FactoryLogin()); //change to FactoryLogin
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.MyContributionsRouteName,
          path: '/mycontributions',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: ContributionsScreen()); //change to MyContributions
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.RecycleScreenRouteName,
          path: '/recycle',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: RecycleScreen()); //change to RecycleScreen
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.UserMainRouteName,
          path: '/usermain',
          pageBuilder: (context, state) {
            return MaterialPage(child: UserMain()); //change to UserMain
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.FactoryMainRouteName,
          path: '/factorymain',
          pageBuilder: (context, state) {
            return MaterialPage(child: FactoryMain()); //change to FactoryMain
          },
        )
      ],
      // redirect: (context, state) {
      //   if (!isAuth &&
      //       state.location
      //           .startsWith('/${MyAppRouteConstants.profileRouteName}')) {
      //     return context.namedLocation(MyAppRouteConstants.contactUsRouteName);
      //   } else {
      //     return null;
      //   }
      // },
    );
    return router;
  }
}
