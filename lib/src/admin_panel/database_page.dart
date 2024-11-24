import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'database_config.dart';

class NitDatabasePage extends ConsumerStatefulWidget {
  const NitDatabasePage({
    super.key,
    required this.pageDescriptors,
  });

  final List<DatabasePageDescriptor> pageDescriptors;

  @override
  ConsumerState<NitDatabasePage> createState() => _State();
}

class _State extends ConsumerState<NitDatabasePage> {
  late DatabasePageDescriptor _selectedPage = widget.pageDescriptors.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "База данных: ${_selectedPage.pageDescriptor.pageTitle?.toLowerCase()}",
        ),
        const Gap(12),
        Expanded(
          child: _selectedPage.pageDescriptor.entityManagerBlock ??
              const Text('Блок для отображения не настроен'),
        ),
        const Gap(12),
        Wrap(
          spacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text("Другие разделы:"),
            ...widget.pageDescriptors.where((e) => e != _selectedPage).map(
                (e) => ElevatedButton(
                      onPressed: () => setState(() {
                        _selectedPage = e;
                      }),
                      child: Text(e.pageDescriptor.pageTitle ?? '???'),
                    )
                // InkWell(
                //   onTap: () => setState(() {
                //     _selectedPage = e;
                //   }),
                //   child: Card(
                //     color: _selectedPage == e
                //         ? context.colorScheme.primaryContainer
                //         : context.colorScheme.secondaryContainer,
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Text(
                //         '${_selectedPage == e ? '✅ ' : ''}${e.pageDescriptor.pageTitle ?? '???'}',
                //         style: _selectedPage == e
                //             ? context.textTheme.bodyMedium!
                //                 .copyWith(fontWeight: FontWeight.w700)
                //             : null,
                //       ),
                //     ),
                //   ),
                // ),
                ),
          ],
        ),
      ],
    );
  }
}
