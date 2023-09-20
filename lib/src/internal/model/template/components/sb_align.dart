// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sb_align.g.dart';

@JsonSerializable()
class SbAlign {
  final String horizontal; // 'left', 'center', 'right'
  final String vertical; // 'top', 'center', 'bottom'

  SbAlign({
    required this.horizontal,
    required this.vertical,
  });

  factory SbAlign.fromJson(Map<String, dynamic> json) => _$SbAlignFromJson(json);
}
