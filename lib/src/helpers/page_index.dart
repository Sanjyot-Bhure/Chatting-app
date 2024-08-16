import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final changeIndexNotifier =
    ChangeNotifierProvider<ChangePageIndex>((ref) => ChangePageIndex());

class ChangePageIndex extends ChangeNotifier {
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
