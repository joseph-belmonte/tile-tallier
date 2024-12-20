import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// Enum used to return and describes properties of the [FlexTones] static
/// constructors.
///
/// By using [tones] and a given [Brightness], returns the corresponding
/// [FlexTones] made with same named constructor.
///
/// Also contains used icon for each tone and shade value to adjust used
/// color value on the icon, this used by UI widgets in this demo app.
///
/// This is also a another small demonstration of how we can use Dart 2.17
/// enhanced enums.
enum FlexTone {
  /// Disabled tone, used to disable the color scheme.
  disabled(
    tone: 'Disabled',
    describe: 'Disabled',
    setup: 'Key color based tonal palettes are not used.\n'
        'Enable at least one key color to seed the palettes.\n'
        'Primary color must always be included as a key color.\n\n\n',
    icon: Icons.texture_outlined,
    shade: -5,
  ),

  /// Material 3 tone, default Material 3 design tone map and chroma setup.
  material(
    tone: 'Material 3',
    describe: 'Default Material 3 design tone map and chroma setup',
    setup: 'Primary - Chroma from key color, but min 48\n'
        'Secondary - Chroma set to 16\n'
        'Tertiary - Chroma set to 24\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n',
    icon: Icons.blur_circular,
    shade: -5,
  ),

  /// Soft tone, softer and more earth like tones than Material 3 defaults.
  soft(
    tone: 'Soft',
    describe: 'Softer and more earth like tones than Material 3 defaults',
    setup: 'Primary - Chroma set to 30\n'
        'Secondary - Chroma set to 14\n'
        'Tertiary - Chroma set to 20\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n',
    icon: Icons.blur_on,
    shade: 2,
  ),

  /// Vivid tone, more vivid colors than Material 3 defaults.
  vivid(
    tone: 'Vivid',
    describe: 'More Vivid colors than Material 3 defaults',
    setup: 'Primary - Chroma from key color, but min 50\n'
        'Secondary - Chroma from key color\n'
        'Tertiary - Chroma from key color\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n',
    icon: Icons.tonality,
    shade: 6,
  ),

  /// Vivid surfaces tone, more colorful containers, onColors and surface tones.
  vividSurfaces(
    tone: 'Vivid surfaces',
    describe: 'Like Vivid, but with more colorful containers, onColors and '
        'surface tones. Creates alpha blend like effect without '
        'any blend level',
    setup: 'Primary - Chroma from key color, but min 50\n'
        'Secondary - Chroma from key color\n'
        'Tertiary - Chroma from key color\n'
        'Neutral - Chroma set to 8\n'
        'Neutral variant - Chroma set to 16\n',
    icon: Icons.radio_button_checked,
    shade: 10,
  ),

  /// High contrast tone, high contrast version, may be useful for accessibility.
  highContrast(
    tone: 'High contrast',
    describe: 'High contrast version, may be useful for accessibility',
    setup: 'Primary - Chroma from key color, but min 65\n'
        'Secondary - Chroma from key color, but min 55\n'
        'Tertiary - Chroma from key color, but min 55\n'
        'Neutral - Chroma set to 4\n'
        'Neutral variant - Chroma set to 8\n',
    icon: Icons.contrast,
    shade: 14,
  ),

  /// Ultra contrast tone, ultra high contrast version, useful for accessibility.
  ultraContrast(
    tone: 'Ultra contrast',
    describe: 'Ultra high contrast version, useful for accessibility, '
        'less colorful than high contrast, especially dark mode',
    setup: 'Primary - Chroma from key color, but min 60\n'
        'Secondary - Chroma from key color, but min 70\n'
        'Tertiary - Chroma from key color, but min 65\n'
        'Neutral - Chroma set to 3\n'
        'Neutral variant - Chroma set to 6\n',
    icon: Icons.lens,
    shade: 20,
  ),

  /// Jolly tone, jolly color tones with more chroma and pop in them.
  jolly(
    tone: 'Jolly',
    describe: 'Jolly color tones with more chroma and pop in them',
    setup: 'Primary - Chroma from key color, but min 55\n'
        'Secondary - Chroma from key color, but min 40\n'
        'Tertiary - Chroma set to 40\n'
        'Neutral - Chroma set to 6\n'
        'Neutral variant - Chroma set to 10\n',
    icon: Icons.sunny,
    shade: 8,
  );

  const FlexTone({
    required this.tone,
    required this.describe,
    required this.setup,
    required this.icon,
    required this.shade,
  });

  /// Tone name.
  final String tone;

  /// Tone description.
  final String describe;

  /// Tone setup description.
  final String setup;

  /// Icon used to represent the tone.
  final IconData icon;

  /// Shade value to adjust used color value on the icon.
  final int shade;

  /// Returns [FlexTones] for the given [brightness].
  FlexTones tones(Brightness brightness) {
    switch (this) {
      case FlexTone.disabled:
        return FlexTones.material(brightness);
      case FlexTone.material:
        return FlexTones.material(brightness);
      case FlexTone.soft:
        return FlexTones.soft(brightness);
      case FlexTone.vivid:
        return FlexTones.vivid(brightness);
      case FlexTone.vividSurfaces:
        return FlexTones.vividSurfaces(brightness);
      case FlexTone.highContrast:
        return FlexTones.highContrast(brightness);
      case FlexTone.ultraContrast:
        return FlexTones.ultraContrast(brightness);
      case FlexTone.jolly:
        return FlexTones.jolly(brightness);
    }
  }
}
