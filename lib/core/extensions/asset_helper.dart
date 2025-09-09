import 'package:intl/intl.dart';

extension AssetHelper on String {
  // For SVG files
  String get svg => 'assets/svgs/$this.svg';

  // For PNG files
  String get png => 'assets/pngs/$this.png';

  // For JPG files (in a specific directory)
  String get jpg => 'assets/jpgs/$this.jpg';

  // For other formats, you can add more extensions as needed
}

extension NairaCurrencyHelper on String {
  String get naira =>
      NumberFormat.currency(locale: 'en_NG', symbol: "₦", decimalDigits: 0)
          .format(this);
}
