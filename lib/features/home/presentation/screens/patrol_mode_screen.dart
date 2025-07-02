import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/home/presentation/screens/patrol_mode_view_details_screen.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/ui/utils/app_assets.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';
import 'package:slts_enforcer_app/ui/widgets/blurry_gradient_background.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';
import 'package:slts_enforcer_app/ui/widgets/html_table.dart';
import 'package:slts_enforcer_app/ui/widgets/overlay_header.dart';

class PatrolModeScreen extends ConsumerWidget {
  const PatrolModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wp = context.wp;
    final hp = context.hp;
    final imagePath = AppAssets.patrolModePlaceholder;
    final List<Violation> violations = [
      Violation(
        pcnNumber: 'PCN-002452',
        plateNumber: 'ABC-1234XL',
        offence: 'Speeding',
        zone: 'Zone A',
        date: DateTime.now(),
        firstName: 'John',
        surname: 'Doe',
      ),
      Violation(
        pcnNumber: 'PCN-006752',
        plateNumber: 'ABC-9034XJ',
        offence: 'Illegal Parking',
        zone: 'Zone B',
        date: DateTime.now().subtract(Duration(days: 1)),
        firstName: 'Jane',
        surname: 'Smith',
      ),
      Violation(
        pcnNumber: 'PCN-006752',
        plateNumber: 'ABC-9034XJ',
        offence: 'Illegal Parking',
        zone: 'Zone B',
        date: DateTime.now().subtract(Duration(days: 1)),
        firstName: 'Jane',
        surname: 'Smith',
      ),
      Violation(
        pcnNumber: 'PCN-006752',
        plateNumber: 'ABC-9034XJ',
        offence: 'Illegal Parking',
        zone: 'Zone B',
        date: DateTime.now().subtract(Duration(days: 1)),
        firstName: 'Jane',
        surname: 'Smith',
      ),
      Violation(
        pcnNumber: 'PCN-006752',
        plateNumber: 'ABC-9034XJ',
        offence: 'Illegal Parking',
        zone: 'Zone B',
        date: DateTime.now().subtract(Duration(days: 1)),
        firstName: 'Jane',
        surname: 'Smith',
      ),
      Violation(
        pcnNumber: 'PCN-006752',
        plateNumber: 'ABC-9034XJ',
        offence: 'Illegal Parking',
        zone: 'Zone B',
        date: DateTime.now().subtract(Duration(days: 1)),
        firstName: 'Jane',
        surname: 'Smith',
      ),
      Violation(
        pcnNumber: 'PCN-006752',
        plateNumber: 'ABC-9034XJ',
        offence: 'Illegal Parking',
        zone: 'Zone B',
        date: DateTime.now().subtract(Duration(days: 1)),
        firstName: 'Jane',
        surname: 'Smith',
      ),
      Violation(
        pcnNumber: 'PCN-006752',
        plateNumber: 'ABC-9034XJ',
        offence: 'Illegal Parking',
        zone: 'Zone B',
        date: DateTime.now().subtract(Duration(days: 1)),
        firstName: 'Jane',
        surname: 'Smith',
      ),
      Violation(
        pcnNumber: 'PCN-006752',
        plateNumber: 'ABC-9034XJ',
        offence: 'Illegal Parking',
        zone: 'Zone B',
        date: DateTime.now().subtract(Duration(days: 1)),
        firstName: 'Jane',
        surname: 'Smith',
      ),
      Violation(
        pcnNumber: 'PCN-006752',
        plateNumber: 'ABC-9034XJ',
        offence: 'Illegal Parking',
        zone: 'Zone B',
        date: DateTime.now().subtract(Duration(days: 1)),
        firstName: 'Jane',
        surname: 'Smith',
      ),
      Violation(
        pcnNumber: 'PCN-006752',
        plateNumber: 'ABC-9034XJ',
        offence: 'Illegal Parking',
        zone: 'Zone B',
        date: DateTime.now().subtract(Duration(days: 1)),
        firstName: 'Jane',
        surname: 'Smith',
      ),
      Violation(
        pcnNumber: 'PCN-006752',
        plateNumber: 'ABC-9034XJ',
        offence: 'Illegal Parking',
        zone: 'Zone B',
        date: DateTime.now().subtract(Duration(days: 1)),
        firstName: 'Jane',
        surname: 'Smith',
      ),
      // …more sample data…
    ];
    final Map<String, String> details = {
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

    final headers = [
      const Text('Plate Number'),
      const Text('Status'),
      const Text('View'),
    ];

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
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: wp(4),
                          vertical: hp(2),
                        ),
                        child: HtmlTable<Violation>(
                          headers: headers,
                          rowData: violations,
                          rowBuilder: (list) => list.map((v) {
                            return [
                              Text(v.plateNumber),
                              // Text(v.zone),
                              const Text(
                                'Not Paid',
                                style: TextStyle(color: AppColors.danger),
                              ),
                              Icon(
                                Icons.visibility,
                                color: AppColors.onBackgroundSurface,
                              ),
                            ];
                          }).toList(),
                          onRowTap: (v, index) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PatrolModeViewDetailsScreen(
                                  details: details,
                                ),
                              ),
                            );
                          },
                          columnWidths: [
                            FixedColumnWidth(wp(40)),
                            FixedColumnWidth(wp(30)),
                            FixedColumnWidth(wp(20)),
                          ],
                          // // Example styling props:
                          // columnWidths: List.generate(
                          //   headers.length,
                          //   (_) => IntrinsicColumnWidth(),
                          // ),
                          borderRadius: BorderRadius.circular(12),
                          outerBorderColor: AppColors.onBackgroundSurface2,
                          innerBorderColor: AppColors.onBackgroundSurface2,
                          rowHeight: hp(2.5),
                          cellPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
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
