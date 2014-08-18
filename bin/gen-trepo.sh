#!/bin/bash

set -e
#set -x

# List of users
USER1_NAME="Karel Lysohlavka"
USER1_EMAIL="kal@houby.eu"

USER2_NAME="Josef Pepa Muchomurka"
USER2_EMAIL="josef.p.muchomurka@mushrooms.com"

USER3_NAME="Eva Bedlova Zajickova"
USER3_EMAIL="eva-zajickova@v-hribovem-lesiku.cz"

function echo_sep() {
	echo "==================================================================================="
}

function author() {
	FUNC="$1"
	DATE_STR="$2"
	export GIT_AUTHOR_DATE="${DATE_STR}"

	VAR_NAME="${FUNC}_NAME"
	eval GIT_AUTHOR_NAME=\$$VAR_NAME
	export GIT_AUTHOR_NAME

	VAR_EMAIL="${FUNC}_EMAIL"
	eval GIT_AUTHOR_EMAIL=\$$VAR_EMAIL
	export GIT_AUTHOR_EMAIL
}

function committer() {
	FUNC="$1"
	DATE_STR="$2"
	export GIT_COMMITTER_DATE="${DATE_STR}"

	VAR_NAME="${FUNC}_NAME"
	eval GIT_COMMITTER_NAME=\$$VAR_NAME
	export GIT_COMMITTER_NAME

	VAR_EMAIL="${FUNC}_EMAIL"
	eval GIT_COMMITTER_EMAIL=\$$VAR_EMAIL
	export GIT_COMMITTER_EMAIL
}

function do_commit() {
	MSG="$1"
	echo "Doing commit '$MSG'"
	git status
	git commit -m"$MSG"
	echo_sep
}


# --------------------------------------------------------------------
# Initialization

if [ -z "$1" ]; then
	REMOTE_GIT_URL='git@github.com:mj41/git-trepo.git'
else
	REMOTE_GIT_URL="$1"
fi

rm -rf git-trepo
mkdir git-trepo
cd git-trepo
git init
git remote add origin $REMOTE_GIT_URL

# --------------------------------------------------------------------
# Simple commit
# * one file in the root dir - two text lines
# * simple commit message - one line, no spaces
# * commiter and author are the same

MSG="commit_master_001"

echo "line 1 of fileR1.txt" >  fileR1.txt
echo "line 2 of fileR1.txt" >> fileR1.txt
git add fileR1.txt

author    USER1 '2006-07-21 22:23:24+0000'
committer USER1 '2006-07-21 22:25:26+0000'
do_commit "$MSG"

# --------------------------------------------------------------------
# * commit messaged with many lines
# * add lines to existing file
# * date timezones

MSG="Commit master 002

Commit description line 1
Commit description line 2
Commit description line 3

Commit description line 5
"

echo "line 3 of fileR1.txt" >> fileR1.txt
echo "line 4 of fileR1.txt" >> fileR1.txt
echo "line 5 of fileR1.txt" >> fileR1.txt
git add fileR1.txt

author    USER1 '2006-07-22 02:33:24+0200'
committer USER2 '2006-07-22 13:04:05+0300'
do_commit "$MSG"

# --------------------------------------------------------------------
# * remove/change lines

MSG="Commit master 003 - change file"

echo "line 1 of fileR1.txt" > fileR1.txt
echo ""                     >> fileR1.txt
echo "line 3 of fileR1.txt" >> fileR1.txt
git add fileR1.txt

author    USER1 '2006-07-23 02:33:24+0200'
committer USER2 '2006-07-23 13:04:05+0300'
do_commit "$MSG"

# --------------------------------------------------------------------
# * rm file

MSG="Commit master 004 - rm file"

git rm fileR1.txt

author    USER2 '2006-07-24 05:23:24+0000'
committer USER2 '2006-07-24 06:44:05+0000'
do_commit "$MSG"

# --------------------------------------------------------------------
MSG="Commit master 005

Change a few files."

mkdir dirA
echo "line 1 of dirA/fileA01.txt" >  dirA/fileA01.txt
echo "line 2 of dirA/fileA01.txt" >> dirA/fileA01.txt
echo "line 3 of dirA/fileA01.txt" >> dirA/fileA01.txt
git add dirA/fileA01.txt

