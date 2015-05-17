# Getting started with source control #



### Some browser issues ###
  * This wiki page is not rendered correctly in some places. When the page is reviewed in the "preview" it appears to be fine! Not such a put off for now, but can be reviewed later!

### Creating the database tables ###
  * Download latest code from site.
  * Open toad, open database "JDS".
  * Under db you will find the file "jds\_schema\_data.sql".
  * Open "Edit SqL" in Toad. Copy paste the contents there.
  * Run "Execute. This should run the sql script and create the db that you want.

### Making my first change ###
  * I have modified the file "sidebar.jsp". Added "Generate Reminders" under "Mailing List".
  * Tested the code and saw that in the sidebar "Generate Reminders" is present.
  * The moment I save the changes, you will see the file marked with a different color and on mouse-over on the directory "templates", it shows the comment "Contains new, modified or deleted file properties" and also a small box at the beginning of the directory.
  * Click on "Team" >> "Show Changes". This will show the file "sidebar.jsp" status as "Locally Modified" and the path on the repository.
  * If you have tested the changes and are ready to merge the changes in the mail repository, then right click on the file and press "Commit". This will upload your files on the server.
  * It is always a good idea to "update" your view with the latest changes from the server before commiting the new changes.
  * Also it a good idea to file a bug in the bug tracker and refer to the bug ID in the "Comments".

### Adding a pre-update hook ###
  * Since we have distributed database designers We need to add a pre-update hook to tortoise so that every time we get changes or update our code our local database schema gets merged with the checked in version.
  * Navigate to the JDS subversion client
  * Right click->select Tortoise SVN->Settings->Hook Scripts-
  * Click on the Add button on the right hand side.
  * Select hook type as pre-update hook
  * Select the JDS root(e.g. D:\IAS\JDS) in the "Working Copy Path"
  * Select the path to JDS\db\generateschema.bat in the "Command line to execute" text box.
  * Select the check box "Wait for script to finish" and press OK
  * Run an update and you should see a command window running generateschema.bat
  * Every time an update occurs the .sql files in the JDS\db folder gets refreshed

### Before committing changes ###
**~~Before committing the code, you need to run the script "generateschema". This will dump the additions or changes that you have made to your database copy in the "jds\_schema\_data.sql" file. Now you can commit you changes.~~**

  * Note: A better way for development is using "feature branches" https://code.google.com/p/journal-distribution-system/wiki/4_using_branches_for_development


## Advanced (Required for first time setup by administrators only) ##

### Which files should go into source control when you are using NetBeans ###
  * http://netbeans.org/kb/docs/java/import-eclipse.html#versioning
  * If the project is checked out of a version control system, the **build** (or **nbbuild**), **dist** (or **nbdist**), and the **nbproject/private** folders should not be checked into that version control system. If the project is under the CVS, Subversion, or Mercurial version control systems, the appropriate "ignore" files are created or updated for these directories when the project is imported. Though nbproject/private should be ignored, nbproject should be checked into the version control system. nbproject contains project metadata that enables others users to open the project in NetBeans without having to import the project first.

### Setting ignore for certain directories ###
  * Click on NetBeans >> Team >> Show Changes
  * It will show that the folder "lib", "CopyLibs" and all files under these directories as "Locally new".
  * These are files that are generated and hence should not be under source control.
  * In the "Status", right click on the folder and select "Ignore". Now the directory will not be shown in "Changed list".

### Setting up project for upload into source control ###
  * Locally I have the project called as "Tracker" in the folder called as "Tracker".
  * I want to upload the project with the name "journal-distribution-system".
  * I renamed the project and the folder with the same name. Checked if the project compiles.

### Importing Source into Google Projects ###
  * Right click on the folder you want to import into svn.
  * Right click on folder >> TortoiseSVN >> Import
  * Give the URL as https://journal-distribution-system.googlecode.com/svn/trunk/
  * Give username as the google username
  * The password can be found by logging into google project >> Profile (Top Right corner of the UI) >> Settings
  * If you get an error saying "Cannot connect...", then it means the proxy settings in the TortoiseSVN are not set correctly.