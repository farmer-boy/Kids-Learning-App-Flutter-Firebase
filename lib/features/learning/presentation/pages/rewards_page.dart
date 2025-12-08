import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final padding = (width * 0.04).clamp(12.0, 28.0);
    final cardPadding = (width * 0.05).clamp(12.0, 28.0);
    final iconSize = (width * 0.08).clamp(20.0, 48.0);
    final largeNumberSize = (width * 0.09).clamp(20.0, 40.0);
    final labelSize = (width * 0.045).clamp(12.0, 20.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
        backgroundColor: AppColors.primaryDark,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stars & Level Card
              Container(
                padding: EdgeInsets.all(cardPadding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryGold.withOpacity(0.8),
                      AppColors.accentGold.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Stars',
                            style: TextStyle(
                              fontSize: labelSize,
                              color: AppColors.primaryDark.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(height: padding * 0.25),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.primaryDark,
                                size: iconSize,
                              ),
                              SizedBox(width: padding * 0.3),
                              Text(
                                '250',
                                style: TextStyle(
                                  fontSize: largeNumberSize,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: padding * 0.9,
                        vertical: padding * 0.4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Level 5',
                        style: TextStyle(
                          fontSize: (labelSize * 1.0),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: padding),

              // Recent Achievements
              Text(
                'Recent Achievements',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: (width < 420 ? 18 : 22)),
              ),
              SizedBox(height: padding * 0.6),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: padding * 0.6),
                    padding: EdgeInsets.all(cardPadding * 0.6),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryGold.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(cardPadding * 0.18),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGold.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.emoji_events,
                            color: AppColors.primaryGold,
                            size: (iconSize * 0.95).clamp(18.0, 40.0),
                          ),
                        ),
                        SizedBox(width: padding * 0.6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Achievement ${index + 1}',
                                style: TextStyle(
                                  fontSize: (width < 420 ? 14 : 16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Completed 5 lessons in a row',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: (width < 420 ? 12 : 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(cardPadding * 0.18),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGold.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '+25',
                            style: TextStyle(
                              color: AppColors.primaryGold,
                              fontWeight: FontWeight.bold,
                              fontSize: (width < 420 ? 12 : 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
