
export PATH="/home/phil/opt/cassandra/bin:/home/phil/opt/hadoop/bin:/home/phil/opt/hadoop/sbin:/home/phil/.bin:/home/phil/bin:/home/phil/opt/bin:/home/phil/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/phil/.git-shell-scripts.git:/home/phil/opt/android/platform-tools:/home/phil/opt/android/tools"



export CS_HOME=/home/phil/opt/cloud-search-tools
export PATH=$PATH:$CS_HOME/bin

if [ -z "$JAVA_HOME" ]; then
    export JAVA_HOME="/etc/alternatives/java_sdk"
fi
