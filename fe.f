! very basic ed clone
! sort of works -- use at your own risk
program fed
        implicit none
        character(len=512) :: arg

	logical :: exist

	character(4000) :: buf
        character(2048) :: content

	character :: cmd, cmd2
	integer :: i
	integer :: sz = 0
	
	content = ""	

	call GET_COMMAND_ARGUMENT(1,arg)

	inquire(file=arg, exist=exist)
        if (exist) then
        	write(*,*) trim(arg) 
        else                 
                write(*,*) "?", trim(arg)
        end if

	buf = ""        

	do 
	read *, cmd
		select case(cmd)
			case('a')
                                read (*,'(A)') content
				write(buf,*) "", trim(content)
			case('w')
				!! there's probably a better way to do this... 
				inquire(file=arg, exist=exist)
        			if (exist) then
                			open(11, file=arg, status="old", position="append", action="write")
        				inquire(11, size=sz)
					write(11,*) trim(buf)
					print '(i9, "bytes")',sz
					close(11)
				else
                			open(12, file=arg, status="new", action="write")
					inquire(12, size=sz)
                                        write(12,*) trim(buf)
					print '(i9, "bytes")',sz
					close(12)
        			end if
			case('p')
				print *, trim(buf)
			case('q')
				exit
			case('h')
				print *, "usage: fed <file>"
				print *, "a to append - must use after each newline"
				print *, "p to print"
				print *, "w to write - must use after each append"
			case default
				print *, '?'
                end select
	end do
end program fed

