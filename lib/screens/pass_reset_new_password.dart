import 'package:flutter/material.dart';
import 'package:mama_kris/widgets/custom_text_field.dart';
import 'package:mama_kris/widgets/next_button.dart';

class PassResetNewPasswordPage extends StatelessWidget {
  final double scaleX;
  final double scaleY;
  final VoidCallback onNext;
  final TextEditingController passwordController;

  const PassResetNewPasswordPage({
    Key? key,
    required this.scaleX,
    required this.scaleY,
    required this.onNext,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('newPasswordPage'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Заголовок, расположенный с отступом от начала панели
        Text(
          "Введите новый пароль",
          style: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w700,
            fontSize: 24 * scaleX,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20 * scaleY),
        // Поле ввода кода подтверждения
        Positioned(
          top: 156 * scaleY,
          left: 20 * scaleX,
          child: CustomTextField(
            scaleX: scaleX,
            scaleY: scaleY,
            hintText: "Пароль",
            isPassword: true,
            enableToggle: true,
            controller: passwordController,
          ),
        ),
        SizedBox(height: 80 * scaleY),
        Positioned(
          top: 246 * scaleY,
          left: 20 * scaleX,
          child: NextButton(scaleX: scaleX, scaleY: scaleY, onPressed: onNext),
        ),
        SizedBox(height: 300 * scaleY),
      ],
    );
  }
}
