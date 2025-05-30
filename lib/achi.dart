import 'package:core_retail/data/fiscal/models/payment_fiscal_model.dart';
import 'package:core_retail/presentation/pay/bloc/pay_bloc.dart';
import 'package:core_retail/resources/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/scan.dart';
import 'package:proto_definitions/generated/bills.pbenum.dart';
import 'package:provider/provider.dart';
import 'package:kiosk/provider/cart_provider.dart';
import 'generated/l10n.dart';
class AchiPage extends StatefulWidget {
  const AchiPage({Key? key}) : super(key: key);

  @override
  State<AchiPage> createState() => _AchiPageState();
}

class _AchiPageState extends State<AchiPage> {

  @override
  void initState() {
    super.initState();

    final cart = context.read<CartProvider>();

    final lines = cart.items;

    context.read<PayBloc>().add(PayBill(
        lines: lines,
        payments: [PaymentFiscalModel(code: PaymentType.card, amount: cart.totalPrice)]));

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PayBloc, PayState>(
      listener: (_, state){
        switch(state) {
          case PayInitial():
            break;
          case PayLoading():
            break;
          case PayFailureModel():
            CustomSnackbar.show(context, title: 'Payment', description: state.failure.message);
            Navigator.pop(context);
            break;
          case PayLoaded():
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const PizzaPage()),
                  (Route<dynamic> route) => false,
            );
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Image.asset(
            'assets/pizza_centerblack.png',
            width: 70,
            height: 70,
          ),
          elevation: 0,
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 130,
                    child: Image.asset('assets/card1.png'),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      S.of(context).approveCardMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF010101),
                        fontSize: 20,
                        fontFamily: 'Arial',
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Animație de încărcare
                  const CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 3,
                  ),
                ],
              ),
            ),
            // Butonul de săgeată doar vizual (fără funcționalitate)
            Positioned(
              right: 20,
              bottom: 200,
              child: IgnorePointer(
                ignoring: true, // Nu permite interacțiunea
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
