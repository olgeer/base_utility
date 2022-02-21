import 'dart:io';
import 'package:flutter/material.dart';

Widget unionImage(String? imgSrc) {
  return imgSrc == null
      ? Image.asset(
          "assets/images/nocover.jpg",
          fit: BoxFit.fill,
        )
      : imgSrc.startsWith("http")
          ? Image.network(
              imgSrc,
              fit: BoxFit.fitHeight,
              errorBuilder: (c, o, s) => Image.asset(
                "assets/images/nocover.jpg",
                fit: BoxFit.fill,
              ),
            )
          : Image.file(
              File(imgSrc),
              fit: BoxFit.fill,
            );
}
