import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  final Size _size;

  Responsive(this.context) : _size = MediaQuery.of(context).size;

  /// 📱 عرض الشاشة
  double get width => _size.width;

  /// 📱 ارتفاع الشاشة
  double get height => _size.height;

  /// 🔠 نسبة حجم النص
  double setFont(double size) => size * (width / 375);

  /// ↔️ نسبة عرض عنصر
  double setWidth(double inputWidth) => (inputWidth / 375.0) * width;

  /// ↕️ نسبة ارتفاع عنصر
  double setHeight(double inputHeight) => (inputHeight / 812.0) * height;

  /// ✅ اختصار لمعرفة نوع الشاشة
  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;
}

// 📌 - إزاي تستخدمه
// مثال في أي Widget:

// @override
// Widget build(BuildContext context) {
//   final responsive = Responsive(context);

//   return Scaffold(
//     body: Center(
//       child: Container(
//         width: responsive.setWidth(200),   // 200 بالنسبة لعرض شاشة 375
//         height: responsive.setHeight(100), // 100 بالنسبة لارتفاع شاشة 812
//         color: Colors.blue,
//         child: Text(
//           "Hello Responsive",
//           style: TextStyle(
//             fontSize: responsive.setFont(16), // الخط متجاوب
//           ),
//         ),
//       ),
//     ),
//   );
// }
