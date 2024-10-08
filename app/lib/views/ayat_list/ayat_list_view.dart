import 'package:quran_companion/global/models/ayat_list_view_arguments.dart';
import 'package:quran_companion/global/models/ayat_model.dart';
import 'package:quran_companion/global/services/size_helper_service.dart';
import 'package:quran_companion/global/themes/colors.dart';
import 'package:quran_companion/global/themes/fonts.dart';
import 'package:quran_companion/global/utils/animation_constants.dart';
import 'package:quran_companion/global/widgets/custom_app_bar.dart';
import 'package:quran_companion/global/widgets/custom_text.dart';
import 'package:quran_companion/views/ayat_list/ayat_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_companion/services_locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../global/widgets/ayat_tile/ayat_tile.dart';

class AyatListView extends StatelessWidget {
  final AyatListViewArgumentsModel arguments;
  const AyatListView({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAyatListEmpty = arguments.ayats.isEmpty;

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AyatListViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: arguments.title,
            subtitle: arguments.subtitle,
          ),
          extendBodyBehindAppBar: isAyatListEmpty ? true : false,
          body: isAyatListEmpty
              ? _AyatListEmptyView()
              : Scrollbar(
                  child: ListView.builder(
                    itemCount: arguments.ayats.length,
                    itemBuilder: (context, index) {
                      AyatModel currentAyat = arguments.ayats[index];
                      return AyatTile(
                        number: currentAyat.ayatId!,
                        arabic: currentAyat.arabic ?? 'Arabic not available!',
                        urdu: currentAyat.urdu!,
                        highlightedWord: arguments.highligtedTerm,
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}

class _AyatListEmptyView extends StatelessWidget {
  _AyatListEmptyView();

  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            ghostAnimation,
            width: 192.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                'No ayats found! ',
                size: 15,
                font: poppinsMedium,
                color: darkGray,
              ),
              InkWell(
                onTap: _navigationService.back,
                child: const CustomText(
                  'Try again',
                  size: 15,
                  font: poppinsSemiBold,
                  color: green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
