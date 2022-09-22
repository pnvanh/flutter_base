import 'package:flutter/material.dart';
import 'package:flutter_base/features/presentation/root/pages/root_body.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RootBody(),
    );
  }
}
