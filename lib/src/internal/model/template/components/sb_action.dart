// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sb_action.g.dart';

@JsonSerializable()
class SbAction {
  String type;
  String data;
  final String? alterData;

  SbAction({
    required this.type,
    required this.data,
    this.alterData,
  });

  factory SbAction.fromJson(Map<String, dynamic> json) =>
      _$SbActionFromJson(json);
}
