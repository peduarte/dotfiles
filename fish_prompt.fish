# disable shortening of path but keep replacement of $HOME with ~
set -g fish_prompt_pwd_dir_length 0

function _segment
	set_color $argv[1]
	echo -n -s $argv[2..-1] " "
	set_color normal
end

function _git_branch_name
	echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
	echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function _root_segment
	set -l uid (id -u $USER)
	if test $uid -eq 0
		_segment red "⚡︎"
	end
end

function _path_segment
	_segment cyan (prompt_pwd)
end

function _git_upstream_configured
	git rev-parse --abbrev-ref @"{upstream}" > /dev/null 2>&1
end

function _git_behind_upstream
	test (git rev-list --right-only --count HEAD...@"{u}" ^ /dev/null) -gt 0
end

function _git_ahead_of_upstream
	# test (git rev-list --left-only --count HEAD...@"{u}" ^ /dev/null) -gt 0
	test (command git log ^/dev/null | grep '^commit' | wc -l | tr -d " ") -gt 0
end

function _git_segment
	if test (_git_branch_name)
		set -l git_branch (_git_branch_name)
		_segment blue $git_branch

		if test (_is_git_dirty)
			_segment yellow "±"
		end
	end

	if _git_upstream_configured
		set -l git_status (command git rev-list --left-right --count 'HEAD...@{upstream}' | sed "s/[[:blank:]]/ /" ^/dev/null)

		# Resolve Git arrows by treating `git_status` as an array
		set -l git_arrow_left (command echo $git_status | cut -c 1 ^/dev/null)
		set -l git_arrow_right (command echo $git_status | cut -c 3 ^/dev/null)
		set -l git_arrows ""

		# If arrow is not "0", it means it's dirty
		if test $git_arrow_left -ne "0"
			set git_arrows "↑";
		end

		if test $git_arrow_right -ne "0"
			set git_arrows $git_arrows"↓"
		end

		_segment yellow $git_arrows
	end
end

function _prompt_segment
	if test $last_status = 0
		set_color green
	else
		set_color red
		echo -n $last_status
	end

	echo ""
	echo -n "❯ "
end

function fish_prompt
	set -g last_status $status

	echo "" 						# start with empty line
	_root_segment 					# display if we're root (sudo)
	_path_segment 					# display current path
	type -q git; and _git_segment 	# display git repo info
	_prompt_segment 				# display prompt

	set_color normal
end
