import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interview/controller/productcontroller.dart';
import 'package:interview/model/productresponse.dart';
import 'package:interview/size_extension.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<ProdutController>()
          .fetchsingledata(context: context, id: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        margin: EdgeInsets.only(bottom: 30.h),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child:
            Consumer<ProdutController>(builder: (context, controller, child) {
          return InkWell(
            onTap: () {
              controller.isfavorite
                  ? controller.removefavorite(
                      context: context, productid: widget.id)
                  : controller.addtofavorite(
                      context: context, productid: widget.id);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                Text(
                  controller.isfavorite
                      ? "  Remove Favorite"
                      : "  Add to favourites",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          );
        }),
      ),
      backgroundColor: const Color(0xfff0f0f7),
      appBar: AppBar(
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 2,
        title:
            Consumer<ProdutController>(builder: (context, controller, child) {
          return Text(
            controller.singleProduct == null
                ? ""
                : controller.singleProduct!.title,
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          );
        }),
      ),
      body: Consumer<ProdutController>(builder: (context, controller, child) {
        if (controller.isloading) {
          return Center(
              child: LoadingAnimationWidget.bouncingBall(
            color: Colors.white,
            size: 200,
          ));
        } else if (controller.singleProduct != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              CarouselSlider(
                items: controller.singleProduct!.images
                    .map((item) => Container(
                          child: Container(
                            margin: const EdgeInsets.all(.0),
                            child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                child: Stack(
                                  children: <Widget>[
                                    CachedNetworkImage(
                                      imageUrl: item,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                      height: 400.h,
                                    )
                                  ],
                                )),
                          ),
                        ))
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 1.6,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.singleProduct!.images
                    .asMap()
                    .entries
                    .map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.singleProduct!.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "By : ${controller.singleProduct!.brand}",
                      style: GoogleFonts.inter(
                          color: Colors.pink,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "\$ ${controller.singleProduct!.price}",
                          style: GoogleFonts.inter(
                            color: Colors.green,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          " ${controller.singleProduct!.discountPercentage}%OFF",
                          style: GoogleFonts.inter(
                            color: Colors.red,
                            fontSize: 16.sp,
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
                      initialRating: controller.singleProduct!.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      unratedColor: Colors.amber.withAlpha(50),
                      itemCount: 5,
                      itemSize: 28.sp,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      updateOnDrag: false,
                      ignoreGestures: true,
                      tapOnlyMode: false,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      controller.singleProduct!.description,
                      style: GoogleFonts.inter(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
            ],
          );
        }
        return const SizedBox();
      }),
    );
  }
}
