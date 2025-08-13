import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/core/utils/formatter_utils.dart';
import 'package:slts_enforcer_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/recent_captures_notifier.dart';
// import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/run_plate_notifier.dart';
import 'package:slts_enforcer_app/features/violation/presentation/screens/violation_report_screen.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/texts_extension.dart';
import 'package:slts_enforcer_app/ui/widgets/app_text_field.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/widgets/error_popup_widget.dart';
import 'package:slts_enforcer_app/ui/widgets/html_table.dart';
import 'package:slts_enforcer_app/ui/widgets/no_record_found.dart';
// import 'package:slts_enforcer_app/ui/widgets/html_table.dart';

import '../action_card.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _State();
}

class _State extends ConsumerState<HomeTab> {
  var validateEmailBorder = false, validatePasswordBorder = false;
  bool showPatrolModeError = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final wp = context.wp;
    final hp = context.hp;
    final avatarSize = wp(14);
    final runState = ref.watch(runPlateProvider);
    final runCtrl = ref.read(runPlateProvider.notifier);

    return Stack(
      children: [
        BlurryGradientBackground(colors: AppColors.homeGradient),
        SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: wp(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: hp(3)),
                // … reuse your _buildTopBar from earlier or inline …
                _buildTopBar(context, wp, hp, avatarSize, wp(0.5), authState),
                SizedBox(height: hp(4)),
                AppTextField(
                  focusNode: runCtrl.focusNode,
                  controller: runCtrl.controller,
                  hintText: 'Run plate number...',
                  showSearchIcon: true,
                  isProcessing: runState.loading,
                  // onChanged: (v) => runCtrl.setPlate(v),
                  onSubmitted: (val) {
                    FocusScope.of(context).unfocus();
                    // schedule the search after build is over:
                    Future.microtask(() {
                      if (val.trim().isNotEmpty) {
                        runCtrl.search().then((v) {
                          // print(runState.results?.length);
                          if (v == null || v.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No results found for "$val"'),
                              ),
                            );
                          } else {
                            runCtrl.refreshPatrolMode();
                            Navigator.pushNamed(context, '/search');
                          }
                        });
                      }
                    });
                  },
                  // onTap: () => Navigator.push
                  //
                  //Named(context, '/search'),
                ),
                SizedBox(height: hp(3.5)),
                Row(
                  children: [
                    Expanded(
                      child: ActionCard(
                        asset: AppAssets.patrol,
                        label: 'Patrol Mode',
                        onTap: () {
                          // Navigator.pushNamed(context, '/patrol');

                          // show error pop up
                          setState(() {
                            showPatrolModeError = true;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: wp(5)),
                    Expanded(
                      child: ActionCard(
                        asset: AppAssets.createJob,
                        label: 'Create Violation',
                        onTap: () =>
                            Navigator.pushNamed(context, '/createViolation'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: hp(1)),
                _buildRecentHeader(context, wp, hp),
                Expanded(child: _buildEmptyState(context, hp, wp)),
              ],
            ),
          ),
        ),
        if (runState.error != null)
          ErrorPopupWidget(
            onClose: () {
              runCtrl.resetError();
            },
            errorMessage: runState.error,
          ),
        if (showPatrolModeError)
          ErrorPopupWidget(
            onClose: () {
              setState(() {
                showPatrolModeError = false;
              });
            },
            errorMessage: 'No cameras detected for patrol mode.',
          ),
      ],
    );
  }

  Widget _buildTopBar(
    BuildContext ctx,
    double Function(double) wp,
    double Function(double) hp,
    double avatarSize,
    double border,
    AuthState authState,
  ) {
    int notiSum = 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(ctx, '/profile'),
              child: Container(
                width: avatarSize,
                height: avatarSize,
                padding: EdgeInsets.all(border),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundColor: AppColors.homeGradient[0],
                  radius: (avatarSize - 2 * border) / 2,
                  backgroundImage: const AssetImage(AppAssets.avatar),
                ),
              ),
            ),
            SizedBox(width: wp(3)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: Theme.of(ctx).textTheme.titleMedium!.copyWith(
                    color: AppColors.onBackgroundSurface,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: wp(70),
                  child: Text(
                    authState.user?.fullName ?? '',
                    style: Theme.of(ctx).textTheme.headlineSmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Container(
        //   decoration: const BoxDecoration(
        //     color: AppColors.surface,
        //     shape: BoxShape.circle,
        //   ),
        //   child: IconButton(
        //     icon: Stack(
        //       children: [
        //         ImageIcon(AssetImage(AppAssets.notification), size: wp(6)),
        //         Visibility(
        //           visible: true,
        //           child: Positioned(
        //             top: 0,
        //             right: 0,
        //             child: Container(
        //               width: wp(notiSum > 9 ? 4.5 : 3.5),
        //               height: wp(4.2),
        //               decoration: const BoxDecoration(
        //                 color: AppColors.notification,
        //                 shape: BoxShape.circle,
        //               ),
        //               child: Center(
        //                 child: Text(
        //                   notiSum > 9 ? '9+' : notiSum.toString(),
        //                   style: Theme.of(ctx).textTheme.labelSmall!.copyWith(
        //                     fontSize: wp(notiSum > 9 ? 2.5 : 2.2),
        //                     color: AppColors.surface,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //     onPressed: () {},
        //   ),
        // ),
      ],
    );
  }

  Widget _buildRecentHeader(
    BuildContext ctx,
    double Function(double) wp,
    double Function(double) hp,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Captures',
          style: Theme.of(
            ctx,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(ctx, '/recentCaptures'),
          child: Text(
            'View all',
            style: Theme.of(ctx).textTheme.bodySmall!.copyWith(
              color: AppColors.onBackgroundSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(
    BuildContext ctx,
    double Function(double) hp,
    double Function(double) wp,
  ) {
    final state = ref.watch(recentCapturesProvider);

    final violations = state.violations ?? [];

    // Sample data
    final headers = [Text('Plate Number'), Text('Offence'), Text('Status')];

    return Stack(
      children: [
        state.loading
            ? Positioned.fill(child: Center(child: CircularProgressIndicator()))
            : (state.error != null
                  ? NoRecordFound(
                      title: 'Error occurred!',
                      sepearatorHeight: 1,
                      subtitle: 'Something went wrong.\n ${state.error}',
                    )
                  : (violations.isEmpty
                        ? NoRecordFound(
                            title: 'No Activity',
                            sepearatorHeight: 1,
                            subtitle:
                                'Once there is capture, we would\nupdate it here...',
                          )
                        : HtmlTable<Violation>(
                            headers: headers,
                            rowData: violations,
                            rowBuilder: (list) => list.map((v) {
                              var testStyle = TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: v.paymentStatus == "pending"
                                    ? AppColors.error
                                    : v.paymentStatus == "paid"
                                    ? AppColors.success
                                    : null,
                              );
                              return [
                                Text(v.plateNumber, style: testStyle),
                                Text(v.offenceName, style: testStyle),
                                Text(
                                  v.paymentStatus.capitalizeFirst(),
                                  style: testStyle,
                                ),
                              ];
                            }).toList(),
                            onRowTap: (v, idx) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ViolationReportScreen(violation: v),
                                ),
                              );
                            },
                            // Example styling props:
                            columnWidths: [
                              FixedColumnWidth(wp(28)),
                              FixedColumnWidth(wp(38)),
                              FixedColumnWidth(wp(25)),
                            ],
                            // columnWidths: List.generate(
                            //   headers.length,
                            //   (_) => IntrinsicColumnWidth(),
                            // ),
                            borderRadius: BorderRadius.circular(12),
                            outerBorderColor: AppColors.onBackgroundSurface2,
                            innerBorderColor: AppColors.onBackgroundSurface2,
                            rowHeight: hp(3.5),
                            cellPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            maxVisibleRows: 3,
                          ))),
      ],
    );
  }
}
