import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/pages/authentication/auth_wrapper/auth_wrapper.dart';
import 'package:gym_tracker/pages/widgets/safe-area_top_padding.dart';
import 'package:gym_tracker/routing/app_router.dart';
import 'package:gym_tracker/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: AuthWrapper(),
      builder: (context, child) {
        return RootMediaQueryDataHolder(
          data: MediaQuery.of(context),
          child: child,
        );
      },
    );
  }
}
