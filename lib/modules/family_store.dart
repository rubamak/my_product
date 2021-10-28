
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FamilyStore{

   final String userId ;
  final String categoryId;
  final String familyId;
    final String familyName;
      final String description;
      final String familyImage;




    FamilyStore( {
       this.familyImage,
       this.familyId,
       this.description,
       this.familyName,
       this.categoryId,
       this.userId,
    });
}
