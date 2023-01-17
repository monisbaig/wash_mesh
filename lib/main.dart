import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/providers/auth_provider.dart';
import 'package:wash_mesh/splash_screen.dart';
import 'package:wash_mesh/widgets/custom_background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (context, child) => MaterialApp(
          title: 'Wash Mesh',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: const CustomBackground(
            ch: SplashScreen(),
            op: 1,
          ),
        ),
      ),
    );
  }
}
