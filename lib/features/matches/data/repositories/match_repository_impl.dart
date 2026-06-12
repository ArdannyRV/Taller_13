import 'package:dio/dio.dart';
import '../models/match_model.dart';
import '../models/match_detail_model.dart';
import '../../domain/entities/match_entity.dart';
import '../../domain/entities/match_detail_entity.dart';
import '../../domain/repositories/match_repository.dart';
import '../../../../core/network/dio_client.dart';

class MatchRepositoryImpl implements MatchRepository {
  final DioClient _apiClient;

  MatchRepositoryImpl(this._apiClient);

  @override
  Future<List<MatchEntity>> getMatchesByDate(DateTime date) async {
    try {
      final fromDate = date.subtract(const Duration(days: 1));
      final toDate = date.add(const Duration(days: 1));

      final dateFromString = "${fromDate.year}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}";
      final dateToString = "${toDate.year}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}";
      
      final response = await _apiClient.dio.get(
        '/competitions/2000/matches',
        queryParameters: {'dateFrom': dateFromString, 'dateTo': dateToString},
      );

      final List matchesJson = response.data['matches'] ?? [];
      final allMatches = matchesJson.map((json) => MatchModel.fromJson(json)).toList();

      final localMatches = allMatches.where((match) {
        final ecuadorDate = match.utcDate.subtract(const Duration(hours: 5));
        return ecuadorDate.year == date.year && 
               ecuadorDate.month == date.month && 
               ecuadorDate.day == date.day;
      }).toList();

      localMatches.sort((a, b) => a.utcDate.compareTo(b.utcDate));

      return localMatches;

    } on DioException catch (e) {
      throw Exception('Error de red al listar: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }

  @override
  Future<MatchDetailEntity> getMatchDetails(int matchId) async {
    try {
      final response = await _apiClient.dio.get('/matches/$matchId');
      return MatchDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Error de red al cargar detalle: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}
