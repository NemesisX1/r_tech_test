import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repat_event/core/l10n/l10n.dart';
import 'package:repat_event/core/themes/app_colors.dart';
import 'package:repat_event/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: const Color(0xffFFFBEB),
        textTheme: GoogleFonts.nunitoTextTheme(),
        primaryTextTheme: GoogleFonts.nunitoTextTheme(),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.transparent,
          backgroundColor: const Color(0xffFFFBEB),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: true,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        chipTheme: const ChipThemeData(
          selectedColor: AppColors.primary,
          disabledColor: Color(0xffFFF2CF),
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          side: BorderSide(
            color: Colors.transparent,
          ),
          checkmarkColor: Colors.white,
          secondaryLabelStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
            side: const BorderSide(
              color: Color(0xffFFCD7E),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffB01C26),
            padding: const EdgeInsets.all(16),
            elevation: 8,
            shadowColor: const Color(0xffC71717),
            side: const BorderSide(
              color: Color(0xffC7333D),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: EdgeInsets.zero,
            textStyle: const TextStyle(
              fontFamily: 'SFProDisplay',
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        radioTheme: const RadioThemeData(
          fillColor: WidgetStatePropertyAll(AppColors.primary),
        ),
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: AppColors.gray,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(
            fontFamily: 'SFProDisplay',
            color: Colors.black,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'SFProDisplay',
            color: AppColors.gray,
          ),
          showSelectedLabels: true,
          selectedIconTheme: IconThemeData(
            color: Color(0xffB01C26),
            size: 30,
            shadows: [
              BoxShadow(
                color: Color(0xffB01C26),
                blurRadius: 100,
                spreadRadius: -20,
                offset: Offset(
                  0,
                  30,
                ),
              ),
              BoxShadow(
                color: Color(0xffFCACAA),
                blurRadius: 60,
                spreadRadius: -30,
                offset: Offset(
                  0,
                  20,
                ),
              ),
            ],
          ),
          unselectedIconTheme: IconThemeData(
            size: 30,
          ),
          unselectedItemColor: AppColors.gray,
          showUnselectedLabels: true,
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
