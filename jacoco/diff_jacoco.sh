#!/bin/bash

#source  ~/.bash_profile

PROJECT_BASE_PATH=${1:-$(pwd)}
BRANCH_A=${2:-"master"}
BRANCH_B=${3:-""}
echo "PROJECT_BASE_PATH:${PROJECT_BASE_PATH}"
echo "BRANCH_A:${BRANCH_A}"
echo "BRANCH_B:${BRANCH_B}"

JACOCO_CSV="target/site/jacoco/jacoco.csv"
JACOCO_DIFF="target/site/jacoco/jacoco.diff"
cd "${PROJECT_BASE_PATH}" || exit

#pwd
if command -v mvn
then
  mvn clean test jacoco:report
else
  echo "mvn 命令不存在，需要手动执行  mvn clean test jacoco:report"
fi
#
if  [ ! -e  "$JACOCO_CSV" ]
then
    echo "未生成jacoco测试报告"
    exit
fi

JACOCO_DIFF_CSV='target/jacoco_diff.csv'
if test -n "$BRANCH_B"
then
  git diff "$BRANCH_A" "$BRANCH_B"|grep '^diff'|grep '.java'|sed 's|/|.|g' >  $JACOCO_DIFF
  JACOCO_DIFF_CSV="target/${BRANCH_A}_${BRANCH_B}_diff.csv"
else
  git diff "$BRANCH_A" |grep '^diff'|grep '.java'|sed 's|/|.|g' >  $JACOCO_DIFF
  JACOCO_DIFF_CSV="target/${BRANCH_A}_current_diff.csv"
fi

awk '{print  $3}' < $JACOCO_DIFF


head -n 1 $JACOCO_CSV > "$JACOCO_DIFF_CSV"
while read -r line;
do
  name=$(echo "$line"|awk -F ','  '{print $2"."$3}');
#  echo "$name"
  if grep -q "$name" $JACOCO_DIFF; then
      echo  "$line"
      echo  "$line" >>   "$JACOCO_DIFF_CSV"
  fi

done < "$JACOCO_CSV"

echo "$(pwd)""/$JACOCO_DIFF_CSV"
