import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/dropdown_menu_notifier.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';


final Map<String, String> offenderDetails = {
  'Full Name': 'Oyewumi Olukunle',
  'ID Number (Driver\'s Licence)': 'DL-123456789',
  'Phone Number': '+234 8102475422',
  'Address': '40, Ajah Str, Abuja',
  'Gender': 'Male',
  'Plate Number': 'KSF-622AE',
  'Date of Birth': '17-08-2024',
  'License plate': 'KSF-622AE',
};

final Map<String, String> vehicleInfo = {
  'License plate': 'KSF-622AE',
  'Vehicle Type': 'Toyota',
  'Make & Model': 'DL-123456789',
  'Color': 'Black',
  'Registration Expiry Date': '17-08-2024',
};

final Map<String, String> locationOfOffence = {
  'Street Name': '40, Idiroko St',
  'State': 'Lagos'
};

// image is fixed, only cards scroll
// class ViolationReportScreen extends StatelessWidget {
//   final Violation violation;
//   const ViolationReportScreen({super.key, required this.violation});
//
//   @override
//   Widget build(BuildContext context) {
//     final hp = context.hp;
//     final wp = context.wp;
//     final imagePath = AppAssets.plateNumberPlaceHolder;
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           BlurryGradientBackground(colors: AppColors.homeGradient),
//
//           SafeArea(
//             top: false,
//             child: Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.vertical(
//                     bottom: Radius.circular(wp(3)),
//                   ),
//                   child: imagePath.startsWith('http')
//                       ? Image.network(
//                     imagePath,
//                     width: double.infinity,
//                     height: hp(30),
//                     fit: BoxFit.cover,
//                   )
//                       : Image.asset(
//                     imagePath,
//                     width: double.infinity,
//                     height: hp(30),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//
//                 /// Scrollable List of DetailCards
//                 Expanded(
//                   child: ListView.separated(
//                     padding: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(2)),
//                     itemCount: 3,
//                     separatorBuilder: (_, __) => SizedBox(height: hp(2)),
//                     itemBuilder: (context, index) {
//                       final headers = [
//                         'Offender Details',
//                         'Vehicle Info',
//                         'Location of Offence',
//                       ];
//                       final details = [
//                         offenderDetails,
//                         vehicleInfo,
//                         locationOfOffence,
//                       ];
//                       return DetailsCard(
//                         hp: hp,
//                         wp: wp,
//                         header: headers[index],
//                         detailsInfo: details[index],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           OverlayHeader(
//             title: 'Violation Report',
//             onBack: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//     );
//   }
// }


// image scrolls with cards
class ViolationReportScreen extends ConsumerWidget {
  final Violation? violation;
  const ViolationReportScreen({super.key, this.violation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hp = context.hp;
    final wp = context.wp;
    final imagePath = AppAssets.plateNumberPlaceHolder;


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
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(wp(3)),
                                ),
                                child: imagePath.startsWith('http')
                                    ? Image.network(
                                  imagePath,
                                  width: double.infinity,
                                  height: hp(30),
                                  fit: BoxFit.cover,
                                )
                                    : Image.asset(
                                  imagePath,
                                  width: double.infinity,
                                  height: hp(30),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: hp(2)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: wp(5)),
                                child: Column(
                                  children: [
                                    DetailsCard(
                                        hp: hp,
                                        wp: wp,
                                        header: 'Offender Details',
                                        detailsInfo: offenderDetails
                                    ),
                                    SizedBox(height: hp(2)),
                                    DetailsCard(
                                        hp: hp,
                                        wp: wp,
                                        header: 'Vehicle Info',
                                        detailsInfo: vehicleInfo
                                    ),
                                    SizedBox(height: hp(2)),
                                    DetailsCard(
                                        hp: hp,
                                        wp: wp,
                                        header: 'Location of Offence',
                                        detailsInfo: locationOfOffence
                                    ),
                                    SizedBox(height: hp(2)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        OverlayHeader(
                          title: 'Violation Report',
                          onBack: () => Navigator.of(context).pop(),
                          rightIcon: AppAssets.menu,
                          onRightIconTap: () => {
                            ref.read(menuStateProvider.notifier).toggleDropDown()
                          },
                          toolTip: 'More options',
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: wp(5), top: hp(12)),
                              child: DropDownMenu(),
                            )
                        ),
                      ]
                  )
              )
            ]
        )
    );
  }
}

