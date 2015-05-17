## Project Development Methodology and source version control ##
  * Software has a typical lifecycle: code, test, release, repeat.

  * _Developers commit all new work to the trunk._ Day-to-day changes are committed to _/trunk_: new features, bugfixes, and so on.
  * The _trunk_ is copied to a _“release”_ branch. When the team thinks the software is ready for release (say, a 1.0 release), then _"/trunk"_ might be copied to _/branches/1.0_.
  * _Teams continue to work in parallel._ One team begins rigorous testing of the release branch, while another team continues new work (say, for version 2.0) on _"/trunk"_. If bugs are discovered in either location, fixes are ported back and forth as necessary. At some point, however, even that process stops. The branch is “frozen” for final testing right before a release.
  * _The branch is tagged and released_. When testing is complete, _"/branches/1.0"_ is copied to _"/tags/1.0.0"_ as a reference snapshot. The tag is packaged and released to customers.
  * The branch is maintained over time. While work continues on /trunk for version 2.0, bugfixes continue to be ported from /trunk to /branches/1.0. When enough bugfixes have accumulated, we may decide to do a 1.0.1 release: /branches/1.0 is copied to /tags/1.0.1, and the tag is packaged and released.
  * This entire process repeats as the software matures: when the 2.0 work is complete, a new 2.0 release branch is created, tested, tagged, and eventually released. After some years, the repository ends up with a number of release branches in “maintenance” mode, and a number of tags representing final shipped versions.

  * Version control as mentioned above separates the QA work and development work. New work continues as software is tested.
  * If a bug is discovered in the latest code, then it most likely exists in the released versions as well. This process will help to release to existing customers with the bugfix  without having to wait for a major new release.

  * Reference: http://svnbook.red-bean.com/en/1.2/svn.branchmerge.commonuses.html