
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Families{

   final int familyId ;
  final int categoryId;
    final String familyName;
      final String description;
      final String familyImage;




    Families({
      required this.familyImage,

      required this.description,
      required this.familyName,
      required this.categoryId,
      required this.familyId,
    });



}