let s:db = "sqlite3 ./file.db"


function New(var1)
	if var1 == "object"
		execute "normal! Iinsert into Object (name) values '';"
	endif
endfunction

function Fix(var1, var2)
	if var1 == "object"
		read ! s:db "select printf('\
update Object set name = %s where id = var2;', \
(select quote(name) from Object where id = 1) );"
	endif
endfunction

function Put()
 	" pipe buffer in database
	write ! s:db
	" delete buffer
	1,$delete
endfunction

