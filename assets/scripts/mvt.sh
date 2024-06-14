from=$1
to=$2

if [ -e "$to" ]; then
  from=$2
  to=$1
fi

mv $from $to
