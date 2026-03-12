import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:fluxstore/constant/app_text_styles.dart';
import 'package:fluxstore/constant/images.dart';

class DataNotFoundWithMessage extends StatelessWidget {
  final String? message;
  const DataNotFoundWithMessage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final message = this.message;
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2 + 64,
            height: MediaQuery.of(context).size.height / 2,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: LottieBuilder.asset(
                        AppLottie.noData,
                        animate: true,
                        repeat: true,
                        reverse: false,
                      ),
                    ),
                  ),
                  // Image.asset('assets/img/no_record_found_404_image.png',width: 400.h,height: 400.h,fit: BoxFit.fill),
                  Text(
                    message ?? "",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
