### google code’s integration of issue tracker and version control ###
  * _Every code that is committed to the main branch should have an issue/ bug associated with it._
  * _The enclosure in the issue should show the revision of files that were modified to address the issue._
  * _The enclosure in the issue should have information on the solution._

  * google code’s integration of issue tracker and version control permits an user to create, update, or fix an issue when you are committing a change. In a nutshell "google code’s integration of issue tracker and version control" permits to create, update/ add enclosures and close issues just adding some keyword on your commit. Please check http://code.google.com/p/support/wiki/IssueTracker#Integration_with_version_control for more information.

### Using issue tracker and version control through NetBeans ###
  1. The template to be used for **new issue**, **update an issue** and **fix an issue** is given below.
  1. Save the 3 templates to your laptop.
  1. In NetBeans/ right click on the folder, file to be committed. In the "Commit Message", click on "Load template". This option is present on the top right corner inline with the "Commit Message" label. Select "Automatically fill into commit message". Click on "Load File". Load the appropriate template and edit the relevant information. Remove the text that is not required e.g Remove "#" for the right label and remove the other labels.
  1. **Note**: If the issue number is wrong, then the issue will not be updated.

  * If you want to enter a **new issue**, then enter the following text in the **commit-log** message.
```
#commit comment here

#next line doesn't need any number. Issue number will be automatically assigned after commit. During commit the commit-message will be parsed and if the string "New Issue" is found a new issue will be automatically filed.
New issue
#A summary is always needed. Please complete next line
Summary:
#Uncomment the right Status
#Status: Accepted
#Status: Fixed
#Status: New
#Uncommet right Labels and/or add labels to the list (comma or space separate)
#Labels: Type-Defect Priority-Medium
#Labels: Type-Defect Priority-High
#Labels: Type-Defect Priority-Critical
#Labels: Type-Enhancement Priority-Medium
#Labels: Type-Enhancement Priority-Low
#Labels: Type-Enhancement Priority-High

#Comment text for the issue tracker goes here
```
  * If you want to **update an issue** with more details
```
#commit comment here

#Complete next line with issue number e.g: Update issue 78. This will update the issue 78 with text given below
Update issue
#summary is rarely updated. If you need that uncomment and complete next line
#Summary:
#Uncomment the new Status you would get your issue. No uncomment status will keep the previous status
#Status: Accepted
#Status: Fixed
#Status: New
#Uncommet Labels and/or add labels to the list (comma or space separate) if you want update/add Labels
#Labels: Type-Defect Priority-Medium
#Labels: Type-Defect Priority-High
#Labels: Type-Defect Priority-Critical
#Labels: Type-Enhancement Priority-Medium
#Labels: Type-Enhancement Priority-Low
#Labels: Type-Enhancement Priority-High

#Comment text for the issue tracker goes here
```
  * If you want to **Fix** an issue
```
#commit comment here

#Complete next line with issue number e.g Fixes issue 78. Do not remove the text "Fixes issue". This will change the state of issue 78 to fixed.
Fixes issue

#Comment text for the issue tracker goes here
```

  * Reference: http://www.javalinux.it/wordpress/2009/10/17/google-code-issue-tracker-integration-with-version-control-using-git-commit-template/


### Using issue tracker and version control through TortoiseSVN ###
#### How to setup TortoiseSVN with the issue tracker ####
  * TortoiseSVN can use a COM plugin to query issue trackers when in the commit dialog. http://code.google.com/p/gurtle/
  * Install gurtle from the following site http://code.google.com/p/gurtle/downloads/list. Install the 32bit or 64bit version based on your operating system. Check the "Requirements" section in the webpage.
  * Right Click any folder >> TortoiseSVN >> Settings >> Issue Tracker Integration >> Add
  * Enter local path where the bug tracker data can be stored.
  * Give parameters as "project=journal-distribution-system". Click on "Options" >> Test
  * I got a message "The Google Code project ... appears valid and reachable at ...."

  * **Following settings should be done by the administrator**, once so that the changes are visible to all. Open the command prompt and type in the following:
```

The assumption is that TortoiseSVN is installed at 
C:\Program Files\TortoiseSVN and 
that the repository is present at 
D:\PERSONAL_SAVE\IAS\test

Step1:
This property specifies the COM UUID of the IBugtraqProvider
C:\PROGRA~1\TortoiseSVN\bin>svn propset bugtraq:provideruuid {91974081-2DC7-4FB1-B3BE-0DE1C8D6CE4E} D:\PERSONAL_SAVE\IAS\test
property 'bugtraq:provideruuid' set on 'D:\PERSONAL_SAVE\IAS\test'

For systems that are using 64-bit TorToiseSVN use the following command
C:\PROGRA~1\TortoiseSVN\bin>svn propset bugtraq:provideruuid64 {A0557FA7-7C95-485b-8F40-31303F762C57} D:\PERSONAL_SAVE\IAS\test

Step2:
This property specifies the parameters passed to the IBugtraqProvider.
C:\PROGRA~1\TortoiseSVN\bin>svn propset bugtraq:providerparams project=journal-distribution-system D:\PERSONAL_SAVE\IAS\test
property 'bugtraq:providerparams' set on 'D:\PERSONAL_SAVE\IAS\test'

Step3: Commit the changes to the main trunk.
D:\PERSONAL_SAVE\IAS\test>C:\PROGRA~1\TortoiseSVN\bin\svn commit -m "Added TSVN/Gurtle IBugTraqProvider properties."

The same can be added using the visual interface.
Right-Click on the repository >> TortoiseSVN >> Properties and add a new property.

```

#### How to use TortoiseSVN with the issue tracker ####
  * Check if the issue list is visible. Right Click on any File >> SVN Commit >> Select Issue. Click on "Select Issue", you should be able to see the list of issues.

  * Reference: http://tortoisesvn.net/docs/release/TortoiseSVN_en/tsvn-dug-settings.html