class DetailsCard extends StatelessWidget {
  final double Function(double) hp;
  final double Function(double) wp;
  final String header;
  final Map detailsInfo;

  const DetailsCard({
    super.key,
    required this.hp,
    required this.wp,
    required this.header,
    required this.detailsInfo,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: wp(5)) ,
      // height: hp(50),
      width: wp(100),
      decoration: BoxDecoration(
          color: AppColors.onPrimary,
          borderRadius: BorderRadius.circular(wp(5)),
          border: Border.all(
            color: AppColors.onBackgroundSurface2,
            width: 0.5,
          )
      ),
      child: Column(
        children: [
          SizedBox(height: hp(2)),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
                header,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onBackground,
                    fontSize: 15
                )
            ),
          ),
          SizedBox(height: hp(5)),
          // Generate rows from the provided detailsInfo map
          for (final entry in detailsInfo.entries)
            KeyValueTextRow(
              label: entry.key,
              value: entry.value,
              wp: context.wp,
              hp: context.hp,
            ),
          SizedBox(height: hp(2)),
        ],
      ),
    );
  }
}

class KeyValueTextRow extends StatelessWidget {
  final String label;
  final String value;
  final double Function(double) wp;
  final double Function(double) hp;

  const KeyValueTextRow({
    super.key,
    required this.label,
    required this.value,
    required this.wp,
    required this.hp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: hp(1.5)),
      child: Row(
        children: [
          SizedBox(
            width: wp(40),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.onBackgroundSurface,
                // fontWeight: FontWeight.bold,
                fontSize: wp(3.5),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: wp(3.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropDownMenu extends ConsumerWidget {
  const DropDownMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hp = context.hp;
    final wp = context.wp;
    final menuState = ref.watch(menuStateProvider);

    final menuItems = [
      {
        'title': 'ID Collected',
        'onClick': () {
          Navigator.pushNamed(context, '/idCollected');
          ref.read(menuStateProvider.notifier).clear();
        }
      },
      {
        'title': 'Vehicle Impounded',
        'onClick': () {
          Navigator.pushNamed(context, '/vehicleImpounded');
          ref.read(menuStateProvider.notifier).clear();
        }
      },
      {
        'title': 'Resend Link',
        'onClick': () {
          Navigator.pushNamed(context, '/resendViolationLink');
          ref.read(menuStateProvider.notifier).clear();
        }
      },
      {
        'title': 'Share',
        'onClick': () {
          Navigator.pushNamed(context, '/shareViolationLink');
          ref.read(menuStateProvider.notifier).clear();
        }
      },
    ];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: wp(50),
      height: menuState ? hp(25) : 0.0,
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(wp(5)),
        border: Border.all(
          color: menuState ? AppColors.onBackgroundSurface2 : Colors.transparent,
          width: menuState ? 0.5 : 0.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.grayOverlay, // subtle shadow
            blurRadius: menuState ? 2 : 0,
            spreadRadius: menuState ? 1 : 0,
            offset: const Offset(0, 2), // downward shadow
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias, // ensure content doesn't overflow
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: wp(5)),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menuItems.length,
          separatorBuilder: (_, __) => SizedBox(height: hp(2.5)),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return MenuLink(
              title: item['title'] as String,
              onClick: item['onClick'] as VoidCallback,
            );
          },
        ),
      ),
    );
  }
}


class MenuLink extends StatelessWidget {
  /// Text display of the link.
  final String title;

  /// Called when the link is clicked.
  final VoidCallback? onClick;

  const MenuLink({
    super.key,
    required this.title,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final wp = context.wp;

    return GestureDetector(
        onTap: onClick,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppColors.onBackgroundSurface,
            // fontWeight: FontWeight.bold,
            fontSize: wp(3.5),
          ),
        )
    );
  }
}

