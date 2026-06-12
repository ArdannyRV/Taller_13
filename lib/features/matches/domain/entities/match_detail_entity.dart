class MatchDetailEntity {
  final int id;
  final String homeTeamName;
  final String awayTeamName;
  final String status;
  final int? homeScore;
  final int? awayScore;
  final String stage;
  final String? group;
  final String? venue;
  final DateTime utcDate;

  MatchDetailEntity({
    required this.id,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.status,
    this.homeScore,
    this.awayScore,
    required this.stage,
    this.group,
    this.venue,
    required this.utcDate,
  });
}
