import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/html_table.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';

class RecentCapturesScreen extends ConsumerStatefulWidget {
  const RecentCapturesScreen({super.key});

  @override
  ConsumerState<RecentCapturesScreen> createState() =>
      _RecentCapturesScreenState();
}

class _RecentCapturesScreenState extends ConsumerState<RecentCapturesScreen> {
  int _filterIndex = 0; // 0=All,1=Paid,2=Not Paid

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;
    final headers = [
      const Text('PCN Number'),
      const Text('Plate Number'),
      const Text('Offence'),
      const Text('Amount'),
      const Text('Name'),
      const Text('Age'),
      const Text('Role'),
      const Text('Status'),
    ];
    final rows = [
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Alice'),
        const Text('28'),
        const Text('Admin'),
        const Text('Active'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Bob'),
        const Text('34'),
        const Text('Director'),
        const Text('Pending'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Charlie'),
        const Text('22'),
        const Text('Nurse'),
        const Text('Active'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Diana'),
        const Text('30'),
        const Text('Biller'),
        const Text('Inactive'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Diana'),
        const Text('30'),
        const Text('Biller'),
        const Text('Inactive'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Diana'),
        const Text('30'),
        const Text('Biller'),
        const Text('Inactive'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Diana'),
        const Text('30'),
        const Text('Biller'),
        const Text('Inactive'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Diana'),
        const Text('30'),
        const Text('Biller'),
        const Text('Inactive'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Diana'),
        const Text('30'),
        const Text('Biller'),
        const Text('Inactive'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Diana'),
        const Text('30'),
        const Text('Biller'),
        const Text('Inactive'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Diana'),
        const Text('30'),
        const Text('Biller'),
        const Text('Inactive'),
      ],
      [
        const Text('PCN-002456'),
        const Text('ABC-12Z246'),
        const Text('Speeding'),
        const Text('₦5,000'),
        const Text('Diana'),
        const Text('30'),
        const Text('Biller'),
        const Text('Inactive'),
      ],
    ];

    return Scaffold(
      // extendBodyBehindAppBar: true,
      // backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),

          SafeArea(
            top: false,
            child: Column(
              children: [
                // 1) Overlay header with back + title + search icon
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                      // ignore: deprecated_member_use
                    ).colorScheme.surface.withOpacity(0.5),
                  ),
                  padding: EdgeInsets.only(bottom: hp(1)),
                  child: Column(
                    children: [
                      OverlayHeader(
                        title: 'Recent Capture',
                        onBack: () => Navigator.of(context).pop(),
                        opacity: 0,
                        showSearchIcon: true,
                      ),

                      SizedBox(height: hp(2)),

                      // 2) Filter chips row
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: wp(4)),
                        child: Row(
                          children: [
                            _buildFilterChip('All', 0, wp),
                            SizedBox(width: wp(2)),
                            _buildFilterChip('Paid', 1, wp),
                            SizedBox(width: wp(2)),
                            _buildFilterChip('Not Paid', 2, wp),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: hp(2)),

                // 3) The table card
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: wp(4)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(wp(2)),
                          ),
                          child: HtmlTable(
                            headers: headers,
                            rows: rows,
                            columnWidths: [
                              FixedColumnWidth(wp(30)),
                              FixedColumnWidth(wp(30)),
                              FixedColumnWidth(wp(30)),
                              FixedColumnWidth(wp(30)),
                              IntrinsicColumnWidth(),
                              FixedColumnWidth(80),
                              FixedColumnWidth(wp(30)),
                              FixedColumnWidth(wp(30)),
                            ],
                            borderRadius: BorderRadius.circular(12),
                            outerBorderColor: AppColors.onBackgroundSurface2,
                            innerBorderColor: AppColors.onBackgroundSurface2,
                            // cellWidth: 100,
                            rowHeight: hp(3),
                            cellPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            maxVisibleRows: _filterIndex == 0
                                ? null
                                : _filterIndex == 1
                                ? (rows.length / 2).ceil()
                                : 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int index, double Function(double) wp) {
    final selected = index == _filterIndex;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: selected ? AppColors.primary : AppColors.onBackgroundSurface,
        ),
      ),
      selected: selected,
      selectedColor: AppColors.primary.withOpacity(0.1),
      backgroundColor: AppColors.surface,
      onSelected: (_) => setState(() => _filterIndex = index),
      padding: EdgeInsets.symmetric(horizontal: wp(4), vertical: wp(2)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(wp(2)),
        side: BorderSide(
          color: selected ? AppColors.primary : Colors.transparent,
        ),
      ),
    );
  }
}
