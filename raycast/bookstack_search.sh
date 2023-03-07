#!/usr/bin/env sh
#
# @raycast.schemaVersion 1
# @raycast.title BookStack Search
# @raycast.packageName bookstack.internal.aleemhaji.com
# @raycast.mode silent
# @raycast.icon https://bookstack.internal.aleemhaji.com/favicon.ico
# @raycast.argument1 { "type": "text", "placeholder": "Query" }
#
open -a "Google Chrome.app" -n --args --app="https://bookstack.internal.aleemhaji.com/search?term=$1"
