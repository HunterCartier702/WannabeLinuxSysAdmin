#!/bin/bash

# Test output:
# echo ./backup/{January/{01..31},February/{01..28},March/{01..31},April/{01..30},May/{01..31},June/{01..30},July/{01..31},August/{01..31},September/{01..30},October/{01..31},November/{01..30},December/{01..31}}
# echo ./backup/{January/{01..31}/log.daily,February/{01..28}/log.daily,March/{01..31}/log.daily,April/{01..30}/log.daily,May/{01..31}/log.daily,June{01..30}/log.daily,July{01..31}/log.daily,August{01..31}/log.daily,September{01..30}/log.daily,October{01..31}/log.daily,November{01..30}/log.daily,December{01..31}/log.daily}

# Creates a directory with each month, day, and a file daily.log in each
# tree ./backup
#├── April
#│   ├── 01
#│      └── daily.log


for month in January February March April May June July August September October November December; do
    case $month in
        January|March|May|July|August|October|December) days=31;;
        April|June|September|November) days=30;;
        February) days=28;;  # Add leap year
    esac

    # -w adds padding
    for day in $(seq -w 1 $days); do
        mkdir -p "./backup/$month/$day"
        touch "./backup/$month/$day/daily.log"
    done
done

