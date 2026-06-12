import '../../domain/entities/match_detail_entity.dart';

class MatchDetailModel extends MatchDetailEntity {
  MatchDetailModel({
    required super.id,
    required super.homeTeamName,
    required super.awayTeamName,
    required super.status,
    super.homeScore,
    super.awayScore,
    required super.stage,
    super.group,
    super.venue,
    required super.utcDate,
  });

  factory MatchDetailModel.fromJson(Map<String, dynamic> json) {
    return MatchDetailModel(
      id: json['id'],
      homeTeamName: json['homeTeam']?['name'] ?? 'Por definir',
      awayTeamName: json['awayTeam']?['name'] ?? 'Por definir',
      status: json['status'],
      homeScore: json['score']?['fullTime']?['home'],
      awayScore: json['score']?['fullTime']?['away'],
      stage: json['stage'] ?? 'Fase de Torneo',
      group: json['group'],
      venue: json['venue'],
      utcDate: DateTime.parse(json['utcDate']),
    );
  }
}
