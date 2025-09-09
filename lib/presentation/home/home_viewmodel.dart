import 'package:stacked/stacked.dart';

import '../../core/cores.dart';

class HomeViewmodel extends BaseViewModel {
  int _currentCarouselIndex = 0;

  int get currentCarouselIndex => _currentCarouselIndex;

  void setCarouselIndex(int index) {
    _currentCarouselIndex = index;
    notifyListeners();
  }

  List<String> quotes = [
    AppAssets.quote1,
    AppAssets.quote2,
    AppAssets.quote3,
    AppAssets.quote4,
    AppAssets.quote5,
    AppAssets.quote6,
  ];
}
