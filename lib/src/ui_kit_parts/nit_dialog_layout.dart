part of '../nit_app_ui_kit.dart';

class NitDialogLayout extends StatelessWidget {
  const NitDialogLayout({
    super.key,
    this.title,
    required this.child,
    this.buttons,
    this.buttonsAlignment = MainAxisAlignment.spaceBetween,
  });

  final String? title;
  final Widget child;
  final List<Widget>? buttons;
  final MainAxisAlignment buttonsAlignment;

  @override
  Widget build(BuildContext context) {
    return NitNotificationListenerWidget(
      notificationPresenter: NitNotification.showNotificationFlash,
      child: Column(
        // shrinkWrap: true,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          const Gap(16),
          Flexible(
            fit: FlexFit.loose,
            child: child,
          ),
          if ((buttons?.isNotEmpty) ?? false) ...[
            Gap(context.isMobile ? 16 : 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buttons!.asMap().entries.map(
                (entry) {
                  int index = entry.key;
                  Widget button = entry.value;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (index > 0) const Gap(8),
                      button,
                    ],
                  );
                },
              ).toList(),
            ),
          ]
        ],
      ),
    );
  }
}
