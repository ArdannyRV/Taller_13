import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/repositories/match_repository.dart';
import '../../domain/entities/match_detail_entity.dart';

class MatchDetailScreen extends StatefulWidget {
  final int matchId;
  final MatchRepository repository;

  const MatchDetailScreen({Key? key, required this.matchId, required this.repository}) : super(key: key);

  @override
  State<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen> {
  late Future<MatchDetailEntity> _matchDetailFuture;

  @override
  void initState() {
    super.initState();
    _matchDetailFuture = widget.repository.getMatchDetails(widget.matchId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Partido', style: AppTheme.headlineMd),
        backgroundColor: AppTheme.surface,
        iconTheme: const IconThemeData(color: AppTheme.primary),
        elevation: 0,
      ),
      body: FutureBuilder<MatchDetailEntity>(
        future: _matchDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
          }
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}', style: AppTheme.bodyMd.copyWith(color: AppTheme.error), textAlign: TextAlign.center));
          }

          final match = snapshot.data!;

          final hasStarted = match.status != 'SCHEDULED' && match.status != 'TIMED' && match.status != 'CANCELLED';
          final scoreText = hasStarted ? '${match.homeScore ?? 0} - ${match.awayScore ?? 0}' : 'VS';

          final ecuadorDate = match.utcDate.subtract(const Duration(hours: 5));
          final timeStr = "${ecuadorDate.hour.toString().padLeft(2, '0')}:${ecuadorDate.minute.toString().padLeft(2, '0')}";
          final dateStr = "${ecuadorDate.day.toString().padLeft(2, '0')}/${ecuadorDate.month.toString().padLeft(2, '0')}/${ecuadorDate.year}";

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.marginMobile),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(match.stage.replaceAll('_', ' '), style: AppTheme.labelCaps, textAlign: TextAlign.center),
                const SizedBox(height: AppTheme.baseSpacing),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Text(match.homeTeamName, style: AppTheme.headlineMd, textAlign: TextAlign.center)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.gutter),
                      child: Text(scoreText, style: AppTheme.headlineLg.copyWith(color: AppTheme.primary)),
                    ),
                    Expanded(child: Text(match.awayTeamName, style: AppTheme.headlineMd, textAlign: TextAlign.center)),
                  ],
                ),
                const SizedBox(height: AppTheme.marginDesktop),

                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant,
                    borderRadius: AppTheme.borderLg,
                  ),
                  padding: const EdgeInsets.all(AppTheme.gutter),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (match.group != null) ...[
                        _buildInfoRow(Icons.group_work, 'Grupo', match.group!.replaceAll('_', ' ')),
                        const SizedBox(height: AppTheme.gapComponent),
                      ],
                      if (match.venue != null) ...[
                        _buildInfoRow(Icons.stadium, 'Estadio', match.venue!),
                        const SizedBox(height: AppTheme.gapComponent),
                      ],
                      _buildInfoRow(Icons.calendar_today, 'Fecha Local (Ecuador)', dateStr),
                      const SizedBox(height: AppTheme.gapComponent),
                      _buildInfoRow(Icons.access_time, 'Hora Local (Ecuador)', timeStr),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primary, size: 20),
        const SizedBox(width: AppTheme.baseSpacing),
        Text('$label: ', style: AppTheme.bodyMd.copyWith(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value, style: AppTheme.bodyMd)),
      ],
    );
  }
}
