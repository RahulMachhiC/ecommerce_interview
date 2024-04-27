import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:interview/main.dart';
import 'package:interview/model/productresponse.dart';
import 'package:interview/model/singleproduct.dart';

import '../api/app_repository.dart';

class ProdutController extends ChangeNotifier {
  ProductResponse? productResponse;
  bool isloading = false;
  bool iserror = false;
  SingleProduct? singleProduct;
  String errortext = '';
  bool isfavorite = false;

  void fetchdata({
    required BuildContext context,
  }) async {
    isloading = true;
    notifyListeners();

    try {
      await AppRepository().fetchproducts().then((value) {
        isloading = false;

        productResponse = ProductResponse.fromJson(value);
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      iserror = true;
      isloading = false;

      notifyListeners();
    } finally {}
    notifyListeners();
  }

  void fetchsingledata({
    required BuildContext context,
    required String id,
  }) async {
    isloading = true;
    notifyListeners();

    try {
      await AppRepository().fetchsingleproduct(productid: id).then((value) {
        isloading = false;

        singleProduct = SingleProduct.fromJson(value);
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      iserror = true;
      isloading = false;

      notifyListeners();
    } finally {}
    notifyListeners();
  }

  void addtofavorite({
    required BuildContext context,
    required String productid,
  }) async {
    isloading = true;
    notifyListeners();

    try {
      await AppRepository()
          .addfavorite(
              productid: productid,
              userid: sharedPreferences!.getString("id") ?? '')
          .then((value) {
        isloading = false;
        if (value["code"] == 200) {
          Fluttertoast.showToast(
            msg: value["message"],
          );
          isfavorite = true;
        } else {
          Fluttertoast.showToast(
            msg: value["message"],
          );
        }

        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      iserror = true;
      isloading = false;

      notifyListeners();
    } finally {}
    notifyListeners();
  }

  void removefavorite({
    required BuildContext context,
    required String productid,
  }) async {
    isloading = true;
    notifyListeners();

    try {
      await AppRepository()
          .removefavorite(
              productid: productid,
              userid: sharedPreferences!.getString("id") ?? '')
          .then((value) {
        isloading = false;
        if (value["code"] == 200) {
          Fluttertoast.showToast(
            msg: value["message"],
          );
          isfavorite = false;
        } else {
          Fluttertoast.showToast(
            msg: value["message"],
          );
        }

        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      iserror = true;
      isloading = false;

      notifyListeners();
    } finally {}
    notifyListeners();
  }
}
