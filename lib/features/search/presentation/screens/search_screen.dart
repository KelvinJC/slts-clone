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

    return Scaffold(
      body: Stack(
        children: [
          // your gradient background
          BlurryGradientBackground(colors: AppColors.homeGradient),

          Column(
            children: [
              OverlayHeader(
                title: 'Search',
                onBack: () => Navigator.of(context).pop(),
                opacity: 0,
              ),
              Expanded(
                child: Padding(
                  // padding: EdgeInsets.all(wp(4)),
                  padding: EdgeInsets.only(
                    left: wp(4),
                    right: wp(4),
                    top: wp(3),
                    bottom: wp(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Replaced raw TextField with AppTextField + controller
                      AppTextField(
                        controller: _controller,
                        hintText: 'Run plate number...',
                        readOnly: false,
                        showSearchIcon: true,
                        onSubmitted: (value) {
                          // TODO: trigger API lookup or provider action
                          final imagePath =
                              AppAssets.platePlaceholder; // or a network URL
                          final detailsMap = {
                            'Owner Full Name': 'Oyewumi Olukunle',
                            'Gender': 'Male',
                            'Owner Phone Number': '+234 8102475422',
                            'Owner Address': '40, Ajah Str, Abuja',
                            'Plate Number': 'KSF-622AE',
                            'Vehicle Type': 'Toyota',
                            'Year of Manufacture': '2013/2014',
                            'Vehicle Color': 'Black',
                            'VIN': 'KSF-622AE',
                            'Engine': '622AE',
                            'Insurance Status': 'Valid',
                            'Road Worthiness': 'Valid',
                            'Reg Date': '24-04-2022',
                            'Expiry Date': '24-04-2022',
                            'Outstanding Violation': 'None',
                            'Unpaid Fine': 'None',
                          };

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

                      SizedBox(height: hp(4)),

                      Text(
                        'Search History',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),

                      // ◀️ Using ListView.builder as you had, but now taps update the controller
                      Expanded(
                        child: ListView.builder(
                          itemCount: history.length,
                          padding: EdgeInsets.only(top: hp(1)),
                          itemBuilder: (ctx, i) {
                            final item = history[i];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                item,
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
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
                                _controller.selection =
                                    TextSelection.fromPosition(
                                      TextPosition(offset: item.length),
                                    );
                              },
                            );
                          },
                        ),
                      ),
                    ],
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
