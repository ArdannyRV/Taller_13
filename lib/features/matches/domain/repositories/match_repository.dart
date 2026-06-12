import '../entities/match_entity.dart';
import '../entities/match_detail_entity.dart';

abstract class MatchRepository {
  Future<List<MatchEntity>> getMatchesByDate(DateTime date);
  Future<MatchDetailEntity> getMatchDetails(int matchId);
}
