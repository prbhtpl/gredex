import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonDeco{
  final primary= BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.grey.shade100),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 15,
            offset: Offset(0,3)
        ),
      ]
  );
  final primaryRectangle= BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey.shade100),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 15,
            offset: Offset(0,3)
        ),
      ]
  );
}