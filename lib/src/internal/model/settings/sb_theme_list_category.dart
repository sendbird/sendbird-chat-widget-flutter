// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

part 'sb_theme_list_category.g.dart';

@JsonSerializable()
class SbThemeListCategory {
  final String backgroundColor;
  final String fontWeight;
  final int radius;
  final String selectedBackgroundColor;
  final String selectedTextColor;
  final String textColor;
  final int textSize;

  SbThemeListCategory({
    required this.backgroundColor,
    required this.fontWeight,
    required this.radius,
    required this.selectedBackgroundColor,
    required this.selectedTextColor,
    required this.textColor,
    required this.textSize,
  });

  factory SbThemeListCategory.fromJson(Map<String, dynamic> json) =>
      _$SbThemeListCategoryFromJson(json);
}
