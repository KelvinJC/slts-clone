import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/patrol_mode_notifier.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/violation_report_screen.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/utils/texts_extension.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/html_table.dart';
import 'package:slts_enforcer_app/ui/widgets/no_record_found.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';
import 'package:slts_enforcer_app/ui/widgets/pagination_controls.dart';

class PatrolModeScreen extends ConsumerStatefulWidget {
  const PatrolModeScreen({super.key});

  @override
  ConsumerState<PatrolModeScreen> createState() => PatrolModeScreenState();
}

class PatrolModeScreenState extends ConsumerState<PatrolModeScreen> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    //if not authenticated, navigate to login screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(patrolModeProvider.notifier).fetchPatrolMode();
    });
  }

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;
    final hp = context.hp;
    final headers = [Text('Plate Number'), Text('Status'), Text('View')];
    final state = ref.watch(patrolModeProvider);
    final ctrl = ref.read(patrolModeProvider.notifier);

    final violations = state.violations ?? [];

    final imagePath = AppAssets.patrolModePlaceholder;

    return Scaffold(
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),
          SafeArea(
            top: false,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: hp(45),
                        width: double.infinity,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(wp(3)),
                              ),
                              child: imagePath.startsWith('http')
                                  ? Image.network(
                                      imagePath,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      imagePath,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      // Details card
                      SizedBox(
                        height: hp(55),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: wp(4),
                            vertical: hp(2),
                          ),
                          child:
                              // HtmlTable<Violation>(
                              //   headers: headers,
                              //   rowData: violations,
                              //   rowBuilder: (list) => list.map((v) {
                              //     return [
                              //       Text(v.plateNumber),
                              //       // Text(v.zone),
                              //       const Text(
                              //         'Not Paid',
                              //         style: TextStyle(color: AppColors.danger),
                              //       ),
                              //       Icon(
                              //         Icons.visibility,
                              //         color: AppColors.onBackgroundSurface,
                              //       ),
                              //     ];
                              //   }).toList(),
                              //   onRowTap: (v, index) {
                              //     Navigator.of(context).push(
                              //       MaterialPageRoute(
                              //         builder: (_) => PatrolModeViewDetailsScreen(
                              //           details: details,
                              //         ),
                              //       ),
                              //     );
                              //   },
                              //   columnWidths: [
                              //     FixedColumnWidth(wp(40)),
                              //     FixedColumnWidth(wp(30)),
                              //     FixedColumnWidth(wp(20)),
                              //   ],
                              //   // // Example styling props:
                              //   // columnWidths: List.generate(
                              //   //   headers.length,
                              //   //   (_) => IntrinsicColumnWidth(),
                              //   // ),
                              //   borderRadius: BorderRadius.circular(12),
                              //   outerBorderColor: AppColors.onBackgroundSurface2,
                              //   innerBorderColor: AppColors.onBackgroundSurface2,
                              //   rowHeight: hp(2.5),
                              //   cellPadding: const EdgeInsets.symmetric(
                              //     vertical: 10,
                              //     horizontal: 10,
                              //   ),
                              // ),
                              Column(
                                children: [
                                  Expanded(
                                    child: state.loading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : (state.error != null
                                              ? NoRecordFound(
                                                  title: 'Error occurred!',
                                                  subtitle:
                                                      'Something went wrong.\n ${state.error}',
                                                )
                                              : (violations.isEmpty
                                                    ? NoRecordFound()
                                                    : HtmlTable<Violation>(
                                                        headers: headers,
                                                        rowData: violations,
                                                        rowBuilder: (list) => list.map((
                                                          v,
                                                        ) {
                                                          var testStyle = TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color:
                                                                v.paymentStatus ==
                                                                    "pending"
                                                                ? AppColors
                                                                      .error
                                                                : v.paymentStatus ==
                                                                      "paid"
                                                                ? AppColors
                                                                      .success
                                                                : null,
                                                          );
                                                          return [
                                                            Text(v.plateNumber),
                                                            Text(
                                                              v.paymentStatus
                                                                  .capitalizeFirst(),
                                                              style: testStyle,
                                                            ),
                                                            Icon(
                                                              Icons.visibility,
                                                              color: AppColors
                                                                  .onBackgroundSurface,
                                                            ),
                                                          ];
                                                        }).toList(),
                                                        onRowTap: (v, index) {
                                                          Navigator.of(
                                                            context,
                                                          ).push(
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  ViolationReportScreen(
                                                                    violation:
                                                                        v,
                                                                    title:
                                                                        'Patrol Mode',
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                        columnWidths: [
                                                          FixedColumnWidth(
                                                            wp(40),
                                                          ),
                                                          FixedColumnWidth(
                                                            wp(30),
                                                          ),
                                                          FixedColumnWidth(
                                                            wp(20),
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        outerBorderColor: AppColors
                                                            .onBackgroundSurface2,
                                                        innerBorderColor: AppColors
                                                            .onBackgroundSurface2,
                                                        rowHeight: hp(2.5),
                                                        cellPadding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 10,
                                                            ),
                                                        // maxVisibleRows: 3,
                                                      ))),
                                  ),

                                  PaginationControls(
                                    currentPage: _currentPage,
                                    totalPages:
                                        state.pagination?.totalPages ?? 1,
                                    onPageChanged: (page) async {
                                      setState(() => _currentPage = page);
                                      await ctrl.fetchPatrolMode(page: page);
                                    },
                                  ),
                                ],
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                OverlayHeader(
                  title: 'Patrol Mode',
                  onBack: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
