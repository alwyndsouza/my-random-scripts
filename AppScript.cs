function sendReminders() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var dataRange = sheet.getDataRange();
  var data = dataRange.getValues();
  var today = new Date();
  var reminderDays = 20; // Number of days before the due date to send a reminder

  for (var i = 1; i < data.length; i++) {
    var policyDueDate = new Date(data[i][3]); // Assuming the due date is in the fourth column (index 3)
    var daysRemaining = Math.floor((policyDueDate - today) / (1000 * 60 * 60 * 24));

    if (daysRemaining <= reminderDays) {
      var policyNumber = data[i][0]; // Assuming the policy number is in the first column (index 0)
      var policyHolder = data[i][1]; // Assuming the policy holder name is in the second column (index 1)
      var policyType = data[i][2]; // Assuming the policy type is in the third column (index 2)
      var insuranceProvider = data[i][4]; 
      var addressOrRego = data[i][5];
      var renewedyn = data[i][7];
      var message = "Policy Number: " + policyNumber + "\n" +
                    "Policy Holder: " + policyHolder + "\n" +
                    "Policy Type: " + policyType + "\n" +
                    "Due Date: " + policyDueDate.toDateString() + "\n" +
                    "Insurance Provider: " + insuranceProvider + "\n" +
                    "Address/ Rego Number: " + addressOrRego + "\n" ;

      // Replace the placeholder email address with the actual email where you want to send the reminder
      if ( renewedyn != "YES" ) {
        MailApp.sendEmail("xxxx@gmail.com", "Insurance Policy Reminder - " + policyNumber + " Due Date: " + policyDueDate.toDateString() + " " + addressOrRego, message);
      }
      

    }
  }
}