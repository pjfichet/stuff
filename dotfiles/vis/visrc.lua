-- load standard vis module, providing parts of the Lua API
require('vis')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	-- vis:command('set number')
	--vis:command('set theme base16-atelier-cave')
	vis:command('set theme mine')
	vis:command('set tabwidth 4')
	vis:command('set cursorline')
	vis:command('set autoindent')
	vis:command('map! normal <C-h> <C-w>h')
	vis:command('map! normal <C-j> <C-w>j')
	vis:command('map! normal <C-k> <C-w>k')
	vis:command('map! normal <C-l> <C-w>l')
	-- vis:command('set colorcolumn 75')
	if win.file.name:find(".bashrc") then
		win:set_syntax("bash")
	end
	if win.file.name:find("pacman.log") then
		win:set_syntax("pacman")
	end
	if win.file.name:find(".tr") or win.file.name:find(".tmac") or win.file.name:find(".man") then
		win:set_syntax("troff")
	end
	if win.file.name:find(".tin") then
		win:set_syntax("tintin")
	end
if win.syntax == 'python' or win.syntax == 'rust' then
	 	local tabwidth = 4
	 	vis:command('set tabwidth ' .. tabwidth)
	 	vis:command('set expandtab')
	 	vis:map(vis.modes.INSERT, '<Backspace>', function()
		 	local found_tab = true
			for selection in vis.win:selections_iterator() do
				local pos = selection.pos
				if not pos or pos < tabwidth
				or vis.win.file:content(pos - tabwidth, tabwidth) ~= string.rep(' ', tabwidth)
				then
					found_tab = false
			 		break
				end
			end
			vis:feedkeys(string.rep('<vis-delete-char-prev>', found_tab and tabwidth or 1))
		end)
	end
end)

