import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SessionsDeviceScreen extends StatefulWidget {
  const SessionsDeviceScreen({super.key});

  @override
  State<SessionsDeviceScreen> createState() => _SessionsDeviceScreenState();
}

class _SessionsDeviceScreenState extends State<SessionsDeviceScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SessionsDeviceBloc>().add(SessionsDeviceEvent.started());
    });
    super.initState();
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<SessionsDeviceBloc>().add(
      SessionsDeviceEvent.started(forceRefresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionsRevokeDeviceBloc, SessionsRevokeDeviceState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            context.read<SessionsDeviceBloc>().add(
              SessionsDeviceEvent.started(forceRefresh: true),
            );

            NeoKelasAppToast.show(
              context,
              message: context.l10n.deleteSessionSuccess,
              type: ToastType.success,
            );
          },
          failure: (failure) {
            NeoKelasAppToast.show(
              context,
              message: failure.message(context),
              type: ToastType.error,
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: context.colors.surfaceContainer,
        appBar: AppBar(
          backgroundColor: context.colors.surfaceContainer,
          toolbarHeight: 80,
          title: Text(
            context.l10n.activeSessions,
            style: context.text.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<SessionsDeviceBloc, SessionsDeviceState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (listSessionDevice) =>
                  _DeviceList(devices: listSessionDevice),
              failure: (failure) => NeoKelasErrorScreen(
                message: failure.message(context),
                onRetry: () => _onRefresh(context),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DeviceList extends StatelessWidget {
  final List<SessionsDeviceEntity> devices;

  const _DeviceList({required this.devices});

  @override
  Widget build(BuildContext context) {
    final reverseList = devices.reversed.toList();

    if (reverseList.isEmpty) {
      return NeoKelasEmptyScreen(
        icon: LucideIcons.screenShareOff,
        message: context.l10n.emptySessionDevice,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: reverseList.length,
      separatorBuilder: (_, _) => 16.h,
      itemBuilder: (_, index) => SessionsDeviceCard(
        device: reverseList[index],
        isCurrentDevice: index == 0,
      ),
    );
  }
}
