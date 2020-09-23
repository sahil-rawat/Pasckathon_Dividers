
import 'dart:core';


//Algorithm to allot days using Aadhar number.
class Algorithm{
  List getDays(String aadharNumber){

    List Input = aadharNumber.split("");
    List aadhar = [];
    //Dividing Aadhar number into 3 sections.
    for(int i =0; i<3;i++){
      String a = "";
      for(int j=0; j<4; j++){
        a+= Input[j];
      }
      aadhar.add(a);
      Input.removeRange(0,4);
    }
    //Applying mod 7 on the 3 sections
    aadhar = aadhar.map((x) => int.parse(x)%7).toList();

    //Checking for repetition and solving them by adding 1, if any.
    int index = 0;
    while(aadhar.contains(aadhar[index])){
      if(aadhar.indexOf(aadhar[index]) != aadhar.lastIndexOf(aadhar[index])){
        aadhar[index] += 1;
        if(aadhar[index] > 7){
          aadhar[index] = 1;
        }
      }
      else{
        index +=1;
        if(index >2){
          break;
        }
      }
    }

    //Assigning days to numbers
    var days = {
      0: "Monday",
      1: "Tuesday",
      2: "Wednesday",
      3: "Thursday",
      4: "Friday",
      5: "Saturday",
      6: "Sunday"
    };
    List finalDays = [];
    for (int i = 0; i < 3; i++) {
      if (days.containsKey(aadhar[i])) {
        finalDays.add(days[aadhar[i]]);
      }
    }
    print(finalDays);
    return finalDays;
  }
}


