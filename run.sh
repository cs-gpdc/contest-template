#!/bin/bash

# Author: Sagar Pathare (sspathare97)
# Created: 2023-04-01
# Created for CU Boulder CS-GPDC Coding Contests

COMMAND=$1;
PROBLEM_BASE="problem-$2";
TEST_CASE_BASE="$PROBLEM_BASE/test-cases"

# ./run.sh create 3
if [ "$COMMAND" = "create" ]; then
    mkdir -p "$TEST_CASE_BASE/input" && touch $_/.gitkeep
    mkdir -p "$TEST_CASE_BASE/output" && touch $_/.gitkeep
    mkdir -p "$PROBLEM_BASE/test-case-generator/out" && touch $_/.gitkeep $_/../.gitkeep
    mkdir -p "$PROBLEM_BASE/author-solutions/out" && touch $_/.gitkeep $_/../.gitkeep
    mkdir -p "$PROBLEM_BASE/tester-solutions/out" && touch $_/.gitkeep $_/../.gitkeep
    cp "statement-format.tex" "$PROBLEM_BASE/statement.tex"
    exit 0
fi

# ./run.sh zip 3
if [ "$COMMAND" = "zip" ]; then
    INPUT_FILES=$(ls "$TEST_CASE_BASE/input" | wc -l)
    OUTPUT_FILES=$(ls "$TEST_CASE_BASE/output" | wc -l)
    if [ ! $INPUT_FILES -eq $OUTPUT_FILES ]; then
        echo "Can't zip- input files count ($INPUT_FILES) does not match the output files count ($OUTPUT_FILES)"
    else
        cd $TEST_CASE_BASE
        zip -r "test-cases.zip" .
    fi
    exit 0
fi

# ./run.sh cases 3 0 8
if [ "$COMMAND" = "cases" ]; then
    START=$3;
    END=$4;
    for i in $(seq -f "%02g" $START $END); do
        TEST_CASE="$TEST_CASE_BASE/input/input${i}.txt"
        if [ ! -f $TEST_CASE ]; then
            touch $TEST_CASE
            echo "Created $TEST_CASE"
        else
            echo "Found $TEST_CASE"
        fi
    done
    exit 0
fi

FILE=$3;
START=$4;
END=$5;

# ./run.sh generator 3 m 0 8
if [ "$COMMAND" = "generator" ]; then
    PROGRAM_BASE="$PROBLEM_BASE/test-case-generator"
    PROGRAM="$PROGRAM_BASE/$FILE.cpp"
    g++ $PROGRAM -o "$PROGRAM_BASE/out/$FILE.out"
    echo "Compiled $PROGRAM"
    for i in $(seq -f "%02g" $START $END); do
        TEST_CASE="$TEST_CASE_BASE/input/input${i}.txt"
        "$PROGRAM_BASE/out/$FILE.out" > $TEST_CASE
        echo "Generated $TEST_CASE"
        sleep 1
    done
    exit 0
fi

# ./run.sh solution 3 m 0 8
if [ "$COMMAND" = "solution" ]; then
    PROGRAM_BASE="$PROBLEM_BASE/author-solutions"
    PROGRAM="$PROGRAM_BASE/$FILE.cpp"
    g++ $PROGRAM -o "$PROGRAM_BASE/out/$FILE.out"
    echo "Compiled $PROGRAM"
    for i in $(seq -f "%02g" $START $END); do
        INPUT="$TEST_CASE_BASE/input/input${i}.txt"
        OUTPUT="$TEST_CASE_BASE/output/output${i}.txt"
        "$PROGRAM_BASE/out/$FILE.out" < $INPUT > $OUTPUT
        echo "Generated $OUTPUT"
    done
    exit 0
fi

echo "Invalid command $1. Check README.md for usage"
