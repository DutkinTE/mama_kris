import 'package:flutter/material.dart';

class VacancyContent extends StatelessWidget {
  final Map<String, dynamic> vacancy;
  const VacancyContent({Key? key, required this.vacancy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Получаем коэффициенты масштабирования (если нужны, можно передавать их через параметры)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    double scaleX = screenWidth / 428;
    double scaleY = screenHeight / 956;

    return Center(
      child: Container(
        width: 343 * scaleX,
        height: 540 * scaleY, // высота должна соответствовать родителю
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80 * scaleY), // небольшой отступ
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 27 * scaleY),
              // Название вакансии
              Text(
                vacancy['title'] ?? 'Нет названия',
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w600,
                  fontSize: 18 * scaleX,
                  height: 28 / 18,
                  letterSpacing: -0.18 * scaleX,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10 * scaleY),
              // Описание вакансии
              Text(
                vacancy['description'] ?? 'Нет описания',
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * scaleX,
                  height: 20 / 14,
                  letterSpacing: 0,
                  color: const Color(0xFF596574),
                ),
              ),
              SizedBox(height: 15 * scaleY),
              // Отображение цены, если есть данные
              if (vacancy['salary'] != null &&
                  vacancy['salary'].toString().isNotEmpty)
                Text(
                  vacancy['salary'].toString() == "0.00"
                      ? "Цена: По договоренности"
                      : "Цена: ${vacancy['salary']} руб",
                  style: TextStyle(
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.w600,
                    fontSize: 16 * scaleX,
                    height: 28 / 16,
                    letterSpacing:
                        -0.48 * scaleX, // примерно -3% от размера шрифта
                    color: const Color(0xFF596574),
                  ),
                ),
              SizedBox(height: 40 * scaleY),
            ],
          ),
        ),
      ),
    );
  }
}
