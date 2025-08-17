import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../models/heart_rate.dart';

/// A card widget that displays heart rate information.
///
/// The first page shows a realtime heart rate chart, while subsequent pages
/// display historical heart rate data.
class HeartRateCard extends StatefulWidget {
  final Stream<int> liveHeartRateStream;
  final List<HeartRate> history;

  const HeartRateCard({
    Key? key,
    required this.liveHeartRateStream,
    required this.history,
  }) : super(key: key);

  @override
  State<HeartRateCard> createState() => _HeartRateCardState();
}

class _HeartRateCardState extends State<HeartRateCard> {
  final List<FlSpot> _liveData = [];

  @override
  void initState() {
    super.initState();
    widget.liveHeartRateStream.listen((bpm) {
      setState(() {
        final double x = _liveData.isEmpty ? 0 : _liveData.last.x + 1;
        _liveData.add(FlSpot(x, bpm.toDouble()));
        if (_liveData.length > 20) {
          _liveData.removeAt(0);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 200,
        child: PageView(
          children: [
            _buildRealtimeChart(),
            _buildHistoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRealtimeChart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: _liveData,
              isCurved: true,
              dotData: FlDotData(show: false),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      itemCount: widget.history.length,
      itemBuilder: (context, index) {
        final HeartRate hr = widget.history[index];
        return ListTile(
          leading: const Icon(Icons.favorite),
          title: Text('${hr.bpm} bpm'),
          subtitle: Text(hr.time.toString()),
        );
      },
    );
  }
}
