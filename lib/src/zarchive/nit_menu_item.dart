// part of '../nit_app_ui_kit.dart';

// import 'package:flutter/material.dart';

// class NitMenuItem {
//   NitMenuItem({
//     required this.displayTitle,
//     this.iconData,
//     this.svgIcon,
//     this.route,
//     this.onPressed,
//     this.displayProvider,
//   }) {
//     assert(
//       (iconData != null || svgIcon != null) &&
//           (iconData == null || svgIcon == null),
//       'Either route or onPressed must be provided',
//     );
//     assert(
//       (route != null || onPressed != null) &&
//           (route == null || onPressed == null),
//       'Either route or onPressed must be provided',
//     );
//   }

//   /// This function must handle notifying itself
//   final Function(BuildContext, WidgetRef)? onPressed;
//   final NavigationZoneEnum? route;
//   final String displayTitle;
//   final IconData? iconData;
//   final String? svgIcon;
//   final ProviderListenable? displayProvider;
// }
