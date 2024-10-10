part of '../nit_app_ui_kit.dart';

class DialogLayout extends StatelessWidget {
  const DialogLayout({
    super.key,
    this.title,
    required this.child,
    this.buttons,
  });

  final String? title;
  final Widget child;
  final List<Widget>? buttons;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) titleText(context),
        const Gap(8),
        Flexible(
          fit: FlexFit.loose,
          child: child,
        ),
        if ((buttons?.isNotEmpty) ?? false) ...[
          Gap(context.isMobile ? 16 : 24),
          _buttonsRow(),
        ]
      ],
    );
  }

  Text titleText(BuildContext context) {
    return Text(
      title!,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }

  Row _buttonsRow() {
    return Row(
      children: buttons!.asMap().entries.map((entry) {
        int index = entry.key;
        Widget button = entry.value;
        return Expanded(
          child: Row(
            children: [
              if (index > 0) const Gap(8),
              Expanded(child: button),
            ],
          ),
        );
      }).toList(),
    );
  }
}
