## IDE and Development Environment ##
  * NetBeans 7.0.1
  * Tomcat 7.0.1
  * JDK 1.7
  * Subversion 1.7
  * TortoiseSVN 1.7.1

## Steps for getting started ##
(1) Install JDK 1.7

(2) Install Netbeans 7.1

(3) Go to Tools -> Java Platform. Select JDK 1.7 as default.

(4) Install Subversion 1.7
  * Download and install latest TortoiseSVN from http://tortoisesvn.net/downloads.html
  * I am using TortoiseSVN 1.7.1
  * Install the 32bit or 64 bit version based on the operating system

(5) Configure Subversion URL.
  * Right-Click anywhere -> TortoiseSVN -> RepoBrowser.
  * Set path to "https://journal-distribution-system.googlecode.com/sv/trunk"
  * **If you use http instead of https you will have authentication problems**

(6) Getting password to be used for any operation
  * Get code.google.com password
  * Sign in to Project Hosting
  * Go to Profile (Top Right corner of the UI) >> Settings
  * Take note of the password
  * This password should be used for authenticating into code.google.com

(7) Network Settings
  * Goto TortoiseSVN>>Settings>>Network
  * Enter the proxy server address. Enter username and password used for authentication on the proxy server

(8) Check if the remote repository is shown after step 5

(9) NetBeans -> Tools -> Options -> Miscellaneous -> Versioning -> Select Subversion.

Open Netbeans->Services->Servers->Apache->Right Click, select properties. In the connection tab, give the username and pwd as tomcat/tomcat.

(10) Set "Path to the SVN executable File:". In my case I gave "C:\Program Files\TortoiseSVN\bin"

(11) Install 'mysql-5.5.16-winx64.msi". Install 32-bit or 64 bit based on your system type.

(12) Select all default options. Select "add to firewall". Ensure that the install is successful.

(13) Set username and password as "root".

(14) Download "mysql-connector-java-5.1.18-bin.jar". NetBeans -> Right Click on Project -> Properties -> Libraries.
Select JAR/Folder. Select "mysql-connector-java-5.1.18-bin.jar".
Copy the jar to Tomcat lib folder as well.


(15) Getting code from google code into my laptop
  * Create a folder called as journal-distribution-system
  * Right Click on folder >> SVN Checkout...
  * Check if the Repository URL is https://journal-distribution-system.googlecode.com/svn/trunk/
  * Check if the local directory in which the code has to be brought from google code is correct.
  * Press OK and the code will be brought from google code to your laptop.
  * Once the checkout is successful, then you will see the folder with a "check" sign. This indicates that the project is under source control.

(16) Opening code in NetBeans for the first time
  * Open NetBeans. Check if you are able to load the project
  * If NetBeans detects that the code is under source control, then you will see multiple options under "Team" on the mail menu
  * **If you see an error "Reference Problems".** please let me know ASAP

(17) NetBeans -> Run -> Clean and Build Project. Check if the code builds without any errors

(18) Run -> This wil open the project in the browser. Click on "Login". check if you get the error "Invalid username or password. Please try again".

(19) Install "Quest\_Toad-for-MySQL-Freeware\_601.exe". Select all default options.

(20) Create a new connection. Give user and password as "root".

(21) Create a new database with the name "jds" using Toad.

(22) Open the file "jds\_schema\_data.sql" found in "db". In Toad click on 'Edit Sql". Paste the contents and click on "Execute".
Check if the script executes successfully.

(23) Re-open the db "jds". Several tables will be created. Open the table "user\_role". For "jds@ias.com" define the role "admin".

(24) Create a new user "jds". Set the password as "jds".
In access for Database "jds" enable "select", "insert", "update", "execute".

This should setup your system for working on JDS.
Close NetBeans and re-start NetBeans.
In NetBeans, click on "Run". Check if you are able to login.