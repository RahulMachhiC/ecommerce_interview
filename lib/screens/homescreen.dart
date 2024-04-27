import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interview/controller/productcontroller.dart';
import 'package:interview/screens/prodictdetailscreen.dart';
import 'package:interview/screens/profilescreen.dart';
import 'package:interview/size_extension.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProdutController>().fetchdata(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f7),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            child: Icon(
              Icons.person,
              size: 30.sp,
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
        ],
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          "Home",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Consumer<ProdutController>(
        builder: (context, value, child) {
          if (value.isloading) {
            return Center(
                child: LoadingAnimationWidget.bouncingBall(
              color: Colors.white,
              size: 200,
            ));
          } else if (value.productResponse != null) {
            return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
                itemCount: value.productResponse!.products.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            id: value.productResponse!.products
                                .elementAt(index)
                                .id
                                .toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(8.r),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.r),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: value.productResponse!.products
                                    .elementAt(index)
                                    .thumbnail,
                                height: 80.h,
                                width: 100.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    value.productResponse!.products
                                        .elementAt(index)
                                        .title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "\$ ${value.productResponse!.products.elementAt(index).price}",
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Text(
                                        " ${value.productResponse!.products.elementAt(index).discountPercentage}%OFF",
                                        style: GoogleFonts.inter(
                                          color: Colors.red,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  RatingBar.builder(
                                    onRatingUpdate: (value) {},
                                    initialRating: value
                                        .productResponse!.products
                                        .elementAt(index)
                                        .rating,
                                    minRating: 1,
                                    ignoreGestures: true,
                                    tapOnlyMode: false,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    unratedColor: Colors.amber.withAlpha(50),
                                    itemCount: 5,
                                    itemSize: 18.sp,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    updateOnDrag: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
