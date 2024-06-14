file_type=""
regex=".*"
exclude_dirs=()
listFiles=0
showCommand=0
wcArgs="-l"

while getopts ":t:r:e:fca:" opt; do
  case ${opt} in
    t )
      file_type="${OPTARG}";
      ;;
    r )
      regex="${OPTARG}"
      ;;
    e )
      read -r -a exclude_dirs <<< "$OPTARG";
      ;;
    f )
      listFiles=1;
      ;;
    c )
      showCommand=1;
      ;;
    a )
      wcArgs="${OPTARG}"
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
  esac
done
shift $((OPTIND -1))

# Construindo a expressão de exclusão
exclude_expression=""
for dir in "${exclude_dirs[@]}"; do
  exclude_expression+=" -not -path \"*/$dir/*\" "
done

grp=""

if [ "$listFiles" -eq 1 ]; then 
  grp="| grep total"
fi

# Utilizando a expressão de exclusão na busca
cmd="find -regex '$regex' -type f -name \"*.$file_type\" $exclude_expression | xargs wc $wcArgs"

if [ "$listFiles" -eq 1 ]; then 
  eval $cmd
else
  eval $cmd | grep "total"
fi

if [ "$showCommand" -eq 1 ]; then
  echo $cmd
fi
