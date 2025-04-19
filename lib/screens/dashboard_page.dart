import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:manajemen_barang/widgets/custom_navbar.dart'; // Sesuaikan path dengan project kamu

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final primaryColor = Colors.deepOrange.shade400;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPageContent(_currentIndex),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            Navigator.pushNamed(context, '/items');
          }
        },
        primaryColor: primaryColor,
      ),
    );
  }

  Widget _buildPageContent(int index) {
    if (index != 0) {
      return Center(child: Text("Halaman Index: \$index"));
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Header
            Text(
              "Welcome, User!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 24),

            // Info Grid (4 Kotak)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                InfoCard(
                  title: "Low Stock",
                  subtitle: "18 Items",
                  icon: Icons.warning_amber_rounded,
                ),
                InfoCard(
                  title: "Out of Stock",
                  subtitle: "8 Items",
                  icon: Icons.swap_horiz,
                ),
                InfoCard(
                  title: "Upcoming Exp.",
                  subtitle: "4 Items",
                  icon: Icons.schedule,
                ),
                InfoCard(
                  title: "Qty Changes",
                  subtitle: "32 Items",
                  icon: Icons.change_circle,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Grafik dan See All
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stock Usage",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("See All", style: TextStyle(color: primaryColor)),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: [
                        FlSpot(0, 10),
                        FlSpot(1, 20),
                        FlSpot(2, 15),
                        FlSpot(3, 30),
                        FlSpot(4, 25),
                      ],
                      color: primaryColor,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Recent Activity
            Text(
              "Recent Activity",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            const ActivityTile(
              title: "Item 1 masuk",
              date: "19 Apr 2025 - 09:30",
            ),
            const ActivityTile(
              title: "Item 2 keluar",
              date: "19 Apr 2025 - 08:10",
            ),
            const ActivityTile(
              title: "Stok Item DEF diperbarui",
              date: "18 Apr 2025 - 17:00",
            ),
          ],
        ),
      ),
    );
  }
}

// Info Card Widget
class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = Colors.deepOrange.shade400;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: iconColor),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// Activity Tile Widget
class ActivityTile extends StatelessWidget {
  final String title;
  final String date;

  const ActivityTile({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(date, style: const TextStyle(color: Colors.black54)),
      leading: const Icon(Icons.history, color: Colors.black45),
    );
  }
}
