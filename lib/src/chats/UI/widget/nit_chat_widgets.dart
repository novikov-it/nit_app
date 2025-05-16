import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/src/chats/UI/widget/attachment/widget/add_attchment_button.dart';
import 'package:nit_app/src/chats/UI/widget/attachment/widget/fullscreen_attachment_view.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/chats/UI/chat_theme/chat_theme.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';
import 'package:nit_app/src/chats/UI/widget/attachment/attachment_list.dart';

part 'chat_input.dart';
part 'message_bubble.dart';
part 'attachment/widget/message_bubble_media_grid.dart';
part 'read_indicator.dart';
