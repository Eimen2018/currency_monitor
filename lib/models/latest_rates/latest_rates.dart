import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'latest_rates.freezed.dart';
part 'latest_rates.g.dart';

@freezed
class LatestRates with _$LatestRates {
  LatestRates._();
  factory LatestRates({
    String? disclaimer,
    String? license,
    required int timestamp,
    String? base,
    Map<String, double>? rates,
  }) = _LatestRates;

/// A getter that returns the duration of the time since the rates were updated.
  String get duration {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var difference = DateTime.now().subtract(
      Duration(
        hours: date.hour,
        minutes: date.minute,
        seconds: date.second,
      ),
    );
    return timeago.format(difference);
  }

  factory LatestRates.fromJson(Map<String, dynamic> json) =>
      _$LatestRatesFromJson(json);
}
