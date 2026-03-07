import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [DashboardRoute(), ProfileRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            backgroundColor: context.colors.surface,
            indicatorColor: context.colors.surfaceContainer,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            labelTextStyle: WidgetStatePropertyAll(
              TextStyle(
                color: context.colors.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            height: 90,
            destinations: [
              NavigationDestination(
                tooltip: context.l10n.home,
                icon: Icon(LucideIcons.layoutDashboard),
                selectedIcon: Icon(
                  LucideIcons.layoutDashboard,
                  color: context.colors.onSurface,
                ),
                label: context.l10n.home,
              ),
              NavigationDestination(
                icon: Icon(LucideIcons.user),
                selectedIcon: Icon(
                  LucideIcons.user,
                  color: context.colors.onSurface,
                ),
                label: context.l10n.profile,
                tooltip: context.l10n.profile,
              ),
            ],
          ),
        );
      },
    );
  }
}
