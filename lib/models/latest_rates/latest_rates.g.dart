// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_rates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LatestRates _$$_LatestRatesFromJson(Map<String, dynamic> json) =>
    _$_LatestRates(
      disclaimer: json['disclaimer'] as String?,
      license: json['license'] as String?,
      timestamp: json['timestamp'] as int,
      base: json['base'] as String?,
      rates: (json['rates'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$$_LatestRatesToJson(_$_LatestRates instance) =>
    <String, dynamic>{
      'disclaimer': instance.disclaimer,
      'license': instance.license,
      'timestamp': instance.timestamp,
      'base': instance.base,
      'rates': instance.rates,
    };
