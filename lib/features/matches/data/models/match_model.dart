import '../../domain/entities/match_entity.dart';

class MatchModel extends MatchEntity {
  MatchModel({
    required super.id,
    required super.homeTeamName,
    required super.awayTeamName,
    required super.status,
    super.homeScore,
    super.awayScore,
    required super.stage,
    required super.utcDate,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'],
      homeTeamName: json['homeTeam']?['name'] ?? 'Por definir',
      awayTeamName: json['awayTeam']?['name'] ?? 'Por definir',
      status: json['status'],
      homeScore: json['score']?['fullTime']?['home'],
      awayScore: json['score']?['fullTime']?['away'],
      stage: json['stage'] ?? 'Fase de Torneo',
      utcDate: DateTime.parse(json['utcDate']),
    );
  }
}
