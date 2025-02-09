import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deliverzler/core/services/init_services/localization_service.dart';
import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_button.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:deliverzler/core/widgets/custom_text_field.dart';
import 'package:deliverzler/modules/home/models/order_model.dart';
import 'package:deliverzler/modules/home/viewmodels/order_dialogs_viewmodel.dart';

class CancelOrderDialog extends ConsumerStatefulWidget {
  final OrderModel orderModel;

  const CancelOrderDialog({
    required this.orderModel,
    Key? key,
  }) : super(key: key);

  @override
  _CancelOrderDialogState createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends ConsumerState<CancelOrderDialog> {
  @override
  void didChangeDependencies() {
    ref.read(orderDialogsViewModel).cancelNote = '';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orderDialogsVM = ref.watch(orderDialogsViewModel.notifier);

    return SizedBox(
      width: Sizes.screenWidth(context),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.dialogHPaddingMedium(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText.h4(
              context,
              tr(context).reasonForCancelingTheOrder + ':',
            ),
            SizedBox(
              height: Sizes.vMarginSmallest(context),
            ),
            CustomTextField(
              context,
              maxLines: 6,
              maxLength: 200,
              textInputAction: TextInputAction.newline,
              hintText: tr(context).typeYourNote + '...',
              contentPadding: EdgeInsets.symmetric(
                vertical: Sizes.vPaddingSmall(context),
                horizontal: Sizes.hPaddingSmall(context),
              ),
              onChanged: (value) {
                orderDialogsVM.cancelNote = value;
              },
            ),
            SizedBox(
              height: Sizes.vMarginSmallest(context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.hPaddingSmallest(context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    child: CustomText.h4(
                      context,
                      tr(context).cancel,
                      color: const Color(0xffffffff),
                      weight: FontStyles.fontWeightMedium,
                      alignment: Alignment.center,
                    ),
                    buttonColor: AppColors.grey,
                    height: Sizes.roundedButtonDialogHeight(context),
                    width: Sizes.roundedButtonSmallWidth(context),
                    onPressed: () {
                      NavigationService.goBack();
                    },
                  ),
                  CustomButton(
                    text: tr(context).confirm,
                    height: Sizes.roundedButtonDialogHeight(context),
                    width: Sizes.roundedButtonSmallWidth(context),
                    onPressed: () {
                      NavigationService.goBack(result: [true]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
