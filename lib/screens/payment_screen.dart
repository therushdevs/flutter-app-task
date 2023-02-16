import 'package:flutter/material.dart';
import 'package:raftlabs_assignment/screens/HomeScreen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _razorpay = Razorpay();
  bool apiCalled = false;
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Msg: ${response.message}'))
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
    _amount.clear();
    _email.clear();
    _contact.clear();
    _description.clear();
    _name.clear();
  }

  /// Text field function
  formField(TextEditingController controller, bool isNum, var hintText){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide:
            const BorderSide(width: 3, color: Colors.blueAccent), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(width: 3, color: Colors.red), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintText: hintText,
        ),
        validator: (value){
          if (value == null || value.isEmpty){
            return 'Please enter some value';
          }else{
            if (isNum && !isNumeric(value)){
              return 'Please enter valid numbers';
            }
          }
          return null;
        },
      ),
    );
  }
  //Check if the entered value in number
  var isNumeric =  (String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.deepOrange.shade50,
          appBar: AppBar(
            backgroundColor: Colors.deepOrange.shade100,
            shadowColor: Colors.deepOrange.shade50,
            title:  Center(
              child: Text(
                'RaftLabs',
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 22,
                    fontWeight:
                    FontWeight.w600),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    formField(_name, false, 'Your name'),
                    formField(_description, false, 'Product name'),
                    formField(_contact, false, 'Contact No.'),
                    formField(_email, false, 'Email Address'),
                    formField(_amount, true, 'Amount to pay'),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: SizedBox(
                        width: 160,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              //Razorpay accepts amount in paise not in rupee, so conversion from rupee to paise necessary
                              // i.e. _amount * 100
                              var options = {
                                'key': razorPayKey,
                                'amount': (double.parse(_amount.text) * 100),
                                'name': _name.text,
                                'description': _description.text,
                                "timeout": "500",
                                'prefill': {
                                  'contact': _contact.text,
                                  'email': _email.text
                                }
                              };
                              _razorpay.open(options);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(Icons.payment),
                              Text(
                                'Pay Fees',
                                style: TextStyle(fontSize: 18),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    ));
  }

}
