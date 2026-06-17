import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/country_mapper.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: AppTheme.labelCaps.copyWith(color: textColor, letterSpacing: 1.0, fontSize: 10),
      ),
    );
  }

  String _refereeTypeLabel(String type) {
    switch (type) {
      case 'REFEREE':
        return 'Árbitro Principal';
      case 'ASSISTANT_REFEREE':
        return 'Árbitro Asistente';
      case 'FOURTH_OFFICIAL':
        return 'Cuarto Árbitro';
      case 'VIDEO_ASSISTANT_REFEREE':
        return 'VAR';
      default:
        return type.replaceAll('_', ' ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/wallpaper_mundial_app.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Detalle del Partido', style: AppTheme.headlineMd),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: AppTheme.onSurface),
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(child: Container(height: 3, color: Colors.red.shade700)),
                      Expanded(child: Container(height: 3, color: Colors.green.shade700)),
                      Expanded(child: Container(height: 3, color: Colors.blue.shade700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: AppTheme.borderLg,
                    border: Border.all(color: AppTheme.outline.withOpacity(0.4), width: 1),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(match.stage.replaceAll('_', ' '), style: AppTheme.labelCaps.copyWith(color: AppTheme.outline, fontSize: 10)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                _FlagCdnImage(code: CountryMapper.getCode(match.homeTeamName), size: 52),
                                const SizedBox(height: 8),
                                Text(
                                  match.homeTeamName,
                                  style: AppTheme.bodyMd.copyWith(color: AppTheme.onSurface, fontWeight: FontWeight.bold, fontSize: 14),
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(scoreText, style: AppTheme.headlineLg.copyWith(color: AppTheme.primary, fontSize: 36)),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                _FlagCdnImage(code: CountryMapper.getCode(match.awayTeamName), size: 52),
                                const SizedBox(height: 8),
                                Text(
                                  match.awayTeamName,
                                  style: AppTheme.bodyMd.copyWith(color: AppTheme.onSurface, fontWeight: FontWeight.bold, fontSize: 14),
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildStatusBadge(match.status),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Text('INFORMACIÓN DEL ENCUENTRO', style: AppTheme.labelCaps.copyWith(color: AppTheme.onSurfaceVariant, fontSize: 10)),
                const SizedBox(height: 6),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: AppTheme.borderLg,
                    border: Border.all(color: AppTheme.outline.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      if (match.group != null) ...[
                        _buildInfoRow(Icons.group_work_outlined, 'Grupo', match.group!.replaceAll('_', ' ')),
                        const Divider(height: 16, color: AppTheme.surfaceVariant),
                      ],
                      if (match.venue != null) ...[
                        _buildInfoRow(Icons.stadium_outlined, 'Estadio', match.venue!),
                        const Divider(height: 16, color: AppTheme.surfaceVariant),
                      ],
                      _buildInfoRow(Icons.calendar_today_outlined, 'Fecha Local (Ecuador)', dateStr),
                      const Divider(height: 16, color: AppTheme.surfaceVariant),
                      _buildInfoRow(Icons.access_time_outlined, 'Hora Local (Ecuador)', timeStr),
                    ],
                  ),
                ),

                if (hasStarted) ...[
                  const SizedBox(height: 16),
                  Text('DESGLOSE DEL MARCADOR', style: AppTheme.labelCaps.copyWith(color: AppTheme.onSurfaceVariant, fontSize: 10)),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: AppTheme.borderLg,
                      border: Border.all(color: AppTheme.outline.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        _buildScoreRow(
                          'Primer Tiempo',
                          '${match.homeHalfScore ?? 0} - ${match.awayHalfScore ?? 0}',
                        ),
                        const Divider(height: 16, color: AppTheme.surfaceVariant),
                        _buildScoreRow(
                          'Final',
                          '${match.homeScore ?? 0} - ${match.awayScore ?? 0}',
                        ),
                      ],
                    ),
                  ),

                  if (match.referees.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text('EQUIPO ARBITRAL', style: AppTheme.labelCaps.copyWith(color: AppTheme.onSurfaceVariant, fontSize: 10)),
                    const SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: AppTheme.borderLg,
                        border: Border.all(color: AppTheme.outline.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: match.referees.map((r) => _buildRefereeRow(r)).toList(),
                      ),
                    ),
                  ],
                ],
              ],
            ),
          );
        },
      ),
      ),
    );
  }

  Widget _buildScoreRow(String label, String score) {
    return Row(
      children: [
        Icon(Icons.sports_soccer_outlined, color: AppTheme.gold, size: 20),
        const SizedBox(width: 12),
        Text(label, style: AppTheme.bodyMd.copyWith(color: AppTheme.onSurfaceVariant, fontSize: 12)),
        const Spacer(),
        Text(score, style: AppTheme.headlineMd.copyWith(fontSize: 16, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _buildRefereeRow(RefereeEntity referee) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.flag_outlined, color: AppTheme.gold, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(referee.name, style: AppTheme.bodyMd.copyWith(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
                Text(_refereeTypeLabel(referee.type), style: AppTheme.bodyMd.copyWith(fontSize: 11, color: AppTheme.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.gold, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTheme.bodyMd.copyWith(color: AppTheme.onSurfaceVariant, fontSize: 12)),
              const SizedBox(height: 1),
              Text(value, style: AppTheme.headlineMd.copyWith(fontSize: 15)),
            ],
          ),
        ),
      ],
    );
  }
}

class _FlagCdnImage extends StatelessWidget {
  final String code;
  final double size;

  const _FlagCdnImage({Key? key, required this.code, this.size = 52}) : super(key: key);

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
