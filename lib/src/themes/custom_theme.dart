import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData freeTheme(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xffF5B953));
    return ThemeData(
        colorScheme: colorScheme,
        cardColor: colorScheme.surface,
        canvasColor: colorScheme.surfaceVariant,
        errorColor: colorScheme.error,
        scaffoldBackgroundColor: colorScheme.background,
        appBarTheme:  AppBarTheme(
          backgroundColor: Colors.transparent,
          titleTextStyle: GoogleFonts.oswald(
            fontSize: 28,
            color: colorScheme.onBackground,
            fontWeight: FontWeight.w600,

          ),
          elevation: 0,
        ),
        dialogBackgroundColor: colorScheme.surface,
        iconTheme: IconThemeData(color: colorScheme.primary, size: 25),
        backgroundColor: colorScheme.background,
        dividerTheme: DividerThemeData(
            thickness: 0.3,
            indent: 20,
            endIndent: 20,
            color: colorScheme.outline),
        dividerColor: colorScheme.outline,
        checkboxTheme: CheckboxThemeData(
          // checkColor: MaterialStateProperty.all<Color>(colorScheme.primary),
          fillColor: MaterialStateProperty.all<Color>(colorScheme.secondary),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: colorScheme.background,
            elevation: 20,
            showUnselectedLabels: false,
            showSelectedLabels: false,

            type: BottomNavigationBarType.fixed),
        sliderTheme: SliderThemeData(
            activeTrackColor: colorScheme.onBackground,
            inactiveTrackColor: colorScheme.onBackground.withOpacity(0.5),
            thumbColor: colorScheme.onBackground,
            thumbShape: SliderComponentShape.noThumb,
            valueIndicatorColor: colorScheme.onBackground,
            inactiveTickMarkColor: colorScheme.onBackground,
            activeTickMarkColor: colorScheme.onBackground,
            overlayColor: colorScheme.onBackground,
            rangeValueIndicatorShape:
                const RectangularRangeSliderValueIndicatorShape(),
            disabledActiveTrackColor: colorScheme.onBackground),
        textTheme: TextTheme(
          headline1: GoogleFonts.oswald(
            fontSize: 92.0,
            fontWeight: FontWeight.w600,
            color: colorScheme.onBackground,
          ),
          headline2: GoogleFonts.oswald(
            fontSize: 62.0,
            fontWeight: FontWeight.w600,
            color: colorScheme.onBackground,
          ),
          headline3: GoogleFonts.oswald(
              fontSize: 42,
            fontWeight: FontWeight.w600,

              color: colorScheme.onBackground,),
          headline4: GoogleFonts.oswald(
            fontSize: 28,
            color: colorScheme.onBackground,
            fontWeight: FontWeight.w600,

          ),
          headline5: GoogleFonts.roboto(
            fontSize: 28.0,
            color: colorScheme.onBackground,
            fontWeight: FontWeight.w500,
          ),
          headline6: GoogleFonts.roboto(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            color: colorScheme.onBackground,
          ),
          subtitle1: GoogleFonts.roboto(//h7 input deco text
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: colorScheme.onBackground,
          ),
          subtitle2: GoogleFonts.roboto(//h8
            //cardParticipant
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
            color: colorScheme.onBackground,
          ),
          bodyText1: GoogleFonts.roboto(//h9
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
            color: colorScheme.onBackground,
          ),
          bodyText2: GoogleFonts.oswald(//h10
            //onPrimary
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: colorScheme.onBackground,
          ),
          button: GoogleFonts.roboto(
            fontSize: 12.0,
            color: colorScheme.onBackground,
            fontWeight: FontWeight.w800
          ),
          caption: GoogleFonts.roboto(

            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: colorScheme.onBackground,
          ),
          overline: GoogleFonts.roboto(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: colorScheme.onBackground,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(

              textStyle: MaterialStateProperty.all<TextStyle>(
                GoogleFonts.roboto(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onBackground,
                ),
              ),
            ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.infinity, 70)),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onBackground,
                  ),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0))))),
        // EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/18, vertical: 10)
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    colorScheme.primary),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  GoogleFonts.oswald(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onPrimary,
                  ),
                ),
                side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
                elevation: MaterialStateProperty.all<double>(0),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0))))),
        inputDecorationTheme: InputDecorationTheme(

          // hoverColor: colorScheme.outline,

          hintStyle: GoogleFonts.roboto(//h9
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: colorScheme.onBackground,
          ),

          suffixStyle: GoogleFonts.roboto(//h9
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: colorScheme.onBackground,
          ),
          prefixStyle: GoogleFonts.roboto(//h9
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: colorScheme.onBackground,
          ),
          floatingLabelStyle: GoogleFonts.roboto(//h9
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: colorScheme.onBackground,
          ),
          helperStyle: GoogleFonts.roboto(//h9
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: colorScheme.onBackground,
          ),
          labelStyle: GoogleFonts.roboto(//h9
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: colorScheme.onBackground,
          ),
          counterStyle: GoogleFonts.roboto(//h9
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: colorScheme.onBackground,
          ),
          errorStyle: GoogleFonts.roboto(//h9
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
            color: colorScheme.error,
          ),
          fillColor: colorScheme.primaryContainer,
          filled: true
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: colorScheme.onBackground,
          selectionColor: colorScheme.primary,
          selectionHandleColor: colorScheme.primary,
        ));
  }

}
