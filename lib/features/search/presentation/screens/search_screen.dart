import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/search/presentation/screens/search_result_screen.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/app_text_field.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;
  bool _hasResult = false;

  //list of violations true or false
  List<bool> _violations = [];
  List<bool> _violationsCheckBox = [];
  final detailsMap = {
    // 'Owner Full Name': 'Oyewumi Olukunle',
    // 'Gender': 'Male',
    // 'Owner Phone Number': '+234 8102475422',
    // 'Owner Address': '40, Ajah Str, Abuja',
    'Plate Number': 'KSF-622AE',
    'Owner Full Name': 'Oyewumi Olukunle',
    'Vehicle Type': 'Toyota',
    'Offence Type': 'Speeding',
    'PCN Number': 'PCN-002456',
    'Offence Name': 'Speeding',
    'Violation Date': '24-04-2022',
    'Fine Amount': 'N5,000.00',

    // 'Year of Manufacture': '2013/2014',
    // 'Vehicle Color': 'Black',
    // 'VIN': 'KSF-622AE',
    // 'Engine': '622AE',
    // 'Insurance Status': 'Valid',
    // 'Road Worthiness': 'Valid',
    // 'Reg Date': '24-04-2022',
    // 'Expiry Date': '24-04-2022',
    // 'Outstanding Violation': 'None',
    // 'Unpaid Fine': 'None',
  };

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
    final wp = context.wp;
    final hp = context.hp;

    // your sample history
    final history = ['PCN-002456', 'ABC-12Z246', 'PCN-009876'];

    var noSearchResultsWidgets = <Widget>[
      Text(
        'Search History',
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      // ◀️ Using ListView.builder as you had, but now taps update the controller
      SizedBox(
        height: hp(70),
        child: ListView.builder(
          itemCount: history.length,
          padding: EdgeInsets.only(top: hp(1)),
          itemBuilder: (ctx, i) {
            final item = history[i];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                item,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.onBackgroundSurface,
                ),
              ),
              trailing: Transform.flip(
                flipX: true,
                child: Icon(
                  Icons.arrow_outward,
                  color: AppColors.onBackgroundSurface,
                ),
              ),
              onTap: () {
                // ◀️ Populate the input
                _controller.text = item;
                _controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: item.length),
                );
              },
            );
          },
        ),
      ),
    ];

    final searchResultWidgets = <Widget>[
      Container(
        // height: hp(20),
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
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onBackground,
              ),
            ),
            SizedBox(height: hp(2)),
            Row(
              children: [
                Text(
                  'Plate Number:',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.onBackgroundSurface2,
                  ),
                ),
                Spacer(),
                Text(
                  'KSF-622AE',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.onBackground,
                  ),
                ),
              ],
            ),
            SizedBox(height: hp(2)),
            Row(
              children: [
                Text(
                  'Owner Full Name:',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.onBackgroundSurface2,
                  ),
                ),
                Spacer(),
                Text(
                  'Oyewumi Olukunle',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: hp(2)),
            Row(
              children: [
                Text(
                  'Document Status',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.onBackgroundSurface2,
                  ),
                ),
                Spacer(),
                Text(
                  'Valid',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: hp(2)),
            Row(
              children: [
                Text(
                  'Total Violations:',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.onBackgroundSurface2,
                  ),
                ),
                Spacer(),
                Text(
                  '2',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      SizedBox(height: hp(3)),
      Text(
        'Violations',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.onBackground,
        ),
      ),
      SizedBox(height: hp(2)),
      Container(
        padding: EdgeInsets.all(wp(4)),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(wp(2)),
        ),
        child: Column(
          children: [
            for (int i = 0; i < _violations.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: hp(2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            for (
                              int j = 0;
                              j < _violationsCheckBox.length;
                              j++
                            ) {
                              if (j != i) {
                                _violationsCheckBox[j] = false;
                              }
                            }
                            setState(
                              () => _violationsCheckBox[i] =
                                  !_violationsCheckBox[i],
                            );
                          },
                          child: Container(
                            width: wp(5),
                            height: wp(5),
                            decoration: BoxDecoration(
                              color: _violationsCheckBox[i]
                                  ? AppColors.primary
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(wp(2)),
                              border: Border.all(
                                color: AppColors.onBackgroundSurface2,
                                width: wp(0.4),
                              ),
                            ),
                            child: _violationsCheckBox[i]
                                ? Icon(
                                    Icons.check,
                                    size: wp(3),
                                    color: AppColors.surface,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(width: wp(2)),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              for (int j = 0; j < _violations.length; j++) {
                                if (j != i) {
                                  _violations[j] = false;
                                }
                              }
                              setState(() => _violations[i] = !_violations[i]);
                            },
                            child: Row(
                              children: [
                                Text(
                                  i == 0
                                      ? 'Speed Violation'
                                      : 'Drinking and Driving',
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.onBackground,
                                      ),
                                ),
                                Spacer(),
                                Icon(
                                  !_violations[i]
                                      ? Icons.keyboard_arrow_down_outlined
                                      : Icons.keyboard_arrow_up_outlined,
                                  color: AppColors.onBackgroundSurface2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: hp(2)),
                    Visibility(
                      visible: _violations[i],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final entry in detailsMap.entries)
                            Padding(
                              padding: EdgeInsets.only(bottom: hp(1.5)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: wp(40),
                                    child: Text(
                                      entry.key,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color:
                                                AppColors.onBackgroundSurface,
                                            // fontWeight:
                                            //     FontWeight
                                            //         .bold,
                                            fontSize: wp(3.5),
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      entry.value,
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: wp(3.5),
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
              ),
          ],
        ),
      ),
    ];

    final activeBtnDecoration = BoxDecoration(
      gradient: LinearGradient(
        colors: AppColors.buttonGradient,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(wp(2)),
    );

    final inactiveBtnDecoration = BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(wp(2)),
      border: Border.all(color: AppColors.onBackgroundSurface2),
    );

    final activeBtnStyle = TextStyle(
      fontSize: wp(3.5),
      color: AppColors.surface,
      fontWeight: FontWeight.bold,
    );

    final inactiveBtnStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: wp(3.5),
      color: AppColors.onBackgroundSurface2,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      body: Stack(
        children: [
          // your gradient background
          BlurryGradientBackground(colors: AppColors.homeGradient),

          Column(
            children: [
              OverlayHeader(
                title: 'Run Plate Number',
                onBack: () => Navigator.of(context).pop(),
                opacity: 0,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: wp(4),
                  right: wp(4),
                  top: wp(3),
                  bottom: wp(4),
                ),
                child: AppTextField(
                  controller: _controller,
                  hintText: 'Run plate number...',
                  showSearchIcon: true,
                  onSubmitted: (value) {
                    setState(() {
                      _hasResult = true;
                      _violations = List.generate(2, (_) => false);
                      _violationsCheckBox = List.generate(2, (_) => false);
                    });
                    // print('object---------->');
                    return;
                    // TODO: trigger API lookup or provider action
                    final imagePath =
                        AppAssets.platePlaceholder; // or a network URL

                    // Navigate with the data:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchResultScreen(
                          imagePath: imagePath,
                          details: detailsMap,
                        ),
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: wp(4),
                    right: wp(4),
                    top: wp(3),
                    bottom: wp(4),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _hasResult
                          ? searchResultWidgets
                          : noSearchResultsWidgets,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _hasResult,
                child: Container(
                  color: AppColors.surface,
                  padding: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: wp(4)),
                    child: Padding(
                      padding: EdgeInsets.only(top: hp(2.5), bottom: hp(0.5)),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: hp(5.5),
                                decoration: _violationsCheckBox.contains(true)
                                    ? activeBtnDecoration
                                    : inactiveBtnDecoration,
                                child: Center(
                                  child: Text(
                                    'Pay Now',
                                    style: _violationsCheckBox.contains(true)
                                        ? activeBtnStyle
                                        : inactiveBtnStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: wp(4)),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: hp(5.5),
                                decoration: !_violationsCheckBox.contains(true)
                                    ? activeBtnDecoration
                                    : inactiveBtnDecoration,
                                child: Center(
                                  child: Text(
                                    'Create Violation',
                                    style: !_violationsCheckBox.contains(true)
                                        ? activeBtnStyle
                                        : inactiveBtnStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
