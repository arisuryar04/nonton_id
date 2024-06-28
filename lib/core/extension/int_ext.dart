import 'package:intl/intl.dart';

extension IntExt on int {
  String toCurrency() {
    return NumberFormat.currency(
      locale: 'id_ID',
      decimalDigits: 0,
      symbol: 'Rp. ',
    ).format(this);
  }
}
