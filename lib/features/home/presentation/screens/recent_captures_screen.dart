import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/recent_captures_notifier.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/violation_report_screen.dart';
import 'package:slts_enforcer_app/ui/utils/texts_extension.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/html_table.dart';
import 'package:slts_enforcer_app/ui/widgets/no_record_found.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';
import 'package:slts_enforcer_app/ui/widgets/pagination_controls.dart';

class RecentCapturesScreen extends ConsumerStatefulWidget {
  const RecentCapturesScreen({super.key});

  @override
  ConsumerState<RecentCapturesScreen> createState() =>
      _RecentCapturesScreenState();
}

class _RecentCapturesScreenState extends ConsumerState<RecentCapturesScreen> {
  int _filterIndex = 0; // 0=All,1=Paid,2=Not Paid
  int _currentPage = 1;
  // final List<Violation> violations = [
  //   Violation(
  //     pcnNumber: 'PCN-002452',
  //     plateNumber: 'ABC-1234XL',
  //     offence: 'Speeding',
  //     zone: 'Zone A',
  //     date: DateTime.now(),
  //     firstName: 'John',
  //     surname: 'Doe',
  //   ),
  //   Violation(
  //     pcnNumber: 'PCN-006752',
  //     plateNumber: 'ABC-9034XJ',
  //     offence: 'Illegal Parking',
  //     zone: 'Zone B',
  //     date: DateTime.now().subtract(Duration(days: 1)),
  //     firstName: 'Jane',
  //     surname: 'Smith',
  //   ),
  //   // …more sample data…
  // ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(recentCapturesProvider.notifier).fetchRecentCaptures();
    });
  }

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;
    final headers = [Text('Plate Number'), Text('Offence'), Text('Status')];
    final state = ref.watch(recentCapturesProvider);
    final ctrl = ref.read(recentCapturesProvider.notifier);

    final violations = state.violations ?? [];
    final filteredViolations = violations.where((v) {
      String statusFilter;
      if (_filterIndex == 0) {
        statusFilter = v.paymentStatus; // No filter, keep current
      } else if (_filterIndex == 1) {
        statusFilter = 'paid';
      } else {
        statusFilter = 'pending';
      }

      return v.paymentStatus == statusFilter;
    }).toList();

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
                        showIcon: true,
                        // onIconTap: () {},
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
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(wp(2)),
                                ),
                                child: state.loading
                                    ? Center(child: CircularProgressIndicator())
                                    : (state.error != null
                                          ? NoRecordFound(
                                              title: 'Error occurred!',
                                              subtitle:
                                                  'Something went wrong.\n ${state.error}',
                                            )
                                          : (filteredViolations.isEmpty
                                                ? NoRecordFound()
                                                : HtmlTable<Violation>(
                                                    headers: headers,
                                                    rowData: filteredViolations,
                                                    rowBuilder: (list) => list.map((
                                                      v,
                                                    ) {
                                                      var testStyle = TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color:
                                                            v.paymentStatus ==
                                                                "pending"
                                                            ? AppColors.error
                                                            : v.paymentStatus ==
                                                                  "paid"
                                                            ? AppColors.success
                                                            : null,
                                                      );
                                                      return [
                                                        Text(
                                                          v.plateNumber,
                                                          style: testStyle,
                                                        ),
                                                        Text(
                                                          v.offenceName,
                                                          style: testStyle,
                                                        ),
                                                        Text(
                                                          v.paymentStatus
                                                              .capitalizeFirst(),
                                                          style: testStyle,
                                                        ),
                                                      ];
                                                    }).toList(),
                                                    onRowTap: (v, idx) {
                                                      Navigator.of(
                                                        context,
                                                      ).push(
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              ViolationReportScreen(
                                                                violation: v,
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                    // // Example styling props:
                                                    // columnWidths: [
                                                    //   FixedColumnWidth(wp(28)),
                                                    //   FixedColumnWidth(wp(38)),
                                                    //   FixedColumnWidth(wp(25)),
                                                    // ],
                                                    columnWidths: List.generate(
                                                      headers.length,
                                                      (_) =>
                                                          IntrinsicColumnWidth(),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                    outerBorderColor: AppColors
                                                        .onBackgroundSurface2,
                                                    innerBorderColor: AppColors
                                                        .onBackgroundSurface2,
                                                    rowHeight: hp(3),
                                                    cellPadding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 10,
                                                        ),
                                                    // maxVisibleRows: 3,
                                                  ))),
                              ),
                            ),
                            // SizedBox(height: hp(2)),
                            PaginationControls(
                              currentPage: _currentPage,
                              totalPages: state.pagination?.totalPages ?? 1,
                              onPageChanged: (page) async {
                                setState(() => _currentPage = page);
                                await ctrl.fetchRecentCaptures(page: page);
                              },
                            ),
                          ],
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
