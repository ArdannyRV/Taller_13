class MatchEntity {
  final int id;
  final String homeTeamName;
  final String awayTeamName;
  final String status;
  final int? homeScore;
  final int? awayScore;
  final String stage;
  final DateTime utcDate;

  MatchEntity({
    required this.id,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.status,
    this.homeScore,
    this.awayScore,
    required this.stage,
    required this.utcDate,
  });
}
