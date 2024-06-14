SCRIPTS_DIR="$1"

if [ -z "$1" ]; then
	SCRIPTS_DIR="$HOME/scripts"
fi

function remove_extension() {
	full=$1
	echo $(basename $full | cut -f1 -d ".")
}

for scriptName in $(ls $SCRIPTS_DIR); do
	name=$(remove_extension $scriptName)
	scriptPath="$SCRIPTS_DIR/$scriptName"

	if [ -f "$scriptPath" ]; then
		chmod 777 "$scriptPath"
		alias "$name"="$scriptPath"
	fi
done
