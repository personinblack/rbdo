# rbdo: a simple todo app in cli

[![Gem Version](https://badge.fury.io/rb/rbdo.svg)](https://rubygems.org/gems/rbdo)

## commands

### .add

`rbdo add --text="netflix and chill" --date=28/01/2019 --time=18:03`

### .ls

`rbdo ls`

### .rm

`rbdo rm --index=5`

## arguments

### --text

text/content of the todo entry.

`rbdo add --text="netflix and chill"`

### --date

date of the todo entry. (year and month are optional)

`rbdo ls --date=28/01/2019`

### --time

time of the todo entry. (minute and second are optional)

`rbdo add --text=todo --time=18:03:08`

### --index

index of the todo entry required for the rm command.

`rbdo rm --index=5`
