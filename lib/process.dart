import 'package:calculator/decimal.dart';

class Process {
  static String str = '0';
  static bool useDot = true;
  static bool appendStr = true;
  static bool appendOper = true;

  static void add(String val) {
    if (str.compareTo('0') == 0) {
      if (val == '+' || val == '*' || val == '/') {
        return;
      } else if (val == '.') {
        str += val;
        //str = val;
        useDot = false;
      } else {
        str = val;
      }
      //str = val;
    } else if (str == 'Undefined') {
      clear();
      str = val;
    } else if ((str.endsWith('+') && val == '+') ||
        (str.endsWith('-') && val == '-') ||
        (str.endsWith('*') && val == '*') ||
        (str.endsWith('/') && val == '/') ||
        (str.endsWith('.') && val == '.') ||
        (str.endsWith('+') && val == '.') ||
        (str.endsWith('-') && val == '.') ||
        (str.endsWith('*') && val == '.') ||
        (str.endsWith('/') && val == '.') ||
        (str.endsWith('.') && val == '+') ||
        (str.endsWith('.') && val == '-') ||
        (str.endsWith('.') && val == '*') ||
        (str.endsWith('.') && val == '/')) {
      return;
    } else if (str.endsWith('+') && (val == '-' || val == '*' || val == '/') ||
        str.endsWith('-') &&
            str != '-' &&
            (val == '+' || val == '*' || val == '/') ||
        str.endsWith('*') && (val == '+' || val == '/') ||
        str.endsWith('/') && (val == '+' || val == '*')) {
      if ((str.substring(str.length - 2).startsWith('*') ||
              str.substring(str.length - 2).startsWith('/')) &&
          str.endsWith('-')) {
        return;
      } else {
        str = str.substring(0, str.length - 1);
        str += val;
      }
    } else if ((str.endsWith('*') && val == '-') ||
        (str.endsWith('/') && (val == '-'))) {
      str += val;
    } else if (str == '-') {
      if (val == '+' || val == '-' || val == '*' || val == '/') {
        return;
      } else {
        str += val;
      }
    } else if (useDot == true && val == '.') {
      str += val;
      useDot = false;
    } else if (useDot == false &&
        (val == '+' || val == '-' || val == '*' || val == '/')) {
      str += val;
      appendStr = true;
      useDot = true;
    } else if (useDot == false && val == '.') {
      return;
    } else if (appendStr == false && appendOper == true) {
      if (val == '+' || val == '-' || val == '*' || val == '/') {
        str += val;
        appendStr = true;
      }
      return;
    } else if (appendStr == false) {
      return;
    } else {
      str += val;
    }
  }

  static void clear() {
    str = '0';
    useDot = true;
    appendStr = true;
    appendOper = true;
  }

  static void delete() {
    if (str.compareTo('0') != 0) {
      String temp = str.substring(0, str.length - 1);
      if (str.endsWith('.')) {
        useDot = true;
      }
      str = temp == '' ? str = '0' : str = temp;
    }
  }

