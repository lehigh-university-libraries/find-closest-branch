When you have a local file that was cloned from a repository at some unknown point in the past, and then customized.  You now want to pull in upstream changes to the repo, but need to know which base version yours was originally cloned from.

This simple shell script iterates through the branches in the repository, and finds the one with a version of the file "closest" to the local copy.  "Closest" being very loosely defined by the number of lines changed in a diff.  The scrpit is inspired by https://stackoverflow.com/a/13733096
