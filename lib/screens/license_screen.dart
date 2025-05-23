import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Расчёт коэффициентов масштабирования (базовый макет 428 x 956)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double scaleX = screenWidth / 428;
    final double scaleY = screenHeight / 956;

    // Общая высота контейнера (для прокрутки)
    final double contentHeight = (151 + 2750) * scaleY;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: contentHeight,
          child: Stack(
            children: [
              // Зелёный блюр‑фон с плавным градиентом
              Positioned(
                top: 108 * scaleY,
                left: 0,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.white,
                        Colors.white,
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.3, 0.7, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    width: 428 * scaleX,
                    height: 195 * scaleY,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCFFFD1).withOpacity(0.22),
                      borderRadius: BorderRadius.circular(20 * scaleX),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20 * scaleX),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 83, sigmaY: 83),
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
              // Title.svg
              Positioned(
                top: 75 * scaleY,
                left: 16 * scaleX,
                child: SizedBox(
                  width: 300 * scaleX,
                  child: Text(
                    "Лицензионное\nсоглашение",
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.w700,
                      fontSize: 26 * scaleX,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 151 * scaleY,
                left: 16 * scaleX,
                child: SizedBox(
                  width: 396 * scaleX,
                  child: Text(
                    '''Перед использованием мобильного приложения MamaKris, необходимо ознакомиться с условиями настоящего Лицензионного соглашения. Любое использование мобильного приложения MamaKris означает принятие условий настоящего Лицензионного соглашения.

1. ТЕРМИНЫ И ОПРЕДЕЛЕНИЯ
Мобильное приложение MamaKris — программное обеспечение (программа для ЭВМ), разработанное Компанией для функционирования на мобильных устройствах с операционной системой iOS и Android, и имеющее функционал, предоставляющий Пользователю возможность поиска работы посредством сервисов и услуг сайта MamaKris
«Компания» — Общество с ограниченной ответственностью «Мама Крис» (сокращенно – ООО «Мама Крис»), ОГРН 1255000016446, зарегистрировано по адресу: д. Буньково, тер. НП Буньково, д. 185А, являющееся правообладателем исключительных прав на Мобильное приложение MamaKris.
«Пользователь» — дееспособное физическое лицо, присоединившееся к данному Соглашению с целью установки и использования мобильного приложения на мобильном устройстве.

2. ОБЩИЕ ПОЛОЖЕНИЯ
2.1. Настоящее Лицензионное соглашение (далее — «Соглашение») устанавливает условия использования мобильного приложения MamaKris (далее — «Приложение») и заключено между Пользователем и Компанией.
2.2. Условия Соглашения являются публичной офертой в соответствии с частью 2 ст. 437 ГК РФ.
2.3. Устанавливая Приложение, Пользователь выражает безусловное принятие (акцепт) условий настоящего Соглашения (оферты).
2.4. Использование Приложения возможно только на условиях настоящего Соглашения.
2.5. В случае, если Пользователь не принимает условия настоящего Соглашения в полном объеме, у Пользователя не возникает права использовать настоящее Приложение.
2.6. Использование функционала Приложения возможно при наличии доступа к сети Интернет. Пользователь самостоятельно получает и оплачивает такой доступ на условиях по тарифам своего оператора связи или провайдера доступа к сети интернет.
2.7. Пользуясь Приложением Пользователь также заявляет, что он ознакомился и безоговорочно принимает: Политику в области обработки и обеспечения безопасности персональных данных.

3. ОСНОВНЫЕ ПОЛОЖЕНИЯ
3.1. Компания предоставляет Пользователю право использования Приложения на условиях простой (неисключительной) лицензии, безвозмездно, на территории всех стран мира, следующими способами: копирование, установка, воспроизведение на мобильном устройстве с целью использования по функциональному назначению.
3.2. При этом Пользователь не имеет право изменять, модифицировать, декомпилировать Приложение (программное обеспечение), создавать производные произведения с использованием Приложения (как всего программного обеспечения, так и его модулей), распространять Приложение в коммерческих целях, совершать иное использование Приложения, в целях и способами, не предусмотренными настоящим Соглашением.
3.3. Настоящее Соглашение распространяется на все последующие обновления Приложения, если обновление Приложения не сопровождается принятием иного лицензионного соглашения.
3.4. Право использования Приложения согласно п.3.1. Соглашения предоставляется с момента установки Приложения на мобильном устройстве и до момента удаления Приложения с мобильного устройства или прекращения возможности использования Приложения согласно п. 3.7. Соглашения.
3.5. Компания не несёт ответственности за какие-либо прямые или косвенные последствия какого-либо использования или невозможности использования Приложения и / или ущерб, причиненный Пользователю и / или третьим сторонам в результате какого-либо использования, неиспользования или невозможности использования Приложения или отдельных её компонентов и / или функций, в том числе из-за возможных ошибок или сбоев в работе Приложения, за исключением случаев, прямо предусмотренных законодательством.
3.6. Настоящая Лицензия не дает Пользователю никаких прав на использование иных объектов интеллектуальной собственности, включая товарные знаки, за исключением прав, предоставленных настоящей Лицензией в отношении Приложения.
3.7. Компания оставляет за собой право в любой момент по своему усмотрению прекратить возможность использования Приложения.

4. PUSH-УВЕДОМЛЕНИЯ
4.1. Компания вправе отправлять Пользователям посредством Приложения сообщения на мобильное устройство Пользователя, используя технологию push-уведомлений. Устанавливая на свое мобильное устройство Приложение, Пользователь в соответствии с частью 1 статьи 18 Федерального закона «О рекламе» от 13.03.2006 №38-ФЗ даёт свое согласие на получение push-уведомлений, которые, в том числе, могут содержать информацию рекламного характера.
4.2. Авторизованный Пользователь (Пользователь, который осуществил авторизацию в Приложении посредством своей учетной информации) может настроить тематику получаемых push-уведомлений или полностью отказаться от их получения через настройки своего профиля в Приложении.

5. ЗАКЛЮЧИТЕЛЬНЫЕ ПОЛОЖЕНИЯ
5.1. Настоящее Соглашение вступает в силу для Пользователя с момента установки Приложения на мобильном устройстве.
5.2. Настоящее Соглашение может быть изменено и/или дополнено Компанией в одностороннем порядке. Уведомление о внесенных изменениях в условия Соглашения размещается в Приложении. При этом продолжение использования Приложения после внесения изменений и/или дополнений в настоящее Соглашение, означает согласие Пользователя с такими изменениями и/или дополнениями.
5.3. Настоящее Соглашение и отношения, связанные с использованием Приложения, регулируются законодательством РФ.
5.4. Все споры, разногласия и претензии, которые могут возникнуть в связи с исполнением настоящего Соглашения, Компания и Пользователь будут стараться решить путем переговоров с соблюдением обязательного претензионного срока. Если возникшие споры не представляется возможным решить путем переговоров, они будут разрешаться в судебном порядке в соответствии с законодательством РФ по месту нахождения Компании.
''',
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.w400,
                      fontSize: 14 * scaleX,
                      height: 20 / 14,
                      letterSpacing: -0.1 * scaleX,
                      color: const Color(0xFF596574),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Positioned(
                top: 2770 * scaleY,
                left: 16 * scaleX,
                child: Container(
                  width: 396 * scaleX,
                  height: 72 * scaleY,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFCFFFD1),
                        offset: Offset(0, 4 * scaleY),
                        blurRadius: 19 * scaleX,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15 * scaleX),
                  ),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A80E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          15 * scaleX,
                        ),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        vertical: 20 * scaleY,
                        horizontal: 24 * scaleX,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Назад',
                            style: TextStyle(
                              fontFamily: 'Jost',
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleX,
                              height: 28 / 18,
                              letterSpacing: -0.18 * scaleX,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10 * scaleX),
                        SvgPicture.asset(
                          'assets/welcome_screen/arrow.svg',
                          width: 32 * scaleX,
                          height: 32 * scaleY,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}