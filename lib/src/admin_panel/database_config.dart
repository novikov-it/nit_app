import 'package:flutter/material.dart';

class DPD {
  const DPD({
    required this.pageTitle,
    required this.entityManagerBlock,
  });
  final String pageTitle;
  final Widget entityManagerBlock;
}

abstract class DatabasePageDescriptor implements Enum {
  DatabasePageDescriptor(
    this.pageDescriptor, // = const DPD(),
  );

  final DPD pageDescriptor;
}
