import 'dart:convert';
import 'package:flamingo_app/Screens/odeme/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';


class CreditCardPaynet extends StatefulWidget {
  const CreditCardPaynet({Key? key}) : super(key: key);

  @override
  State<CreditCardPaynet> createState() => _CreditCardPaynetState();
}

class _CreditCardPaynetState extends State<CreditCardPaynet> {
  var cardNumber2 = '';
  var expiryDate = '';
  var cardHolderName = '';
  var cvvCode = '';
  var isCvvFocused = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: size.height * 0.07),
          child: Column(
            children: [
              buildCreditCardWidget(),
              buildCreditCardForm(),
              buildPayButton(size)
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPayButton(Size size) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () async {
          if (cardNumber2.length == 19 &&
              cvvCode.length <= 4 &&
              cardHolderName != '' &&
              expiryDate.length == 5) {
            cardNumber2 = cardNumber2.replaceAll(' ', '');
            var expireMonth = expiryDate.split('/')[0];
            var expireYear = '20' + expiryDate.split('/')[1];
            var body = {
              'amount': 1,
              'card_holder': cardHolderName,
              'month': expireMonth,
              'year': expireYear,
              'cvc': cvvCode,
              'pan': cardNumber,
            };
            var res = await http.post(
                Uri.parse('http://10.0.2.2:3000/api/paynet/pay'),
                body: json.encode(body),
                headers: {'Content-Type': 'application/json'});
            var data = json.decode(res.body);
            if (res.statusCode == 200) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WebViewPage(htmlCode:data['page'])));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(data),
                duration: const Duration(seconds: 1),
                backgroundColor: Colors.red,
              ));
            }
            // fonksiyon(cardNumber,cvvCode,cardHolderName,expireMonth,expireYear)
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Lütfen Tüm Değerleri Doldurunuz'),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: Container(
          width: size.width,
          height: size.height * 0.06,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.shade900),
          child: const Text(
            'Ödeme Yap',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  CreditCardForm buildCreditCardForm() {
    return CreditCardForm(
      cardNumber: cardNumber2,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      formKey: formKey,
      onCreditCardModelChange: (CreditCardModel data) {
        setState(() {
          cardHolderName = data.cardHolderName;
          cardNumber2 = data.cardNumber;
          expiryDate = data.expiryDate;
          isCvvFocused = data.isCvvFocused;
          if (data.cvvCode.length <= 3) {
            cvvCode = data.cvvCode;
          }
        });
      },
      themeColor: Colors.red,
      obscureCvv: true,
      obscureNumber: true,
      isHolderNameVisible: true,
      isCardNumberVisible: true,
      isExpiryDateVisible: true,
      cardNumberDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Numara',
        hintText: 'XXXX XXXX XXXX XXXX',
      ),
      expiryDateDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Son kullanma tarihi',
        hintText: 'XX/XX',
      ),
      cvvCodeDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'CVV',
        hintText: 'XXX',
      ),
      cardHolderDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Kart sahibi',
      ),
    );
  }

  CreditCardWidget buildCreditCardWidget() {
    return CreditCardWidget(
      cardNumber: cardNumber2,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      isHolderNameVisible: true,
      showBackView: isCvvFocused,
      onCreditCardWidgetChange:
          (creditCardBrand) {}, //true when you want to show cvv(back) view
    );
  }
}
