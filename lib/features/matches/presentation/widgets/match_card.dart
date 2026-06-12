import 'package:flutter/material.dart';
import 'package:circle_flags/circle_flags.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/country_mapper.dart';
import '../../domain/entities/match_entity.dart';

class MatchCard extends StatelessWidget {
  final MatchEntity match;
  final VoidCallback onTap;

  const MatchCard({Key? key, required this.match, required this.onTap}) : super(key: key);

  Widget _buildStatusBadge() {
    Color bgColor;
    Color textColor = AppTheme.onPrimary;
    String text;

    switch (match.status) {
      case 'IN_PLAY':
      case 'PAUSED':
        bgColor = AppTheme.error;
        text = 'EN VIVO';
        break;
      case 'FINISHED':
        bgColor = AppTheme.surfaceVariant;
        textColor = AppTheme.onSurfaceVariant;
        text = 'FINALIZADO';
        break;
      case 'SCHEDULED':
      case 'TIMED':
      default:
        bgColor = AppTheme.gold;
        textColor = AppTheme.primary;
        text = 'PROGRAMADO';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: AppTheme.labelCaps.copyWith(color: textColor, letterSpacing: 1.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasStarted = match.status != 'SCHEDULED' && match.status != 'TIMED' && match.status != 'CANCELLED';
    final scoreText = hasStarted ? '${match.homeScore ?? 0} - ${match.awayScore ?? 0}' : 'VS';

    final ecuadorDate = match.utcDate.subtract(const Duration(hours: 5));
    final timeStr = "${ecuadorDate.hour.toString().padLeft(2, '0')}:${ecuadorDate.minute.toString().padLeft(2, '0')}";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppTheme.baseSpacing),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: AppTheme.borderLg,
        border: Border.all(color: AppTheme.outline.withOpacity(0.4), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppTheme.borderLg,
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.gutter),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        match.stage.replaceAll('_', ' '),
                        style: AppTheme.labelCaps.copyWith(color: AppTheme.outline),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildStatusBadge(),
                  ],
                ),
                const SizedBox(height: AppTheme.marginMobile),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CircleFlag(CountryMapper.getCode(match.homeTeamName), size: 48),
                          const SizedBox(height: AppTheme.baseSpacing),
                          Text(
                            match.homeTeamName,
                            style: AppTheme.bodyMd.copyWith(color: AppTheme.onSurface),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.gutter),
                      child: Column(
                        children: [
                          Text(
                            scoreText,
                            style: AppTheme.headlineLg.copyWith(
                              color: AppTheme.primary,
                              fontSize: hasStarted ? 36 : 24,
                            ),
                          ),
                          if (!hasStarted) ...[
                            const SizedBox(height: 4),
                            Text(timeStr, style: AppTheme.statsNumeric.copyWith(color: AppTheme.onSurfaceVariant)),
                          ]
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: [
                          CircleFlag(CountryMapper.getCode(match.awayTeamName), size: 48),
                          const SizedBox(height: AppTheme.baseSpacing),
                          Text(
                            match.awayTeamName,
                            style: AppTheme.bodyMd.copyWith(color: AppTheme.onSurface),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
