import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppTheme.labelCaps.copyWith(color: textColor, letterSpacing: 1.0, fontSize: 10),
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
      margin: const EdgeInsets.symmetric(vertical: 4),
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
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        match.stage.replaceAll('_', ' '),
                        style: AppTheme.labelCaps.copyWith(color: AppTheme.outline, fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildStatusBadge(),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _FlagImage(code: CountryMapper.getCode(match.homeTeamName), size: 44),
                          const SizedBox(height: 4),
                          Text(
                            match.homeTeamName,
                            style: AppTheme.bodyMd.copyWith(color: AppTheme.onSurface, fontSize: 14),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Text(
                            scoreText,
                            style: AppTheme.headlineLg.copyWith(
                              color: AppTheme.primary,
                              fontSize: hasStarted ? 30 : 20,
                            ),
                          ),
                          if (!hasStarted) ...[
                            const SizedBox(height: 4),
                            Text(timeStr, style: AppTheme.statsNumeric.copyWith(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                          ]
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: [
                          _FlagImage(code: CountryMapper.getCode(match.awayTeamName), size: 44),
                          const SizedBox(height: 4),
                          Text(
                            match.awayTeamName,
                            style: AppTheme.bodyMd.copyWith(color: AppTheme.onSurface, fontSize: 14),
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

class _FlagImage extends StatelessWidget {
  final String code;
  final double size;

  const _FlagImage({Key? key, required this.code, this.size = 48}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        'https://flagcdn.com/w80/$code.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: size,
            height: size,
            color: AppTheme.surfaceVariant,
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: AppTheme.surfaceVariant,
            child: const Icon(Icons.flag, color: AppTheme.onSurfaceVariant),
          );
        },
      ),
    );
  }
}
