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
		_segment red "◇"
	end
end

function _path_segment
	_segment magenta (prompt_pwd)
end

function _git_upstream_configured
	git rev-parse --abbrev-ref @"{u}" > /dev/null 2>&1
end

function _git_behind_upstream
	test (git rev-list --right-only --count HEAD...@"{u}" ^ /dev/null) -gt 0
end

function _git_ahead_of_upstream
	test (git rev-list --left-only --count HEAD...@"{u}" ^ /dev/null) -gt 0
end

function _git_segment
	if test (_git_branch_name)
		set -l git_branch (_git_branch_name)
		_segment white $git_branch

		if test (_is_git_dirty)
			_segment yellow "☉"
		end
	end

	if _git_upstream_configured
		if _git_behind_upstream
			_segment yellow "▽"
		end

		if _git_ahead_of_upstream
			_segment yellow "△"
		end
	end
end

function _prompt_segment
	if test $last_status = 0
		set_color green
	else
		set_color red
	end

	echo ""
	echo -n "▷ "
	echo -n " "
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
