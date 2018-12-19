##### Nibs.DX

**sfdx** - deploy and manage Salesforce data using Salesforce DX

**heroku** - deploy and manage a Node application using Heroku

Nibs.DX is a fun, easy to understand, example of a hybrid app using Salesforce Lightning + Heroku.

Have fun!

---
1. Clone the nibs.dx repo  
`git clone https://github.com/gordonatheroku/nibs.dx.git`

2. Deploy the Salesforce Lightning components to your Developer Edition org  
`cd nibs.dx`  

3. Using Salesforce DX (sfdx) login and authorize the target Salesforce Developer Edition org  
`sfdx force:auth:web:login --setalias nibs-demo-org`

4. Check (-c) the meta-data package with a mock deploy  
`sfdx force:mdapi:deploy -c -d sfdx/nibs-mdpkg -w 5 -u nibs-demo-org`

5. All good - deploy the package to your Developer Edition org  
`sfdx force:mdapi:deploy -d sfdx/nibs-mdpkg -w 5 -u nibs-demo-org`

6. Assign the Nibs_Loyalty_App Permission Set to your Nibs User  
`sfdx force:user:permset:assign -n Nibs_Loyalty_App -u nibs-demo-org`

7. Import Nibs sample data into your Developer Edition org  
`sfdx force:data:tree:import -f sfdx/nibs-data/Product2.json -u nibs-demo-org`  
`sfdx force:data:tree:import -f sfdx/nibs-data/Campaign.json -u nibs-demo-org`  
`sfdx force:data:tree:import -f sfdx/nibs-data/Store__c.json -u nibs-demo-org`

---
8. Open the Nibs Demo Org to make some final configurations  
`sfdx force:org:open -u nibs-demo-org`  

    a. Click on the App Selector, select Accounts in the All Items section  
    b. Click the New button  
    - provide an Account Name and click the Save button  
    
    c. Copy the Account record ID from the browser URL window (the record ID is the 18 character identifier between Account/ and /view in the record URL)
    
    `https://na85.lightning.force.com/lightning/r/Account/0011U000003O3MlQAK/view`

    Account ID == **PASTE--YOURS--HERE** (you will need this in a bit)

9. Assign the Nibs Page Layouts for the Campaign, Contact, and Product objects to the Administrator Profile  

    a. Open Setup -> Object Manager  
    b. Open Campaign -> Page Layouts -> Page Layout Assignments -> Edit Assignment  
    c. Select **System Administrator** under Profiles  
    d. Click in the **Page Layout To Use** chooser and select "Nibs Campaign Layout"  
    e. Click Save  
    f. repeat a-e for the **Contact** object  
    g. repeat a-e for the **Product** object

#### Salesforce Nibs Demo Org configuration is now complete. Woot!

--- 

#### Deploy and Configure the Heroku Nibs Loyalty Application

10. Using the Heroku CLI (heroku) create a Heroku app in the top level nibs.dx project folder  
`heroku create nibs-loyalty-app`  
(**you may need to select a more unique app name . . .**)

11. Deploy the app code to Heroku (note we are deploying the `heroku` subtree folder, not the entire repo - this has consequences: specifically no `Heroku Button`, and no auto-deploys from Github  
`git subtree push --prefix heroku heroku master`

12. Provision a Heroku Postgres database  
`heroku addons:create heroku-postgresql:hobby-dev -a nibs-loyalty-app`

13. Provision a logging utility  
`heroku addons:create papertrail:choklad -a nibs-loyalty-app`

14. Provision Heroku Connect to sync data between Salesforce and Heroku Postgres  
`heroku addons:create herokuconnect:demo -a nibs-loyalty-app`

---
15. Configure Heroku Connect using the Heroku Dashboard  
`heroku open https://dashboard.heroku.com/apps/nibs-loyalty-app`

    a. On the 'Resources' tab, in the 'Add-ons' section, click on the Heroku Connect link  
    b. Click on the 'Setup Connection' button  
    c. Ensure the 'schema name' field is 'salesforce', click on the 'Next' button  
    d. On the 'Authorize Connection' page click on the 'Authorize' button  
    - provide the Username and Password for your `nibs-demo-org` Developer Edition org, and
    - Log In

#### Initial Heroku Connect configuration is complete and you are now connected to your Salesforce Developer Edition org. 
---
#### Complete the configuration by providing the mappings for data in Salesforce to data into Heroku Postgres and sync the data

16. On the Heroku Connect administration page click on the **Settings** tab and select **Import/Export Configuration*

    a. Click the 'Import' button  
    b. On the 'Import Connection Config' page, click on the 'Choose File' button  
    c. Navigate to your 'Nibs.DX/heroku' folder, select the `nibs-connect-mappings.json` file, click the 'Open' button  
    d. On the 'Import Connection Config' page, click on the 'Upload' button

17. On the Heroku Connect administration page click on the **Mappings** tab, confirm these objects are displayed in the **All Mappings** table  

- Campaign
- Contact
- Interaction__c
- Product2
- Store__c

#### Heroku Connect configuration and mappings are complete - data is now actively synchronzing between Salesforce and Heroku Postgres
#### Almost done

---
18. Associate all new Nibs signups with a Salesforce Account (so we can report on consumer selections and preferences)

    a. Update the nibs-loyalty-app with a config var to reference the Account record  
    `heroku config:set CONTACTS_ACCOUNT_ID=0011U000005SYA0QAO -a nibs-loyalty-app`

#### Setup and configuration are complete

#### Open the nibs-loyalty-app, sign up, re-enter your creds, and nom nom :)

`heroku open nibs-loyalty-app`

---
#### Thank you for using Nibs!
#### Questions, comments, contributions, and issues are all welcome

`heroku open https://github.com/gordonatheroku/nibs.dx`

##### Legacy Nibs Changes

Updated: 7/22/2015

    Modify product selection query to filter on the 'family' column - defaults to selecting products where 'family' is 'Nibs' - 
    this can be overridden by setting the PRODUCT_FAMILY config variable
    
Updated: 4/21/2015

    Split 'salesforce' schema sql init commands into a separate command. Run 'npm run init_salesforce_schema' now
    to intialize the database **without** Heroku Connect.
    
