
module gd2qdc
    !!  Geographic <=> Geomagnetic Coordinate Transformations
    !!
    !!  Converts geodetic coordinates to Quasi-Dipole coordinates (Richmond, J. Geomag.
    !!  Geoelec., 1995, p. 191), using a spherical harmonic representation.

    implicit none

    integer(4)               :: nterm, nmax, mmax  !Spherical harmonic expansion parameters

    real(8), allocatable     :: coeff(:,:)         !Coefficients for spherical harmonic expansion
    real(8), allocatable     :: xcoeff(:)          !Coefficients for x coordinate
    real(8), allocatable     :: ycoeff(:)          !Coefficients for y coordinate
    real(8), allocatable     :: zcoeff(:)          !Coefficients for z coordinate
    real(8), allocatable     :: sh(:)              !Array to hold spherical harmonic fuctions
    real(8), allocatable     :: shgradtheta(:)     !Array to hold spherical harmonic gradients
    real(8), allocatable     :: shgradphi(:)       !Array to hold spherical harmonic gradients
    real(8), allocatable     :: normadj(:)         !Adjustment to VSH normalization factor
    real(4)                  :: epoch, alt

    real(8), parameter       :: pi = 3.1415926535897932d0
    real(8), parameter       :: dtor = pi/180.0d0
    real(8), parameter       :: sineps = 0.39781868d0

    logical                  :: gd2qdinit = .true.

contains

    subroutine initgd2qd()

        use hwm
        use hwm14_utilities, only: findandopen
        implicit none

        character(128), parameter   :: datafile='gd2qd.dat'
        integer(4)                  :: iterm, n
        integer(4)                  :: j

        call findandopen(datafile,23)
        read(23) nmax, mmax, nterm, epoch, alt
        if (allocated(coeff)) then
            deallocate(coeff,xcoeff,ycoeff,zcoeff,sh,shgradtheta,shgradphi,normadj)
        endif
        allocate( coeff(0:nterm-1, 0:2) )
        read(23) coeff
        close(23)

        allocate( xcoeff(0:nterm-1) )
        allocate( ycoeff(0:nterm-1) )
        allocate( zcoeff(0:nterm-1) )
        allocate( sh(0:nterm-1) )
        allocate( shgradtheta(0:nterm-1) )
        allocate( shgradphi(0:nterm-1) )
        allocate( normadj(0:nmax) )

        do iterm = 0, nterm-1
            xcoeff(iterm) = coeff(iterm,0)
            ycoeff(iterm) = coeff(iterm,1)
            zcoeff(iterm) = coeff(iterm,2)
        enddo

        do n = 0, nmax
            normadj(n) = dsqrt(dble(n*(n+1)))
        end do

        nmaxqdc = nmax
        mmaxqdc = mmax

        gd2qdinit = .false.

        return

    end subroutine initgd2qd

end module gd2qdc