  static String compute() {
    //String to add numbers until we hit into an operator (+,-,*,/)
    String accumulatingString;
    //List used to final calculation
    List<String> lstToCompute = [];
    //Loop through the string
    for (int i = 0; i < str.length; i++) {
      //if the character is not an operator, then add the character to the end of $accumulatedString
      if (str[i] != "+" && str[i] != "-" && str[i] != "*" && str[i] != "/") {
        // Check if the $accumulatedString is null AND not "-"
        // True: add the str[i] to $accumulatedString
        // False:
        // print(accumulatingString);
        // print(str[i]);
        accumulatingString =
            (accumulatingString == null && accumulatingString != "-"
                ? "${str[i]}"
                : "$accumulatingString${str[i]}");
      } else {
        //If it is an operator, then add $accumulatedString to the $lstToCompute, and 'reset' $accumulatedString
        if (accumulatingString != null) {
          lstToCompute.add(accumulatingString);
          accumulatingString = null;
        }
        //After adding the number to the list, add the operator behind it.
        lstToCompute.add(str[i]);
      }
    }
    //Add you operator to the $lstToCompute
    lstToCompute.add(accumulatingString);

    //Check if the first character in $lstToCompute is a '-' operator,
    //if TRUE, combine with the second item in list
    if (lstToCompute[0] == "-") {
      lstToCompute[0] = "-${lstToCompute[1]}";
      //replace second item with NULL
      lstToCompute[1] = null;
      //remove all NULL value from $lstToCompute
      lstToCompute.removeWhere((e) => e == null);
    }

    //Find if there are any '*' or '/' inside $lstToCompute
    while ((lstToCompute.indexWhere((e) => e == '*') > 0) ||
        (lstToCompute.indexWhere((e) => e == '/') > 0)) {
      if ((lstToCompute.indexWhere((e) => e == '*') > 0)) {
        //get the position of the FIRST '*' operator
        //there could be many
        int index = (lstToCompute.indexWhere((e) => e == '*'));

        //enable multiply negative value
        if (lstToCompute[index + 1] == '-') {
          Decimal multiplication = Decimal.parse(lstToCompute[index - 1]) *
              -Decimal.parse(lstToCompute[index + 2]);
          lstToCompute[index - 1] = null;
          lstToCompute[index + 1] = null;
          lstToCompute[index + 2] = null;
          lstToCompute[index] = multiplication.toString();
          lstToCompute.removeWhere((e) => e == null);
        } else {
          //do multiplication of items on the left and right side
          Decimal multiplication = Decimal.parse(lstToCompute[index - 1]) *
              Decimal.parse(lstToCompute[index + 1]);
          //replace left and right with NULL
          lstToCompute[index - 1] = null;
          lstToCompute[index + 1] = null;
          //replace '*' operator with your new result, 'multiplication'
          lstToCompute[index] = multiplication.toString();
          //remove all NULL values
          lstToCompute.removeWhere((e) => e == null);
        }
      }
      if ((lstToCompute.indexWhere((e) => e == '/') > 0)) {
        //get the position of the FIRST '/' operator
        //there could be many
        int index = (lstToCompute.indexWhere((e) => e == '/'));
        //enable dividing negative value
        if (lstToCompute[index + 1] == '-') {
          if ((lstToCompute[index + 2]) == '0') {
            print('Undefined');
            return ('Undefined');
          }
          Decimal division = Decimal.parse(lstToCompute[index - 1]) /
              -Decimal.parse(lstToCompute[index + 2]);
          lstToCompute[index - 1] = null;
          lstToCompute[index + 1] = null;
          lstToCompute[index + 2] = null;
          lstToCompute[index] = division.toString();
          lstToCompute.removeWhere((e) => e == null);
        } else {
          if ((lstToCompute[index + 1]) == '0') {
            print('Undefined');
            return ('Undefined');
          }
          //do division of items on the left and right side
          Decimal division = Decimal.parse(lstToCompute[index - 1]) /
              Decimal.parse(lstToCompute[index + 1]);
          //replace left and right with NULL
          lstToCompute[index - 1] = null;
          lstToCompute[index + 1] = null;
          //replace '*' operator with your new result, 'division'
          lstToCompute[index] = division.toString();
          //remove all NULL values
          lstToCompute.removeWhere((e) => e == null);
        }
      }
    }
    //At this point, $lstToCompute should have no more '*' and '/' operations
    //try this
    // print("After multiplication and division");
    // print(lstToCompute);

    //do the same thing with '+' and '-'
    while ((lstToCompute.indexWhere((e) => e == '+') > 0) ||
        (lstToCompute.indexWhere((e) => e == '-') > 0)) {
      if ((lstToCompute.indexWhere((e) => e == '+') > 0)) {
        int index = (lstToCompute.indexWhere((e) => e == '+'));
        Decimal addition = Decimal.parse(lstToCompute[index - 1]) +
            Decimal.parse(lstToCompute[index + 1]);
        lstToCompute[index - 1] = null;
        lstToCompute[index + 1] = null;
        lstToCompute[index] = addition.toString();

        lstToCompute.removeWhere((e) => e == null);
      }
      if ((lstToCompute.indexWhere((e) => e == '-') > 0)) {
        int index = (lstToCompute.indexWhere((e) => e == '-'));
        Decimal subtraction = Decimal.parse(lstToCompute[index - 1]) -
            Decimal.parse(lstToCompute[index + 1]);
        lstToCompute[index - 1] = null;
        lstToCompute[index + 1] = null;
        lstToCompute[index] = subtraction.toString();
        lstToCompute.removeWhere((e) => e == null);
      }
    }

    //At this point, the whole list should only have 1 item inside, the final result
    //try this
    // print("After addition and subtractions");
    // print(lstToCompute);

    //Take your calculation and change to string
    String computedString = lstToCompute[0].toString();

    useDot = false;
    appendStr = false;
    appendOper = true;

    //Because we do calculation in Decimal, it might end with '.0'
    //This behavior is occured in mobile app

    if (computedString.endsWith(".0")) {
      //return a substring with the final 2 characters removed
      String answer = computedString.substring(0, computedString.length - 2);

      if (answer == '0') {
        useDot = true;
        appendStr = true;
        appendOper = true;
      }

      return answer;
    } else if (computedString == 'Infinity') {
      return 'Undefined';
    } else if (computedString.endsWith('.')) {
      computedString = computedString.substring(0, computedString.length - 1);
      return computedString;
    } else {
      //print(computedString);
      if (computedString == '0') {
        useDot = true;
        appendStr = true;
        appendOper = true;
      } else if (computedString == '.') {
        appendStr = true;
      }
      //return the entire string when the ending is something else like '.124'
      return computedString;
    }
  }
}
