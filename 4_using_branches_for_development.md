## Creating and using your own branch for development ##
## Why create your own branch ##
  * It is a good practice to save the code in the repository frequently. But this may cause accidental conflicts with other users on the main "trunk" if the code is not completed as expected.
  * The code on the main "trunk" should also be pristine and not polluted with half-cooked code.Better solution is to create your own branch or line of development in the repository. This allows the user to save half-broken work frequently without interfering with others, yet you can still selectively share information with your collaborators.
  * Also it is a good practise to "review the code" before the code is "updated" to the main trunk. The code on the branch can be reviewed before being merged into the main branch.
  * Development of several features can be broken down into parts and each feature can be developed on a separate branch used for development.

## Some basics ##
  * Working copy: This is the copy of the code on your harddisk, you local copy where you are making changes
  * URL: This is the URL with which your working copy is associated. This is the URL from which the working copy will be updated with the latest code when you run "Update". This is the URL on which your local changes will be updated when you run "Commit". This could be the "/trunk" if you are working on the trunk or the "branch" on which you are working.
  * Feature branch: This is the branch you want to use for your feature development. The code from the "feature branch" will be merged into the main line of development on "/trunk".

## Creating your own branch (feature branch) ##
  * Right Click on folder journal-distribution-system >> TortoiseSVN >> Branch/ Tag
  * I wanted to name my branch as alok\_branch\_111119 (Naming convention: nameOfUser\_purpose\_yymmdd).
  * In the "To path", give the path as "brances/alok\_branch\_111119". Check if the "From" points to the "http://xxx.googlecode.com/svn/trunk". Check if the "Destination URL" points to "http:// journal-distribution-system.googlecode.com/svn/branches/alok\_branch\_111119". Click on "OK".
  * Command Line option: _svn copy http://journal-distribution-system.googlecode.com/svn/trunk  http://journal-distribution-system.googlecode.com/svn/branches/alok_branch_111119 -m "Give comment here"_

## Checkout code for development ##
  * Once your own private branch is created, bring it to your laptop for further development.
  * Right Click >> SVN Checkout...
  * Check if the URL points to the correct branch: "https://journal-distribution-system.googlecode.com/svn/branches/alok_branch_111119". Select the "Checkout directory". Check if the directory name is same as the "branch name". Click ok. This is the working copy of the branch.
  * Command Line option: _svn checkout https://journal-distribution-system.googlecode.com/svn/branches/alok_branch_111119_

## Changing the working copy ##
  * Alternatively instead of checking out the code if you already have a working copy, you can switch the working copy to look at the new branch as given below.
  * Since now the working copy has changed to "http://journal-distribution-system.googlecode.com/svn/branches/alok_branch_111119" from "http://journal-distribution-system.googlecode.com/svn/trunk" you need to update your working copy folder with the changes.
  * Right Click on folder journal-distribution-system>> TortoiseSVN >> Branch/ Tag.
  * Change the "To path:" to "/branches/alok\_branch\_111119". Check if the "Source URL" points to "http://journal-distribution-system.googlecode.com/svn/trunk". and the "Destination URL" points to "http://journal-distribution-system.googlecode.com/svn/branches/alok_branch_111119". Click on "OK".

## Keeping a Branch in sync ##
  * While you are developing code and not finished yet, other people may have completed their changes, reviewed their changes and merged them into the project's /trunk. It is better to frequently keep the feature branch in sync with the main development line on "/trunk" to prevent surprise conflicts when the time comes to merge your changes back into the trunk. Now we want to merge changed from the "/trunk" not "update changes into the working copy from the feature branch.
  * Check if your working copy has no local modifications and all the local modifications are committed to the feature branch.
  * Right-Click on "alok\_branch\_111119" >> TortoiseSVN >> Merge.
  * Select "Merge a range of revisions" >> Select URL to merge from as "https://journal-distribution-system.googlecode.com/svn/trunk" >> Ok.
  * Command Line option: Assuming that you are in the working directory, _svn merge https://journal-distribution-system.googlecode.com/svn/trunk_
  * After the working copy has synced withe trunk, check for the changes carefully with diff and then build and test your working copy.
  * Then Commit the changes to the feature branch.
  * Command Line option: Assuming that you are in the working directory, _svn commit -m "Give comment here"_

## Reintegrate the feature branch into the trunk ##
  * Once the feature is completed, review completed, then you need to merge the changes back into the trunk. The complete operation is as follows: Bring "working copy" upto date with "/trunk", Commit latest changes in "working copy" to "feature branch". Point the "working copy" to "/trunk". Merge changes from "feature branch" to "working copy". Commit changes from "working copy" to "/trunk".
  * Bring the working copy in sync with the "/trunk".
  * Commit changes to the "feature branch".
  * Change the working copy to point to "https://journal-distribution-system.googlecode.com/svn/trunk".
  * Right-click on "alok\_branch\_111119" >> TortoiseSVN  >> Merge.
  * Select "Reintegrate a branch" >> From URL "https://journal-distribution-system.googlecode.com/svn/branches/alok_branch_111119"
  * Always select "Test merge" before merging the code.
  * Command Line option: Assuming that you are in the working directory, _svn merge --reintegrate https://journal-distribution-system.googlecode.com/svn/branches/alok_branch_111119_
  * Commit the changes.
  * Command Line option: Assuming that you are in the working directory, _svn commit -m "Give comment here"._

## Removing the feature branch from the repository ##
  * Right Click on journal-distribution-system >> Repo-browser >> Select branch "alok\_branch\_111119" >> Right-click "Delete" >> Enter comment >> OK.
  * To check if the branch has been deleted, check "repo-browser" again.
  * Command Line option: Assuming that you are in the working directory, _svn delete https://journal-distribution-system.googlecode.com/svn/branches/alok_branch_111119 -m "Give comment here"_





