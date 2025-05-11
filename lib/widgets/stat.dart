import 'package:flutter/material.dart';

class StatBanner extends StatefulWidget {
  final int usersCount;
  final int vacanciesCount;
  
  const StatBanner({
    super.key,
    required this.usersCount,
    required this.vacanciesCount,
  });

  @override
  State<StatBanner> createState() => _StatBannerState();
}

class _StatBannerState extends State<StatBanner> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double scaleX = screenWidth / 428;

    return Container(
      padding: EdgeInsets.only(right: 16 * scaleX + 10, left: 16 * scaleX + 10),
      width: 395 * scaleX,
      height: 15,
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('${widget.usersCount} пользователей',
              style: TextStyle(
                fontFamily: 'Jost',
                fontWeight: FontWeight.w400,
                fontSize: 14 * scaleX,
                height: 20 / 14,
                letterSpacing: 0,
                color: const Color(0xFF596574),
              )),
          Text('${widget.vacanciesCount} вакансий',
              style: TextStyle(
                fontFamily: 'Jost',
                fontWeight: FontWeight.w400,
                fontSize: 14 * scaleX,
                height: 20 / 14,
                letterSpacing: 0,
                color: const Color(0xFF596574),
              ))
        ],
      ),
    );
  }
}