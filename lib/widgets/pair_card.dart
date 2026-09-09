import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class PairCard extends StatelessWidget {
  const PairCard({
    super.key,
    required this.pair,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final WordPair pair;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalSyl = syllables(pair.first) + syllables(pair.second);

    return GestureDetector(
      onDoubleTap: onToggleFavorite,
      child: Container(
        constraints: const BoxConstraints(minWidth: 320, maxWidth: 440),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 36,
              offset: const Offset(0, 18),
            ),
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.05),
              blurRadius: 48,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Row: Badges on left, Borderless Heart on right
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'NAME IDEA',
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.4,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.graphic_eq_rounded,
                            size: 12,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$totalSyl syl',
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Borderless, background-less heart icon directly on card
                IconButton(
                  onPressed: onToggleFavorite,
                  tooltip: isFavorite ? 'Unlike' : 'Like',
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                    child: isFavorite
                        ? const Icon(
                            Icons.favorite_rounded,
                            key: ValueKey('liked_heart'),
                            color: AppTheme.heartAccent,
                            size: 26,
                          )
                        : Icon(
                            Icons.favorite_border_rounded,
                            key: const ValueKey('unliked_heart'),
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                            size: 26,
                          ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Smooth Animated Word Transition
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 260),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 0.24),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                      child: child,
                    ),
                  );
                },
                child: Text.rich(
                  key: ValueKey(pair),
                  TextSpan(
                    children: [
                      TextSpan(
                        text: pair.first.toLowerCase(),
                        style: GoogleFonts.outfit(
                          fontSize: 38,
                          fontWeight: FontWeight.w300,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          letterSpacing: -0.5,
                        ),
                      ),
                      TextSpan(
                        text: pair.second.toLowerCase(),
                        style: GoogleFonts.outfit(
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  semanticsLabel: "${pair.first} ${pair.second}",
                ),
              ),
            ),

            const SizedBox(height: 22),

            Center(
              child: Text(
                'Double tap card to like',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
