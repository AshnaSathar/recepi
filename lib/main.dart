import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/items_controller.dart';
import 'package:flutter_application_1/controller/save_list_controller.dart';
import 'package:flutter_application_1/view/categories_page.dart';
import 'package:flutter_application_1/view/home_page.dart';
import 'package:flutter_application_1/view/nav_page.dart';
import 'package:flutter_application_1/view/login_page.dart';
import 'package:flutter_application_1/view/product_detail_page.dart';
import 'package:flutter_application_1/view/registration_page.dart';
import 'package:flutter_application_1/view/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SaveListController()),
        ChangeNotifierProvider(
            create: (_) => ItemsController()), // Providing the controller
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: '/nav-page/:index',
    builder: (context, state) {
      final index = int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
      return NavPage(index: index);
    },
  ),
  // GoRoute(
  //   path: '/nav-page/:index',
  //   builder: (context, state) => const NavPage(
  //     index: 0,
  //   ),
  // ),
  GoRoute(
    path: '/home-page',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/categories_page',
    builder: (context, state) => const CategoriesPage(),
  ),
  GoRoute(
    path: '/product-details',
    pageBuilder: (context, state) {
      final recipe =
          state.extra as Map<String, dynamic>; // Extract recipe from extra

      return CustomTransitionPage(
        key: state.pageKey,
        child: ProductDetailPage(recipe: recipe), // Pass recipe to page
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0), // Starts from right
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
      );
    },
  ),
  GoRoute(
    path: '/login-page',
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0), // Starts from right
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    ),
  ),
  GoRoute(
    path: '/registration-page',
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: RegistrationPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    ),
  ),
]);
