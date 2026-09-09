import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../widgets/pair_card.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appState = context.watch<MyAppState>();
    final pair = appState.current;
    final isFavorite = appState.favorites.contains(pair);
    final previousWord = appState.history.isNotEmpty ? appState.history.first : null;

    return Stack(
      children: [
        // 1. Architectural background watermark (80% scale, balanced blur)
        Positioned.fill(
          child: IgnorePointer(
            child: OverflowBox(
              maxWidth: 2400,
              maxHeight: 1400,
              alignment: Alignment.center,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: ImageFiltered(
                  key: ValueKey(previousWord?.asLowerCase ?? pair.asLowerCase),
                  imageFilter: ImageFilter.blur(sigmaX: 4.5, sigmaY: 4.5),
                  child: Text(
                    (previousWord ?? pair).asLowerCase,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    softWrap: false,
                    style: GoogleFonts.outfit(
                      fontSize: 192,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -6,
                      color: Colors.white.withValues(alpha: 0.055),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // 2. Main Interactive Column
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Previous words tallying up (pure typographic hierarchy, no arrows)
                if (appState.history.isNotEmpty) ...[
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      children: [
                        for (int i = (appState.history.length > 2 ? 1 : 0); i >= 0; i--)
                          if (i < appState.history.length)
                            GestureDetector(
                              onTap: () => appState.restoreFromHistory(appState.history[i]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                child: Text(
                                  appState.history[i].asCamelCase,
                                  style: GoogleFonts.outfit(
                                    fontSize: i == 0 ? 15 : 13,
                                    fontWeight: i == 0 ? FontWeight.w600 : FontWeight.w400,
                                    color: theme.colorScheme.onSurface.withValues(
                                      alpha: i == 0 ? 0.65 : 0.28,
                                    ),
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                ],

                // Modern Card with Integrated borderless Heart
                PairCard(
                  pair: pair,
                  isFavorite: isFavorite,
                  onToggleFavorite: appState.toggleFavorite,
                ),

                const SizedBox(height: 24),

                // Clean Action Controls (Undo, Generate Next, Copy)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (appState.history.isNotEmpty) ...[
                      IconButton.filledTonal(
                        onPressed: () {
                          appState.restoreFromHistory(appState.history.first);
                        },
                        icon: const Icon(Icons.undo_rounded, size: 20),
                        tooltip: 'Undo last word',
                        style: IconButton.styleFrom(
                          backgroundColor: theme.colorScheme.surface,
                          foregroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(width: 14),
                    ],

                    ElevatedButton.icon(
                      onPressed: appState.getNextRandomWord,
                      icon: const Icon(Icons.auto_awesome_rounded, size: 20),
                      label: const Text('Generate Next'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                      ),
                    ),

                    const SizedBox(width: 14),

                    IconButton.filledTonal(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: pair.asCamelCase));
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Copied "${pair.asCamelCase}" to clipboard'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded, size: 20),
                      tooltip: 'Copy name',
                      style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.surface,
                        foregroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
