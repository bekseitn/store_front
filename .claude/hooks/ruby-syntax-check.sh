#!/bin/bash
# PostToolUse hook: after Edit/Write touches a .rb file, check it still parses.
# Demo hook for learning Claude Code — see .claude/settings.json.

input="$(cat)"
file_path="$(echo "$input" | ruby -rjson -e 'print (JSON.parse(STDIN.read)["tool_input"]["file_path"] rescue "")')"

# Only care about Ruby files.
case "$file_path" in
  *.rb) ;;
  *) exit 0 ;;
esac

[ -f "$file_path" ] || exit 0

if ! error="$(ruby -c "$file_path" 2>&1 >/dev/null)"; then
  echo "Syntax check failed for $file_path:" >&2
  echo "$error" >&2
  exit 2
fi

exit 0
