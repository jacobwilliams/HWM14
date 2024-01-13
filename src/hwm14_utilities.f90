module hwm14_utilities

    implicit none

    private

    public :: findandopen

    contains

subroutine findandopen(datafile,unitid)
    !! Utility to find and open the supporting data files

    implicit none

    character(128)      :: datafile
    integer             :: unitid
    character(128)      :: hwmpath
    logical             :: havefile
    integer             :: i

    i = index(datafile,'bin')
    if (i .eq. 0) then
        inquire(file=trim(datafile),exist=havefile)
        if (havefile) open(unit=unitid,file=trim(datafile),status='old',form='unformatted')
        if (.not. havefile) then
            call get_environment_variable('HWMPATH',hwmpath)
            inquire(file=trim(hwmpath)//'/'//trim(datafile),exist=havefile)
            if (havefile) open(unit=unitid, &
                file=trim(hwmpath)//'/'//trim(datafile),status='old',form='unformatted')
        endif
        if (.not. havefile) then
            inquire(file='../Meta/'//trim(datafile),exist=havefile)
            if (havefile) open(unit=unitid, &
                file='../Meta/'//trim(datafile),status='old',form='unformatted')
        endif
    else
        inquire(file=trim(datafile),exist=havefile)
        if (havefile) open(unit=unitid,file=trim(datafile),status='old',access='stream')
        if (.not. havefile) then
            call get_environment_variable('HWMPATH',hwmpath)
            inquire(file=trim(hwmpath)//'/'//trim(datafile),exist=havefile)
            if (havefile) open(unit=unitid, &
                file=trim(hwmpath)//'/'//trim(datafile),status='old',access='stream')
        endif
        if (.not. havefile) then
            inquire(file='../Meta/'//trim(datafile),exist=havefile)
            if (havefile) open(unit=unitid, &
                file='../Meta/'//trim(datafile),status='old',access='stream')
        endif
    endif

    if (havefile) then
        return
    else
        print *,"Can not find file ",trim(datafile)
        stop
    endif

end subroutine findandopen

end module hwm14_utilities