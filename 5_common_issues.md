## Problem1: ##
```
Exception in thread "main" java.lang.IllegalArgumentException: PWC6309: Illegal compilerSourceVM: 1.7
	at org.apache.jasper.JspC.setCompilerSourceVM(JspC.java:708)

	at org.netbeans.modules.web.project.ant.JspC.main(JspC.java:80
```
## Solution1: ##
Do not build jsp.
Project->Properties->Compiling->De-select "Test compile all JSP files during builds"
http://netbeans.org/bugzilla/show_bug.cgi?id=201414

---

## Problem2: ##
If you get the following error:
```
org.tigris.subversion.javahl.ClientException: 
The path 'C:\Users\I038668\Desktop\personal\IAS\sandbox' 
appears to be part of a Subversion 1.7 or greater working copy.  
Please upgrade your Subversion client to use this working copy.
```
## Solution2: ##
  * Open the file netbeans.conf. I have my Netbeans installed in D:\TECH\_INSTALLS\NetBeans 7.0.1
    * I found the file at D:\TECH\_INSTALLS\NetBeans 7.0.1/etc/netbeans.conf
    * In "netbeans\_default\_options", I added the string "-J-DsvnClientAdapterFactory=commandline" as the last option
    * Then re-start Netbeans
    * Reload the project. You may see a popup saying "NetBeans Subversion support requires a Subversion client!". Select option "Install Subversion Commandline Client". Give the patch where Subversion 1.7 is installed. In my cas, I gave the path as "C:/Program Files/TortoiseSVN/bin"
    * Why this change is required: Subversion 1.7 (still in beta phase) will introduce a fundamental change in the working copy format. Rather than a few hundred ".svn" directories scattered all around your directory tree, there will be a single ".svn" folder in the root directory (like in most other version control tools). Till a plugin is available to read files stored by svn 1.7 this is the only solution. For this reason the NetBeans is setup to use the command line client exclusively. This is achieved by setting the switch "-J-DsvnClientAdapterFactory=commandline"from the command-line or in the netbeans.conf file.


---

## Problem3: ##
If you see the following problem with Netbeans when you try to use Subversion with NetBeans
```
"Netbeans Subversion support requires a Subversion client! Install Subversion Commandline Client.."
```
## Solution3: ##
Re-install tortoiseSVN. Select "Modify" and install commandline option.
Open a command line shell, check if the following command produces an output, "svn --version".
else add the "C:\Program Files\TortoiseSVN\bin" to the path.

---

## Problem4: ##
Many times when I run Netbeans, I get an error saying
```
port 8080 already in use.
```
## Solution4: ##
Check if the tomcat server is running by typing the following in the browser. http://localhost:8080.
If this opens the tomcat page means that the tomcat server is running.
  * Try to shutdown the server by executing the shutdown.bat in the tomcat installation directory.
  * If that also does not work, check if the "java" process is running. Kill the java process and check that tomcat server is not running. Try running your executable in NetBeans now.
  * If that still does not work, then goto Servers->Select Apache Tomcat ->Connection. Change the Server port to some other port no say 8081
  * If that does not work, then you need to reboot your machine

---

## Problem5: ##
```
The APR based Apache Tomcat Native library which allows optimal performance in production environments was not found on the java.library.path
```

## Solution5: ##
Ignore the error.


---

## Problem6: ##
In NetBeans observed that NetBeans is using the default version of JDK i.e JDK 1.6.0.22 (Using JRE\_HOME:        "D:\TECH\_INSTALLS\jdk1.6.0\_22")
But I wanted it to use JDK 1.7.0.22
## Solution6: ##
I did not want to change the default "JRE\_HOME" since this was being used by other programs. Hence another way to change this it to configure NetBeans to use the JDK you want to use.
Edited "D:\TECH\_INSTALLS\NetBeans 7.0.1\etc\netbeans.conf".
Changed "netbeans\_jdkhome="D:\TECH\_INSTALLS\jdk1.6.0\_22"" to use
netbeans\_jdkhome="D:\TECH\_INSTALLS\jdk1.7.0\_02"
Another way is as follows:
In NetBeans Navigate to servers->Apache tomcat->properties->platform, select 1.7 jdk if already present in the drop down else add and select it.

---

## Problem7: ##
In the apache tomcat log you find the following error while deploying the application.
```
SEVERE: Exception opening database connection
java.sql.SQLException: com.mysql.jdbc.Driver
	at org.apache.catalina.realm.JDBCRealm.open(JDBCRealm.java:701)
	at org.apache.catalina.realm.JDBCRealm.startInternal(JDBCRealm.java:782)
```
## Solution7: ##
Copy the "mysql-connector-java-5.1.18-bin" in the "Apache Tomcat 7.0.14\lib" directory.