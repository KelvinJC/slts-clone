import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/core/utils/formatter_utils.dart';
import 'package:slts_enforcer_app/features/search/presentation/screens/search_result_screen.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/run_plate_notifier.dart';
import 'package:slts_enforcer_app/ui/widgets/app_text_field.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;

  /// Track which violation IDs are expanded
  final Set<int> _expandedIds = {};

  /// Track which violation IDs are selected
  final Set<int> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final runState = ref.watch(runPlateProvider);
    final runCtrl = ref.read(runPlateProvider.notifier);

    final wp = context.wp;
    final hp = context.hp;

    return Scaffold(
      // Show pay/create action bar only when we have results
      bottomNavigationBar: runState.results != null
          ? _buildActionRow(wp, hp)
          : null,
      body: Stack(
        children: [
          BlurryGradientBackground(colors: AppColors.homeGradient),
          Column(
            children: [
              OverlayHeader(
                title: 'Run Plate Number',
                onBack: () => Navigator.of(context).pop(),
                opacity: 0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: wp(4),
                  vertical: hp(2),
                ),
                child: AppTextField(
                  controller: _controller,
                  hintText: 'Run plate number…',
                  showSearchIcon: true,
                  onSubmitted: (val) {
                    runCtrl.search(val.trim());
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: wp(4)),
                  child: runState.loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : runState.error != null
                      ? Center(
                          child: Text(
                            runState.error!,
                            style: TextStyle(color: AppColors.error),
                          ),
                        )
                      : (runState.results == null
                            ? _buildHistory(context, wp, hp)
                            : _buildResults(
                                context,
                                wp,
                                hp,
                                runState.results!,
                              )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Search history placeholder
  Widget _buildHistory(
    BuildContext context,
    double Function(double) wp,
    double Function(double) hp,
  ) {
    final history = ['PCN-002456', 'BEN1300', 'PCN-009876'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Search History', style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: hp(1)),
        ...history.map(
          (item) => ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(item, style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform.flip(
              flipX: true,
              child: Icon(
                Icons.arrow_outward,
                color: AppColors.onBackgroundSurface,
              ),
            ),
            onTap: () {
              _controller.text = item;
              _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: item.length),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Results list with expandable details and checkboxes
  Widget _buildResults(
    BuildContext context,
    double Function(double) wp,
    double Function(double) hp,
    List<Violation> list,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary card
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: hp(2)),
            padding: EdgeInsets.all(wp(4)),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(wp(2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summary of Result',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onBackground,
                  ),
                ),
                SizedBox(height: hp(2)),
                _row('Plate Number:', list.first.plateNumber, wp),
                SizedBox(height: hp(2)),
                _row('Owner Full Name:', list.first.offenderName, wp),
                SizedBox(height: hp(2)),
                _row('Document Status:', list.first.status, wp),
                SizedBox(height: hp(2)),
                _row('Total Violations:', '${list.length}', wp),
              ],
            ),
          ),
          SizedBox(height: hp(3)),
          Text(
            'Violations',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onBackground,
            ),
          ),
          SizedBox(height: hp(2)),

          // violation tiles
          for (final v in list) _buildViolationTile(context, wp, hp, v),
        ],
      ),
    );
  }

  /// Single violation entry
  Widget _buildViolationTile(
    BuildContext context,
    double Function(double) wp,
    double Function(double) hp,
    Violation v,
  ) {
    final isExpanded = _expandedIds.contains(v.id);
    final isSelected = _selectedIds.contains(v.id);

    return Container(
      margin: EdgeInsets.only(bottom: hp(1.5)),
      padding: EdgeInsets.all(wp(3)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(wp(2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // checkbox
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedIds.remove(v.id);
                    } else {
                      _selectedIds.add(v.id);
                    }
                  });
                },
                child: Container(
                  width: wp(5),
                  height: wp(5),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(wp(2)),
                    border: Border.all(
                      color: AppColors.onBackgroundSurface2,
                      width: wp(0.4),
                    ),
                  ),
                  child: isSelected
                      ? Icon(Icons.check, size: wp(3), color: AppColors.surface)
                      : null,
                ),
              ),
              SizedBox(width: wp(2)),
              // title + expand arrow
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isExpanded) {
                        _expandedIds.remove(v.id);
                      } else {
                        _expandedIds.add(v.id);
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          v.offenceName,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.onBackground,
                              ),
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up_outlined
                            : Icons.keyboard_arrow_down_outlined,
                        color: AppColors.onBackgroundSurface2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // expanded details
          if (isExpanded) ...[
            SizedBox(height: hp(2)),
            _detailRow('Plate Number', v.plateNumber, context, wp),
            _detailRow('Owner Full Name', v.offenderName, context, wp),
            _detailRow('Vehicle Type', v.vehicleTypeName, context, wp),
            _detailRow('Offence Type', v.offenceName, context, wp),
            _detailRow('PCN Number', v.pcnNumber, context, wp),
            _detailRow('Offence Name', v.offenceName, context, wp),
            _detailRow(
              'Violation Date',
              // v.violationDate.toLocal().toString().split(' ').first,
              //25-04-2-24
              formatDateShort(v.violationDate, pattern: 'dd-MM-yyyy'),
              context,
              wp,
            ),
            // add number format on amount
            _detailRow(
              'Fine Amount:',
              '₦${formatNumberWithCommas(v.amount, 0)}',
              context,
              wp,
            ),
            _detailRow('Status:', v.status, context, wp),
            _detailRow('Payment Status:', v.paymentStatus, context, wp),
            SizedBox(height: hp(2)),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchResultScreen(violation: v),
                  ),
                );
              },
              child: Text(
                'More Details',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: hp(2)),
          ],
        ],
      ),
    );
  }

  Widget _row(String label, String value, double Function(double) wp) => Row(
    children: [
      Text(label, style: TextStyle(color: AppColors.onBackgroundSurface2)),
      Spacer(),
      Text(value, style: TextStyle(color: AppColors.onBackground)),
    ],
  );

  Widget _detailRow(
    String label,
    String value,
    BuildContext ctx,
    double Function(double) wp,
  ) => Padding(
    padding: EdgeInsets.only(bottom: ctx.hp(1.5)),
    child: Row(
      children: [
        SizedBox(
          width: wp(40),
          child: Text(
            label,
            style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
              color: AppColors.onBackgroundSurface,
              fontSize: wp(3.5),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: wp(3.5),
            ),
          ),
        ),
      ],
    ),
  );

  /// Bottom action row
  Widget _buildActionRow(
    double Function(double) wp,
    double Function(double) hp,
  ) {
    final anySelected = _selectedIds.isNotEmpty;

    final activeDecoration = BoxDecoration(
      gradient: LinearGradient(colors: AppColors.buttonGradient),
      borderRadius: BorderRadius.circular(wp(2)),
    );
    final inactiveDecoration = BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(wp(2)),
      border: Border.all(color: AppColors.onBackgroundSurface2),
    );
    final activeStyle = TextStyle(
      color: AppColors.surface,
      fontWeight: FontWeight.bold,
      fontSize: wp(3.5),
    );
    final inactiveStyle = TextStyle(
      color: AppColors.onBackgroundSurface2,
      fontWeight: FontWeight.bold,
      fontSize: wp(3.5),
    );

    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(horizontal: wp(4), vertical: hp(1)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: anySelected ? () {} : null,
              child: Container(
                height: hp(5.5),
                decoration: anySelected ? activeDecoration : inactiveDecoration,
                child: Center(
                  child: Text(
                    'Pay Now',
                    style: anySelected ? activeStyle : inactiveStyle,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: wp(4)),
          Expanded(
            child: GestureDetector(
              onTap: !anySelected ? () {} : null,
              child: Container(
                height: hp(5.5),
                decoration: !anySelected
                    ? activeDecoration
                    : inactiveDecoration,
                child: Center(
                  child: Text(
                    'Create Violation',
                    style: !anySelected ? activeStyle : inactiveStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
