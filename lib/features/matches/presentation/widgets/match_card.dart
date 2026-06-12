import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/match_entity.dart';

class MatchCard extends StatelessWidget {
  final MatchEntity match;
  final VoidCallback onTap;

  const MatchCard({Key? key, required this.match, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFinished = match.status == 'FINISHED';
    final scoreText = isFinished ? '${match.homeScore} - ${match.awayScore}' : 'VS';

    return InkWell(
      onTap: onTap,
      borderRadius: AppTheme.borderLg,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceVariant,
          borderRadius: AppTheme.borderLg,
          border: Border.all(color: AppTheme.outline.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(AppTheme.gutter),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(match.stage.replaceAll('_', ' '), style: AppTheme.labelCaps),
            const SizedBox(height: AppTheme.baseSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(match.homeTeamName, style: AppTheme.bodyMd, textAlign: TextAlign.right)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.gutter),
                  child: Text(scoreText, style: AppTheme.statsNumeric),
                ),
                Expanded(child: Text(match.awayTeamName, style: AppTheme.bodyMd, textAlign: TextAlign.left)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
