import 'Transaction.dart';
import 'dart:html';

class EWallet {
  List<Transaction> transactions = [];
  double balance = 0.0;

  //Muhammad Amir Hamzah Bin Abd Aziz 2011685
  void topUp(double amount) {
    var now = DateTime.now();
    var temp = balance;
    // bool? isCreditCard = (querySelector('#isCreditCard') as CheckboxInputElement).checked;
    bool? isCreditCard = (querySelector('[name="paymentMethod"]:checked')
                as RadioButtonInputElement)
            .value ==
        "creditCard";
    bool? isDebitCard = (querySelector('[name="paymentMethod"]:checked')
                as RadioButtonInputElement)
            .value ==
        "debitCard";
    if (amount <= 0) {
      querySelector("#result")?.text = "Invalid amount";
      window.alert("Invalid amount");
      return;
    }
    balance += amount;

    if (isCreditCard == true) {
      balance += 0.50;
      window.alert("Top-up using credit card successful!!");
    } else {
      window.alert("Top-up using debit card successful!!");
    }

    if (isCreditCard == true) {
      transactions
          .add(Transaction("Top-up (Credit Card)", temp, amount, now, balance));
    } else {
      transactions
          .add(Transaction("Top-up (Debit Card)", temp, amount, now, balance));
    }
  }

  //Faishal Aqil Bin Mohd Arief 2014883
  void makePayment(double amount) {    //provessing payment
    var now = DateTime.now();
    var peakHour = now.hour >= 7 && now.hour <= 14;  

    if (amount > 0) {
      if (peakHour == true && amount < balance) {
        print("Congrats! You got 10% off due to peak hour bonus!!");
        window.alert("Congrats! You got 10% off due to peak hour bonus!!");
        amount *= 0.9;
        var temp = balance;
        balance -= amount;
        transactions.add(Transaction("Payment", temp, amount, now, balance));
        if (amount != 0) {
          window.alert("Payment successful!!");
        }
        
      } else if (amount > balance) {
        window.alert("Insufficient funds");
      } else {
        var temp = balance;
        balance -= amount;
        transactions.add(Transaction("Payment", temp, amount, now, balance));
        if (amount != 0) {
          window.alert("Payment successful!!");
        }
      }
    } else {
      window.alert("Invalid amount");
    }
  }

  //Muhammad Firdaus Bin Shahrum 2013803
  void displayTransactions() {
    //this part is so hard to make
    var transactionList = querySelector('#viewTransaction');
    var table = TableElement();
    table.id = 'transactions-table';
    var existingTable = querySelector('#transactions-table');

    if (existingTable != null) {
      existingTable.remove();
    }

    List<TableRowElement> tableRow = [];
    List<TableCellElement> type = [];
    List<TableCellElement> balance = [];
    List<TableCellElement> payment = [];
    List<TableCellElement> date = [];
    List<TableCellElement> remainingAmount = [];

    var headerRow = TableRowElement();
    headerRow.addCell().text = 'Transaction type';
    headerRow.addCell().text = 'Balance';
    headerRow.addCell().text = 'Amount';
    headerRow.addCell().text = 'Date';
    headerRow.addCell().text = 'Remaining Amount';
    table.append(headerRow);

    int x = 0;
    for (var transaction in transactions) {
      tableRow.add(TableRowElement());

      type.add(TableCellElement());
      type[x] = tableRow[x].addCell();
      type[x].text = transaction.type.toString();

      balance.add(TableCellElement());
      balance[x] = tableRow[x].addCell();
      balance[x].text = transaction.balance.toString();

      payment.add(TableCellElement());
      payment[x] = tableRow[x].addCell();
      payment[x].text = transaction.payment.toString();

      date.add(TableCellElement());
      date[x] = tableRow[x].addCell();
      date[x].text = transaction.date.toString();

      remainingAmount.add(TableCellElement());
      remainingAmount[x] = tableRow[x].addCell();
      remainingAmount[x].text = transaction.remainingAmount.toString();

      table.append(tableRow[x]);

      print(
          "Balance: ${transaction.balance}, Payment: ${transaction.payment}, Date: ${transaction.date}, Remaining Amount: ${transaction.remainingAmount}");
      //transactionList?.text = "Balance: ${transaction.balance}, Payment: RM${transaction.payment}, Date: ${transaction.date}, Remaining Amount: ${transaction.remainingAmount}";
      x++;
    }

    document.querySelector('#Transaction-List')?.append(table);
  }
}
