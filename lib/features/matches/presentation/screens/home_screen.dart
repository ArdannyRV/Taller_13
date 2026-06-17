import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/repositories/match_repository.dart';
import '../../domain/entities/match_entity.dart';
import '../widgets/match_card.dart';
import 'match_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final MatchRepository repository;

  const HomeScreen({Key? key, required this.repository}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MatchEntity>> _matchesFuture;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  void _fetchMatches() {
    _matchesFuture = widget.repository.getMatchesByDate(_selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime firstWorldCupDate = DateTime(2026, 6, 11);
    final DateTime lastWorldCupDate = DateTime(2026, 7, 19);

    final DateTime initialDate = (_selectedDate.isBefore(firstWorldCupDate) || _selectedDate.isAfter(lastWorldCupDate))
        ? firstWorldCupDate
        : _selectedDate;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstWorldCupDate,
      lastDate: lastWorldCupDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primary,
              onPrimary: AppTheme.onPrimary,
              onSurface: AppTheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _fetchMatches();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateDisplay = "${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}";

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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Mundial 2026', style: AppTheme.headlineMd),
              Text('Partidos del $dateDisplay', style: AppTheme.bodyMd),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
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
          actions: [
            IconButton(
              icon: const Icon(Icons.calendar_month, color: AppTheme.primary),
              onPressed: () => _selectDate(context),
            ),
          ],
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
        child: FutureBuilder<List<MatchEntity>>(
          future: _matchesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
            }
            if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}', style: AppTheme.bodyMd.copyWith(color: AppTheme.error), textAlign: TextAlign.center));
            }
            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(child: Text('No hay partidos del Mundial en esta fecha', style: AppTheme.headlineMd.copyWith(color: AppTheme.onSurfaceVariant), textAlign: TextAlign.center));
            }

            final matches = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.only(top: AppTheme.baseSpacing),
              itemCount: matches.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppTheme.gapComponent),
              itemBuilder: (context, index) {
                final match = matches[index];
                return MatchCard(
                  match: match,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MatchDetailScreen(
                          matchId: match.id,
                          repository: widget.repository,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      ),
    );
  }
}
