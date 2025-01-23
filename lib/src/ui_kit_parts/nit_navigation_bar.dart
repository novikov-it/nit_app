part of '../nit_app_ui_kit.dart';

class NitNavigationBar extends ConsumerStatefulWidget {
  const NitNavigationBar({
    super.key,
    required this.menuItems,
    this.pathParameters,
  });

  final List<NitMenuItem> menuItems;
  final Map<String, String>? pathParameters;

  @override
  ConsumerState<NitNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends ConsumerState<NitNavigationBar> {
  int _currentIndex = -1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (mounted) {
      // print(GoRouterState.of(context).uri.toString());
      final state = GoRouterState.of(context);
      final urlSections =
          GoRouterState.of(context).uri.toString().split('?')[0].split('/');
      // print(urlSections);
      _currentIndex = widget.menuItems.indexWhere((element)
          // element.route?.name == state.name);
          {
        // print('${element.route!.root}${element.route!.route.path}');

        final routeSections = element.route!.fullPath.split('/');
        // '${element.route!.root}${element.route!.route.path}'.split('/');

        for (var i = 0; i < urlSections.length; i++) {
          if (i >= routeSections.length) {
            // print('${urlSections[i]} does not match ${routeSections[i]}');

            return true;
          }
          if (routeSections[i].startsWith(':') ||
              urlSections[i] == routeSections[i]) {
            // print('${urlSections[i]} matches ${routeSections[i]}');
            continue;
          } else {
            // print('${urlSections[i]} does not match ${routeSections[i]}');

            return false;
          }
        }

        return true;

        // return GoRouterState.of(context).uri.toString().contains(
        //     '${element.route!.root}${element.route!.route.path}'); //TODO: fix location here
      });

      if (_currentIndex == -1 || _currentIndex > widget.menuItems.length) {
        _currentIndex = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      selectedLabelStyle: context.textTheme.bodySmall!.copyWith(
        color: context.theme.colorScheme.secondary.withOpacity(0.50),
        fontSize: 12,
      ),
      unselectedLabelStyle: context.textTheme.bodySmall!.copyWith(
        color: context.theme.colorScheme.secondary.withOpacity(0.50),
        fontSize: 12,
      ),
      unselectedItemColor: context.theme.colorScheme.outline,
      selectedItemColor: context.colorScheme.primaryFixedDim,
      onTap: (index) {
        if (widget.menuItems[index].onPressed != null) {
          widget.menuItems[index].onPressed!(context, ref);
        } else if (widget.menuItems[index].route != null) {
          context.goNamed(
            widget.menuItems[index].route!.name,
            pathParameters: widget.pathParameters ?? {},
          );
        }
      },
      items: widget.menuItems.mapIndexed((index, item) {
        return BottomNavigationBarItem(
          icon: Stack(
            children: [
              item.svgIcon != null
                  ? SvgPicture.asset(
                      item.svgIcon!,
                      colorFilter: ColorFilter.mode(
                        _currentIndex == index
                            ? context.colorScheme.primaryFixedDim
                            : context.theme.colorScheme.outline,
                        BlendMode.srcIn,
                      ),
                    )
                  : Icon(item.iconData),
              if (item.displayProvider != null)
                Builder(builder: (context) {
                  final state = ref.watch(item.displayProvider!);

                  if (state is int && state > 0) {
                    return
                        // Positioned(
                        // top: 0,
                        // right: 0,
                        // bottom: 20,
                        // child:
                        Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                      child: Text(
                        '$state',
                        style: context.textTheme.labelLarge!.copyWith(
                          color: context.colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // ),
                    );
                  }

                  return const SizedBox.shrink();
                }),
            ],
          ),
          label: item.displayTitle,
        );
      }).toList(),
    );
  }
}
