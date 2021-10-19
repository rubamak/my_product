
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Family{

   final String userId ;
  final String categoryId;
  final String familyId;
    final String familyName;
      final String description;
      final String familyImage;




    Family( {
      required this.familyImage,
      required this.familyId,
      required this.description,
      required this.familyName,
      required this.categoryId,
      required this.userId,
    });
}
