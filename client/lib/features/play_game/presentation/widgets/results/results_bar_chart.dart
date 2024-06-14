import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/active_game.dart';

/// A bar chart to display the scores of the players in the game.
class ResultsBarChart extends ConsumerWidget {
  /// Creates a new [ResultsBarChart] instance.
  const ResultsBarChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortedPlayers = ref.watch(activeGameProvider).sortedPlayers;

    final barGroups = sortedPlayers.asMap().entries.map((entry) {
      final index = entry.key;
      final player = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: <BarChartRodData>[
          BarChartRodData(
            toY: player.score.toDouble(),
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();

    return SizedBox(
      height: 300,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            minY: sortedPlayers.last.score.toDouble() ~/ 5 * 5,
            maxY: ((sortedPlayers.first.score.toDouble() + 4) ~/ 5) * 5,
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Text(
                      sortedPlayers[value.toInt()].name,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    );
                  },
                  reservedSize: 34,
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            barGroups: barGroups,
            gridData: FlGridData(show: false),
          ),
        ),
      ),
    );
  }
}
