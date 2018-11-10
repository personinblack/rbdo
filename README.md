# rbdo: a simple todo app in cli

## commands

### .add

`./rbdo.rb add --text="netflix and chill" --date=28/01/2019 --time=18:03`

### .ls

`./rbdo.rb ls` or `./rbdo.rb ls --date=28/01/2019`

### .rm

`./rbdo.rb rm --index=5`

## arguments

### --text

text/content of the todo entry.

`./rbdo.rb add --text="netflix and chill"`

### --date

date of the todo entry. (year and month are optional)

`./rbdo.rb ls --date=28/01/2019`

### --time

time of the todo entry. (minute and second are optional)

`./rbdo.rb add --text=todo --time=18:03:08`

### --index

index of the todo entry required for the rm command.

`./rbdo.rb rm --index=5`
