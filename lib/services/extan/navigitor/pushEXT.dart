import 'package:flutter/material.dart';

extension nav on BuildContext {
  pushAndRemove({required Widget view}) {
    Navigator.pushAndRemoveUntil(
        this, MaterialPageRoute(builder: (context) => view), (route) => false);
  }
}
// extension nav1 on BuildContext {
//   popAndRemove({required Widget view}) {
//     Navigator.(
//         this, MaterialPageRoute(builder: (context) => view), (route) => false);
//   }
// }

