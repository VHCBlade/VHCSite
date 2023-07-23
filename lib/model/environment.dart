import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VHCEnvironment {
  const VHCEnvironment({
    this.overrideTextScale = false,
  });
  final bool overrideTextScale;
}

extension EnvironmentContext on BuildContext {
  VHCEnvironment get environment =>
      read<VHCEnvironment?>() ?? const VHCEnvironment();
}