mkdir dirB
mkdir dirB/s-dirX
echo "line 1 of dirB/s-dirX/fileBsX02.txt" >  dirB/s-dirX/fileBsX02.txt
echo "line 2 of dirB/s-dirX/fileBsX02.txt" >> dirB/s-dirX/fileBsX02.txt
echo "line 3 of dirB/s-dirX/fileBsX02.txt" >> dirB/s-dirX/fileBsX02.txt
echo "line 4 of dirB/s-dirX/fileBsX02.txt" >> dirB/s-dirX/fileBsX02.txt
echo "line 5 of dirB/s-dirX/fileBsX02.txt" >> dirB/s-dirX/fileBsX02.txt
git add dirB/s-dirX/fileBsX02.txt

mkdir dirB/s-dirY
echo "line 1 of dirB/s-dirY/fileBsY03.txt" >  dirB/s-dirY/fileBsY03.txt
echo "line 2 of dirB/s-dirY/fileBsY03.txt" >> dirB/s-dirY/fileBsY03.txt
echo "line 3 of dirB/s-dirY/fileBsY03.txt" >> dirB/s-dirY/fileBsY03.txt
echo ""                                    >> dirB/s-dirY/fileBsY03.txt
echo "line 5 of dirB/s-dirY/fileBsY03.txt" >> dirB/s-dirY/fileBsY03.txt
git add dirB/s-dirY/fileBsY03.txt

author    USER1 '2006-07-25 09:13:44+0000'
committer USER2 '2006-07-25 10:54:55+0000'
do_commit "$MSG"

# --------------------------------------------------------------------
MSG="Commit master 006"

echo "line 1 of dirA/fileA01.txt" > dirA/fileA01.txt
echo "-" >> dirA/fileA01.txt
echo "-" >> dirA/fileA01.txt
git add dirA/fileA01.txt

echo "line 6 of dirB/s-dirX/fileBsX02.txt" >>  dirB/s-dirX/fileBsX02.txt
echo "-" >> dirB/s-dirX/fileBsX02.txt
echo "-" >> dirB/s-dirX/fileBsX02.txt
echo "-" >> dirB/s-dirX/fileBsX02.txt
echo "line 9 of dirB/s-dirX/fileBsX02.txt" >> dirB/s-dirX/fileBsX02.txt
git add dirB/s-dirX/fileBsX02.txt

echo "" >  dirB/s-dirY/fileBsY03.txt
echo "line 2 of dirB/s-dirY/fileBsY03.txt" >> dirB/s-dirY/fileBsY03.txt
git add dirB/s-dirY/fileBsY03.txt

author    USER2 '2006-07-26 03:23:24+0000'
committer USER2 '2006-07-26 05:44:05+0000'
do_commit "$MSG"

# --------------------------------------------------------------------
# * rm file

MSG="Commit master 007"

git rm dirA/fileA01.txt
git rm dirB/s-dirX/fileBsX02.txt

author    USER1 '2006-07-27 23:23:24+0000'
committer USER1 '2006-07-27 23:44:05+0000'
do_commit "$MSG"

# --------------------------------------------------------------------
# * mv file

MSG="Commit master 008 - mv"

mkdir dirA
git mv dirB/s-dirY/fileBsY03.txt dirA/fileA04-BsY03.txt

author    USER3 '2006-07-28 03:35:41+0000'
committer USER3 '2006-07-28 03:43:26+0000'
do_commit "$MSG"

# --------------------------------------------------------------------
# * branch br1,

MSG="Commit br1 009"

git checkout -b br1 HEAD

echo "line 1 of fl-br1.txt" >  fl-br1.txt
echo "line 2 of fl-br1.txt" >> fl-br1.txt
git add fl-br1.txt

author    USER3 '2006-07-29 04:22:11+0000'
committer USER3 '2006-07-29 04:55:56+0000'
do_commit "$MSG"

# --------------------------------------------------------------------
# Done
echo_sep
echo "Done - see log:"
echo

git log --pretty=fuller --date-order --reverse --decorat=full --stat --summary

# git push -u origin master --force

cd ..
