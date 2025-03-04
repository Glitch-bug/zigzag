import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../config/config.dart';
import '../paypal/flutter_paypal.dart';

paypalPayment(
    {required String amt,
      required String clientId,
      required String secretKey,
      var function,
      context
    }) {
  Get.back();
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return UsePaypal(
          sandboxMode: true,
          clientId:
          "${clientId}",
          secretKey:
          "${secretKey}",
          returnURL:
          "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-35S7886705514393E",
          cancelURL: "${config().baseUrl}",
          transactions: [
            {
              "amount": {
                "total": amt,
                "currency": "USD",
                "details": {
                  "subtotal": amt,
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": "The payment transaction description.",
              // "payment_options": {
              //   "allowed_payment_method":
              //       "INSTANT_FUNDING_SOURCE"
              // },
              "item_list": {
                "items": [
                  {
                    "name": "A demo product",
                    "quantity": 1,
                    "price": amt,
                    "currency": "USD"
                  }
                ],
                // shipping address is not required though
                // "shipping_address": {
                //   "recipient_name": "Jane Foster",
                //   "line1": "Travis County",
                //   "line2": "",
                //   "city": "Austin",
                //   "country_code": "US",
                //   "postal_code": "73301",
                //   "phone": "+00000000",
                //   "state": "Texas"
                // },
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) {
            // Get.back();
            function(params);
            Fluttertoast.showToast(msg: 'SUCCESS PAYMENT : $params',timeInSecForIosWeb: 4);
          },
          onError: (error) {
            Fluttertoast.showToast(msg: error.toString(),timeInSecForIosWeb: 4);
          },
          onCancel: (params) {
            Fluttertoast.showToast(msg: params.toString(),timeInSecForIosWeb: 4);
          },
        );
      },
    ),
  );
}