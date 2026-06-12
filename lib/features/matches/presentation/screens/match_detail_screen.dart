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

  String _getTeamInitials(String name) {
    if (name.isEmpty) return '??';
    final words = name.trim().split(RegExp(r'\s+'));
    if (words.length > 1) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.length >= 2 ? name.substring(0, 2).toUpperCase() : name.toUpperCase();
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor = AppTheme.onPrimary;
    String text;

    switch (status) {
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppTheme.labelCaps.copyWith(color: textColor, letterSpacing: 1.2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Partido', style: AppTheme.headlineMd),
        backgroundColor: AppTheme.scaffoldBackground,
        iconTheme: const IconThemeData(color: AppTheme.primary),
        elevation: 0,
        centerTitle: true,
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
            padding: const EdgeInsets.all(AppTheme.marginDesktop),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: AppTheme.borderLg,
                    boxShadow: [
                      BoxShadow(color: AppTheme.primary.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(match.stage.replaceAll('_', ' '), style: AppTheme.labelCaps.copyWith(color: AppTheme.outline)),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 36,
                                  backgroundColor: AppTheme.surface,
                                  child: Text(_getTeamInitials(match.homeTeamName), style: AppTheme.headlineLg.copyWith(color: AppTheme.primary)),
                                ),
                                const SizedBox(height: 12),
                                Text(match.homeTeamName, style: AppTheme.bodyMd.copyWith(color: AppTheme.onPrimary, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(scoreText, style: AppTheme.headlineLg.copyWith(color: AppTheme.gold, fontSize: 48)),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 36,
                                  backgroundColor: AppTheme.surface,
                                  child: Text(_getTeamInitials(match.awayTeamName), style: AppTheme.headlineLg.copyWith(color: AppTheme.primary)),
                                ),
                                const SizedBox(height: 12),
                                Text(match.awayTeamName, style: AppTheme.bodyMd.copyWith(color: AppTheme.onPrimary, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildStatusBadge(match.status),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                Text('INFORMACIÓN DEL ENCUENTRO', style: AppTheme.labelCaps.copyWith(color: AppTheme.onSurfaceVariant)),
                const SizedBox(height: AppTheme.baseSpacing),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: AppTheme.borderLg,
                    border: Border.all(color: AppTheme.outline.withOpacity(0.3)),
                  ),
                  padding: const EdgeInsets.all(AppTheme.marginMobile),
                  child: Column(
                    children: [
                      if (match.group != null) ...[
                        _buildInfoRow(Icons.group_work_outlined, 'Grupo', match.group!.replaceAll('_', ' ')),
                        const Divider(height: 24, color: AppTheme.surfaceVariant),
                      ],
                      if (match.venue != null) ...[
                        _buildInfoRow(Icons.stadium_outlined, 'Estadio', match.venue!),
                        const Divider(height: 24, color: AppTheme.surfaceVariant),
                      ],
                      _buildInfoRow(Icons.calendar_today_outlined, 'Fecha Local (Ecuador)', dateStr),
                      const Divider(height: 24, color: AppTheme.surfaceVariant),
                      _buildInfoRow(Icons.access_time_outlined, 'Hora Local (Ecuador)', timeStr),
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
        Icon(icon, color: AppTheme.gold, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTheme.bodyMd.copyWith(color: AppTheme.onSurfaceVariant, fontSize: 14)),
              const SizedBox(height: 2),
              Text(value, style: AppTheme.headlineMd.copyWith(fontSize: 18)),
            ],
          ),
        ),
      ],
    );
  }
}
