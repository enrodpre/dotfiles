#!/usr/bin/zsh


function exclude() {
	test ${1%% *} = "reloadzsh" && return 1 || return 0
}
