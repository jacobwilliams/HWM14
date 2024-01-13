module dwm

    implicit none

    integer(4)                 :: nterm             ! Number of terms in the model
    integer(4)                 :: nmax,mmax         ! Max latitudinal degree
    integer(4)                 :: nvshterm          ! # of VSH basis functions

    integer(4),allocatable     :: termarr(:,:)      ! 3 x nterm index of coupled terms
    real(4),allocatable        :: coeff(:)          ! Model coefficients
    real(4),allocatable        :: vshterms(:,:)     ! VSH basis values
    real(4),allocatable        :: termval(:,:)      ! Term values to which coefficients are applied
    real(8),allocatable        :: dpbar(:,:)        ! Associated lengendre fns
    real(8),allocatable        :: dvbar(:,:)
    real(8),allocatable        :: dwbar(:,:)
    real(8),allocatable        :: mltterms(:,:)     ! MLT Fourier terms
    real(4)                    :: twidth            ! Transition width of high-lat mask

    real(8), parameter         :: pi=3.1415926535897932
    real(8), parameter         :: dtor=pi/180.d0

    logical                    :: dwminit = .true.
    character(128), parameter  :: dwmdefault = 'dwm07b104i.dat'

end module dwm
