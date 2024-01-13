module hwm

    integer(4)           :: nmaxhwm = 0        ! maximum degree hwmqt
    integer(4)           :: omaxhwm = 0        ! maximum order hwmqt
    integer(4)           :: nmaxdwm = 0        ! maximum degree hwmqt
    integer(4)           :: mmaxdwm = 0        ! maximum order hwmqt
    integer(4)           :: nmaxqdc = 0        ! maximum degree of coordinate coversion
    integer(4)           :: mmaxqdc = 0        ! maximum order of coordinate coversion
    integer(4)           :: nmaxgeo = 0        ! maximum of nmaxhwm, nmaxqd
    integer(4)           :: mmaxgeo = 0        ! maximum of omaxhwm, nmaxqd

    real(8),allocatable  :: gpbar(:,:),gvbar(:,:),gwbar(:,:) ! alfs for geo coordinates
    real(8),allocatable  :: spbar(:,:),svbar(:,:),swbar(:,:) ! alfs MLT calculation

    real(8)              :: glatalf = -1.d32

    logical              :: hwminit = .true.

end module hwm
