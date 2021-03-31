import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
//
import '../../1MainHelper/Helpers/helper.dart';

class RadioButtons extends StatefulWidget {
  final ValueChanged<PaymentMethods> onChange;

  const RadioButtons({Key key, this.onChange}) : super(key: key);
  @override
  _RadioButtonsState createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  PaymentMethods _character = PaymentMethods.bank;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text(
              'حوالة مصرفية مباشرة',
              overflow: TextOverflow.fade,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
            ),
            trailing: Radio<PaymentMethods>(
              value: PaymentMethods.bank,
              activeColor: Colors.black,
              groupValue: _character,
              onChanged: (PaymentMethods value) {
                setState(() {
                  _character = value;
                  widget.onChange(value);
                });
              },
            ),
          ),
          ListTile(
            title: const Text(
              'stc pay',
              overflow: TextOverflow.fade,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
            ),
            trailing: Radio<PaymentMethods>(
              value: PaymentMethods.stcPay,
              activeColor: Colors.black,
              groupValue: _character,
              onChanged: (PaymentMethods value) {
                setState(() {
                  _character = value;
                  widget.onChange(value);
                });
              },
            ),
          ),
          ListTile(
            title: const Text(
              'PayPal',
              textScaleFactor: 1,
              overflow: TextOverflow.fade,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
            ),
            trailing: Radio<PaymentMethods>(
              value: PaymentMethods.paypal,
              activeColor: Colors.black,
              groupValue: _character,
              onChanged: (PaymentMethods value) {
                setState(() {
                  _character = value;
                  widget.onChange(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
