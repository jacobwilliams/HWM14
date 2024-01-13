module qwm

    !! Model Module

    implicit none

    integer(4)                 :: nbf              ! Count of basis terms per model level
    integer(4)                 :: maxn             ! latitude
    integer(4)                 :: maxs,maxm,maxl   ! seasonal,stationary,migrating
    integer(4)                 :: maxo

    integer(4)                 :: p                ! B-splines order, p=4 cubic, p=3 quadratic
    integer(4)                 :: nlev             ! e.g. Number of B-spline nodes
    integer(4)                 :: nnode            ! nlev + p

    real(8)                    :: alttns           ! Transition 1
    real(8)                    :: altsym           ! Transition 2
    real(8)                    :: altiso           ! Constant Limit
    real(8)                    :: e1(0:4)
    real(8)                    :: e2(0:4)
    real(8),parameter          :: H = 60.0d0

    integer(4),allocatable     :: nb(:)            ! total number of basis functions @ level
    integer(4),allocatable     :: order(:,:)       ! spectral content @ level
    real(8),allocatable        :: vnode(:)         ! Vertical Altitude Nodes
    real(8),allocatable        :: mparm(:,:)       ! Model Parameters
    real(8),allocatable        :: tparm(:,:)       ! Model Parameters

    real(8)                    :: previous(1:5) = -1.0d32
    integer(4)                 :: priornb = 0

    real(8),allocatable        :: fs(:,:),fm(:,:),fl(:,:)
    real(8),allocatable        :: bz(:),bm(:)

    real(8),allocatable        :: zwght(:)
    integer(4)                 :: lev

    integer(4)                 :: cseason = 0
    integer(4)                 :: cwave = 0
    integer(4)                 :: ctide = 0

    logical                    :: content(5) = .true.          ! Season/Waves/Tides
    logical                    :: component(0:1) = .true.      ! Compute zonal/meridional

    character(128)             :: qwmdefault = 'hwm123114.bin'
    logical                    :: qwminit = .true.

    real(8)                    :: wavefactor(4) = 1.0
    real(8)                    :: tidefactor(4) = 1.0

end module qwm
