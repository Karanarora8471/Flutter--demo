//
// class DateHelper{
//
//   static String convertedDate({required String? date,String? formatter}) {
//     if(date!=null){
//       DateTime dateTime = DateTime.parse(date);
//       String formattedDate = DateFormat(formatter??'dd-MM-yyyy').format(dateTime);
//       return formattedDate;
//     }
//    else{
//      return "Loading";
//     }
//   }
//
//   static String converted12HourFormat({required String? time}){
//     if(time!=null){
//       DateTime dateTime = DateFormat("HH:mm:ss").parse(time);
//       String time12Hour = DateFormat("hh:mm a").format(dateTime);
//       return time12Hour;
//     }
//     else{
//       return "Loading";
//     }
//
//   }
//
// }