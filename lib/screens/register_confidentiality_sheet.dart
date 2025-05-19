// lib/register_confidentiality_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mama_kris/widgets/next_button.dart';
import 'package:mama_kris/widgets/custom_checkbox.dart';
import 'package:mama_kris/screens/conf.dart';
import 'package:mama_kris/screens/license_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfidentialityPanel extends StatefulWidget {
  final double scaleX;
  final double scaleY;
  final VoidCallback onNext;

  const ConfidentialityPanel({
    Key? key,
    required this.scaleX,
    required this.scaleY,
     required this.onNext,
  }) : super(key: key); 

  @override
  _ConfidentialityPanelState createState() => _ConfidentialityPanelState();
}

class _ConfidentialityPanelState extends State<ConfidentialityPanel> {
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false; // New checkbox for email subscription


  void _onNextPressed() async {
    final prefs = await SharedPreferences.getInstance();
    if (checkbox1 && checkbox2) {
      if (checkbox3) {
        await prefs.setBool('subscription_confirmed', true);
      }
      widget.onNext();
    } else {
      // Show error message if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 396 * widget.scaleX,
      height: 800 * widget.scaleY, // Increased height to accommodate new checkbox
      child: Stack(
        children: [
          // Existing widgets...
          Positioned(
            top: 40 * widget.scaleY,
            left: 20 * widget.scaleX,
            child: SvgPicture.asset(
              'assets/register_confidentiality_sheet/text1.svg',
              width: 295 * widget.scaleX,
              height: 56 * widget.scaleY,
              fit: BoxFit.cover,
            ),
          ),
          
          Positioned(
            top: 106 * widget.scaleY,
            left: 20 * widget.scaleX,
            child: SizedBox(
              width: 310 * widget.scaleX,
              height: 140 * widget.scaleY,
              child: Text(
                "Ознакомьтесь, пожалуйста, с документами и подтвердите согласие на обработку ваших персональных данных как пользователя нашей IT-платформы.",
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * widget.scaleX,
                  height: 20 / 14,
                  letterSpacing: -0.1 * widget.scaleX,
                  color: Color(0xFF596574),
                ),
              ),
            ),
          ),
          
          // Checkbox 1
          Positioned(
            top: 226 * widget.scaleY,
            left: 20 * widget.scaleX,
            child: CustomCheckbox(
              initialValue: checkbox1,
              onChanged: (bool value) {
                setState(() {
                  checkbox1 = value;
                });
              },
              scaleX: widget.scaleX,
              scaleY: widget.scaleY,
            ),
          ),
          
          Positioned(
            top: 226 * widget.scaleY,
            left: 49 * widget.scaleX,
            child: SizedBox(
              width: 268 * widget.scaleX,
              height: 80 * widget.scaleY,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.w400,
                    fontSize: 14 * widget.scaleX,
                    height: 20 / 14,
                    letterSpacing: -0.1 * widget.scaleX,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(text: 'Я принимаю условия '),
                    TextSpan(
                      text: 'Политики конфиденциальности',
                      style: const TextStyle(
                        color: Color(0xFF00A80E),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 300),
                              pageBuilder: (_, animation, secondaryAnimation) =>
                                  const ConfScreen(),
                              transitionsBuilder: (_, animation, __, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;

                                final tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: curve));
                                final offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                    position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                    ),
                    const TextSpan(
                      text: ' и даю согласие\nна обработку моих персональных данных в соответствии с законодательством',
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Checkbox 2
          Positioned(
            top: 316 * widget.scaleY,
            left: 20 * widget.scaleX,
            child: CustomCheckbox(
              initialValue: checkbox2,
              onChanged: (bool value) {
                setState(() {
                  checkbox2 = value;
                });
              },
              scaleX: widget.scaleX,
              scaleY: widget.scaleY,
            ),
          ),
          
          Positioned(
            top: 316 * widget.scaleY,
            left: (65 - 16) * widget.scaleX,
            child: SizedBox(
              width: 268 * widget.scaleX,
              height: 20 * widget.scaleY,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.w400,
                    fontSize: 14 * widget.scaleX,
                    height: 20 / 14,
                    letterSpacing: -0.1 * widget.scaleX,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(text: 'Я соглашаюсь с '),
                    TextSpan(
                      text: 'Условиями использования',
                      style: const TextStyle(
                        color: Color(0xFF00A80E),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 300),
                              pageBuilder: (_, animation, secondaryAnimation) =>
                                  const LicenseScreen(),
                              transitionsBuilder: (_, animation, __, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;

                                final tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: curve));
                                final offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                    position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // New Checkbox 3 for email subscription
          Positioned(
            top: 350 * widget.scaleY, // Positioned below the second checkbox
            left: 20 * widget.scaleX,
            child: CustomCheckbox(
              initialValue: checkbox3,
              onChanged: (bool value) {
                setState(() {
                  checkbox3 = value;
                });
              },
              scaleX: widget.scaleX,
              scaleY: widget.scaleY,
            ),
          ),
          
          Positioned(
            top: 350 * widget.scaleY,
            left: 49 * widget.scaleX,
            child: SizedBox(
              width: 268 * widget.scaleX,
              height: 40 * widget.scaleY,
              child: Text(
                'Я согласен получать информационную рассылку по почте',
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * widget.scaleX,
                  height: 20 / 14,
                  letterSpacing: -0.1 * widget.scaleX,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Next Button (moved down to accommodate new checkbox)
          Positioned(
            top: 446 * widget.scaleY, // Adjusted position
            left: 20 * widget.scaleX,
            child: NextButton(
              scaleX: widget.scaleX,
              scaleY: widget.scaleY,
              onPressed: _onNextPressed,
            ),
          ),
          
          Positioned(
            top: 446 * widget.scaleY, // Adjusted position
            right: 20 * widget.scaleX,
            child: PopButton(
              scaleX: widget.scaleX,
              scaleY: widget.scaleY,
            ),
          ),
        ],
      ),
    );
  }
}