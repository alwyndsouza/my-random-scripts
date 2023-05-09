

## Table of Contents

- [Setup](#setup)
- [Usage](#usage)
- [Step 1: Set up the Google Sheet](#step-1-set-up-the-google-sheet)
- [Step 2: Write a script to fetch policy infomation from google sheet](#step-2-write-a-script-to-fetch-policy-data-from-gmail)
- [Step 3: Set up a trigger to automate the script](#step-3-set-up-a-trigger-to-automate-the-script)

## Setup

To set up the policy management system, follow the steps below:

1. Clone this repository to your local machine.
2. Open the Google Sheet where you want to store the policy information or create a new one.
3. Set up the necessary columns in the sheet to store policy information, including policy number, policy holder, policy type, due date, insurance provider, address, annual premium, and renewal status.

## Usage

To use the policy management system, follow the steps outlined below:

### Step 1: Set up the Google Sheet

1. Create a new Google Sheet or open an existing one.
2. Set up the necessary columns to store policy information, including policy number, policy holder, policy type, due date, insurance provider, address, annual premium, and renewal status.

Example:

| Policy Number | Policy Holder | Policy Type | Due Date | Insurance Provider | Address         | Annual Premium | Renewed |
|---------------|---------------|-------------|----------|--------------------|-----------------|----------------|---------|
|  Policy1      | HolderName    |     P123456 |30/01/2024|NRMA                | 66 Stevenson St |     1234       |         |

### Step 2: Write a script to fetch policy data from Gmail

1. Open the Google Sheet.
2. Go to "Extensions" and select "Apps Script."
3. Copy code from AppScript.cs in the editor
4. Save the script

### Step 3: Set up a trigger to automate the script

1. In the Apps Script editor, go to "Edit" and select "Current project's triggers."
2. Click on the "+ Add Trigger" button.  (botton right side of the page)
3. Configure the trigger to run the script at regular intervals to fetch and update the policy data.

That's it! With these steps, you can automate the process of fetching policy data from Google Sheet and send a reminder email when the policy is due.

Feel free to customize and enhance the script as per your specific requirements.
