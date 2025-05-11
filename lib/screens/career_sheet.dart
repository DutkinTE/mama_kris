import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mama_kris/utils/funcs.dart' as funcs;
import 'package:mama_kris/widgets/next_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// Функция для показа модального окна "CareerSheet" – панели, выезжающей снизу.
Future<bool?> showCareerSheet(BuildContext context, {required String mode}) {
  final String WhatsAppLink = "https://wa.me/79376371117?text=%D0%97%D0%B4%D1%80%D0%B0%D0%B2%D1%81%D1%82%D0%B2%D1%83%D0%B9%D1%82%D0%B5%2C%20%D0%BC%D0%BD%D0%B5%20%D0%B8%D0%BD%D1%82%D0%B5%D1%80%D0%B5%D1%81%D0%BD%D0%B0%20%D1%83%D1%81%D0%BB%D1%83%D0%B3%D0%B0%20%D0%BA%D0%B0%D1%80%D1%8C%D0%B5%D1%80%D0%BD%D1%8B%D0%B9%20%D0%BA%D0%BE%D0%BD%D1%81%D1%83%D0%BB%D1%8C%D1%82%D0%B0%D0%BD%D1%82%20%D0%B4%D0%BB%D1%8F%20%D0%B1%D0%BE%D0%BB%D0%B5%D0%B5%20%D0%B1%D1%8B%D1%81%D1%82%D1%80%D0%BE%D0%B3%D0%BE%20%D0%BF%D0%BE%D0%B8%D1%81%D0%BA%D0%B0%20%D1%83%D0%B4%D0%B0%D0%BB%D0%B5%D0%BD%D0%BD%D0%BE%D0%B9%20%D1%80%D0%B0%D0%B1%D0%BE%D1%82%D1%8B.%20%D0%94%D0%B0%D0%B2%D0%B0%D0%B9%D1%82%D0%B5%20%D0%B4%D0%BE%D0%B3%D0%BE%D0%B2%D0%BE%D1%80%D0%B8%D0%BC%D1%81%D1%8F%20%D0%BE%D0%B1%20%D1%83%D0%B4%D0%BE%D0%B1%D0%BD%D0%BE%D0%BC%20%D0%B4%D0%BD%D0%B5%20%D0%B8%20%D0%B2%D1%80%D0%B5%D0%BC%D0%B5%D0%BD%D0%B8%20%D1%81%D0%BE%D0%B7%D0%B2%D0%BE%D0%BD%D0%B0%20%D0%B2%20zoom%20%D1%81%20%D1%8D%D0%BA%D1%81%D0%BF%D0%B5%D1%80%D1%82%D0%BE%D0%BC%20%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B0%20MamaKris%3F";
  // Базовые размеры макета: 428 x 956
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;
  final double scaleX = screenWidth / 428;
  final double scaleY = screenHeight / 956;

  Future<void> _launchWhatsApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: "CareerSheet",
    barrierColor: Colors.white.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            // Панель, выезжающая сверху
            Positioned(
              top: 329 * scaleY,
              left: 16 * scaleX,
              child: Container(
                width: 396 * scaleX,
                height: 627 * scaleY,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15 * scaleX),
                    topRight: Radius.circular(15 * scaleX),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x78E7E7E7),
                      offset: Offset(0, 4 * scaleY),
                      blurRadius: 19 * scaleX,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // text1.svg
                    Positioned(
                      top: 40 * scaleY, // 369 - 329 = 40
                      left: 20 * scaleX, // 36 - 16 = 20
                      child: SvgPicture.asset(
                        'assets/career_sheet/title.svg',
                        width: 162 * scaleX,
                        height: 56 * scaleY,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // text2.svg
                    Positioned(
                      top: 106 * scaleY, // 435 - 329 = 106
                      left: 20 * scaleX, // 36 - 16 = 20
                      child: SvgPicture.asset(
                        'assets/career_sheet/description.svg',
                        width: 356 * scaleX,
                        height: 260 * scaleY,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Кнопка "Мне интересно"
                    // Относительно панели: top = 725 - 329 = 396, left = 36 - 16 = 20.
                    Positioned(
                      top: 396 * scaleY,
                      left: 20 * scaleX,
                      child: Container(
                        width: 162.33 * scaleX,
                        height: 44.78 * scaleY,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00A80E),
                          borderRadius: BorderRadius.circular(13 * scaleX),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFCFFFD1),
                              offset: Offset(0, 4 * scaleY),
                              blurRadius: 19 * scaleX,
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            // print("Кнопка 'Мне интересно' нажата");
                            // final resultKar =
                            await funcs.updateKarKonsStatusFromCache();

                            if (mode == 'chat') {
                              await _launchWhatsApp(WhatsAppLink);
                            }
                            // print("Updated kar_kons data: $resultKar");
                            Navigator.pop(context, true);

                            // Добавьте здесь логику обработки нажатия
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00A80E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13 * scaleX),
                            ),
                            elevation: 0,
                            padding: EdgeInsets.fromLTRB(
                              2 * scaleX,
                              2 * scaleY,
                              2 * scaleX,
                              2 * scaleY,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Мне интересно",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.w600,
                                fontSize: 17 * scaleX,
                                height: 28 / 18,
                                letterSpacing: -0.54 * scaleX,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 396 * scaleY, // (645 - 329) = 316
                      right: 20 * scaleX, // (36 - 16) = 20
                      child: PopButton(
                        scaleX: scaleX,
                        scaleY: scaleY,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: child,
      );
    },
  );
}
