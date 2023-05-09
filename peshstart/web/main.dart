import 'dart:html';
import 'Transaction.dart';
import 'EWallet.dart';

void main() {

  if(DateTime.now().hour > 11 && DateTime.now().hour < 14){//check if it is peak hour or not
    querySelector('#notice')?.text = "Congrats! You got 10% off due to peak hour bonus!!";
  }
  
  //querySelector('#output')?.text = 'Your Dart app is crawling.';

  var myEWallet = EWallet();

  var balanceElement = querySelector('#output');//displays balance on the html
  balanceElement?.text = "Account Balance: RM${myEWallet.balance.toString()}";

  var topUpAmountElement = querySelector('#topUpAmount') as InputElement;
  var topUpButton = querySelector('#topUpButton');
  topUpButton?.onClick.listen((event) {
    
    var amountStr = topUpAmountElement.value;
    if (amountStr == null) return;

    var amount = double.tryParse(amountStr);
    if (amount == null) return;

    //querySelector('#output')?.text = 'Account balance: ${myEWallet.balance}';
    myEWallet.topUp(amount);
    displayBalance(myEWallet);
  });

  var makePaymentElement = querySelector('#makePayment') as InputElement;
  var makePaymentButton = querySelector('#makePaymentButton');
  makePaymentButton?.onClick.listen((event) {
    // print("Payment button clicked");
    var amountStr = makePaymentElement.value;
    if (amountStr == null) return;

    var amount = double.tryParse(amountStr);
    if (amount == null) return;

    myEWallet.makePayment(amount);
    // Update the balance display
    displayBalance(myEWallet);
  });

  var viewTransactionButton = querySelector('#viewTransactionButton');
  viewTransactionButton?.onClick.listen((event) {
    myEWallet.displayTransactions();
  });

}

void displayBalance(EWallet myEWallet){
  var balanceElement = querySelector('#output');
  balanceElement?.text = "Account Balance: RM${myEWallet.balance.toString()}";
}
