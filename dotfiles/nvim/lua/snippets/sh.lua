local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

return {
	s("sd", {
		t({
			"declare -r sd=\"$(cd -- \"$( dirname -- \"${BASH_SOURCE[0]}\" )\" &> /dev/null && pwd)\""
		})
	}),
	s("issourced", {
		t({'is_sourced() {', ''}),
		t({'    if [ -n "$ZSH_VERSION" ]; then', ''}),
		t({'        case $ZSH_EVAL_CONTEXT in *:file:*) return 0;; esac', ''}),
		t({'    elif [ -n "$BASH_VERSION" ]; then', ''}),
		t({'        (return 0 2>/dev/null) && return 0 || return 1', ''}),
		t({'    else', ''}),
		t({'        [ "${BASH_SOURCE[0]}" != "$0" ]', ''}),
		t({'    fi', ''}),
		t({'}'})
	}),

	s("scriptdir", {
		t({'get_script_dir() {', ''}),
		t({'    local source="${BASH_SOURCE[0]}"', ''}),
		t({'    while [ -h "$source" ]; do', ''}),
		t({'        local dir="$( cd -P "$( dirname "$source" )" && pwd )"', ''}),
		t({'        source="$(readlink "$source")"', ''}),
		t({'        [[ $source != /* ]] && source="$dir/$source"', ''}),
		t({'    done', ''}),
		t({'    echo "$( cd -P "$( dirname "$source" )" && pwd )"', ''}),
		t({'}'})
	}),
	s("cmdexists", {
		t({'command_exists() {', ''}),
		t({'    command -v "$1" >/dev/null 2>&1', ''}),
		t({'}'})
	}),
	s("confirm", {
		t({'confirm() {', ''}),
		t({'    read -r -p "${1:-Are you sure? [y/N]} " response', ''}),
		t({'    case "$response" in', ''}),
		t({'        [yY][eE][sS]|[yY])', ''}),
		t({'            true', ''}),
		t({'            ;;', ''}),
		t({'        *)', ''}),
		t({'            false', ''}),
		t({'            ;;', ''}),
		t({'    esac', ''}),
		t({'}'})
	}),
	s("sourceusage", {
		t({'if ! is_sourced; then', ''}),
		t({'    echo "This script is being run directly"', ''}),
		t({'else', ''}),
		t({'    echo "This script is being sourced"', ''}),
		t({'fi'})
	})

}
