import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valo_zone/utils/AppColors.dart';
import 'package:valo_zone/utils/Assets_path.dart';

class KnifeDialog extends StatelessWidget {
  const KnifeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.homepageBackground,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r)),
                    child: Image.asset(AssetPath.knife_detail)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      const Row(
                        children: [
                          const Text(
                            "// ORIGIN : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                color: AppColors.dullWhiteText),
                          ),
                          Text(
                            "Independent Manufacturing",
                            style: TextStyle(color: AppColors.greyText),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Text(
                        "// BIOGRAPHY",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: AppColors.dullWhiteText),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const Text(
                        "The Melee is a base melee weapon provided to every player, and cannot be dropped.",
                        style: TextStyle(color: AppColors.greyText),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Text(
                        "// KNIFE IMPACT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: AppColors.dullWhiteText),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),

                      /////Head///
                      Container(
                        height: 70.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.DialogSelected),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 55.h,
                                width: 55.h,
                                decoration: BoxDecoration(
                                    color: AppColors.DialogContainer,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Image.asset(AssetPath.ic_head),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "FRONT SHOT",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.dullWhiteText),
                                  ),
                                  Text(
                                    "50/75 (Primary/Alt)",
                                    style: TextStyle(color: AppColors.greyText),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      /////Body////
                      Container(
                        height: 70.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.DialogSelected),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 55.h,
                                width: 55.h,
                                decoration: BoxDecoration(
                                    color: AppColors.DialogContainer,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Image.asset(AssetPath.ic_body),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "BACK SHOT",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.dullWhiteText),
                                  ),
                                  Text(
                                    "100/150 (Primary/Alt)",
                                    style: TextStyle(color: AppColors.greyText),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),

                      Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Close"))),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
