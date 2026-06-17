class ScoreDetail {
  final int? home;
  final int? away;

  ScoreDetail({this.home, this.away});
}

class RefereeEntity {
  final String name;
  final String type;

  RefereeEntity({required this.name, required this.type});
}

class MatchDetailEntity {
  final int id;
  final String homeTeamName;
  final String awayTeamName;
  final String status;
  final int? homeScore;
  final int? awayScore;
  final int? homeHalfScore;
  final int? awayHalfScore;
  final String stage;
  final String? group;
  final String? venue;
  final DateTime utcDate;
  final List<RefereeEntity> referees;

  MatchDetailEntity({
    required this.id,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.status,
    this.homeScore,
    this.awayScore,
    this.homeHalfScore,
    this.awayHalfScore,
    required this.stage,
    this.group,
    this.venue,
    required this.utcDate,
    this.referees = const [],
  });
}
