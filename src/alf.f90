
module alf
    !! Portable utility to compute vector spherical harmonical harmonic basis functions

    implicit none

    integer(4)              :: nmax0,mmax0

    ! static normalizational coeffiecents

    real(8), allocatable    :: anm(:,:),bnm(:,:),dnm(:,:)
    real(8), allocatable    :: cm(:),en(:)
    real(8), allocatable    :: marr(:),narr(:)

contains

subroutine alfbasis(nmax,mmax,theta,P,V,W)
    !! routine to compute vector spherical harmonic basis functions

        integer(4), intent(in)  :: nmax, mmax
        real(8), intent(in)     :: theta
        real(8), intent(out)    :: P(0:nmax,0:mmax)
        real(8), intent(out)    :: V(0:nmax,0:mmax)
        real(8), intent(out)    :: W(0:nmax,0:mmax)

        integer(8)              :: n, m
        real(8)                 :: x, y
        real(8), parameter      :: p00 = 0.70710678118654746d0

        P(0,0) = p00
        x = cos(theta)
        y = sin(theta)
        do m = 1, mmax
            W(m,m) = cm(m) * P(m-1,m-1)
            P(m,m) = y * en(m) * W(m,m)
            do n = m+1, nmax
                W(n,m) = anm(n,m) * x * W(n-1,m) - bnm(n,m) * W(n-2,m)
                P(n,m) = y * en(n) * W(n,m)
                V(n,m) = narr(n) * x * W(n,m) - dnm(n,m) * W(n-1,m)
                W(n-2,m) = marr(m) * W(n-2,m)
            enddo
            W(nmax-1,m) = marr(m) * W(nmax-1,m)
            W(nmax,m) = marr(m) * W(nmax,m)
            V(m,m) = x * W(m,m)
        enddo
        P(1,0) = anm(1,0) * x * P(0,0)
        V(1,0) = -P(1,1)
        do n = 2, nmax
            P(n,0) = anm(n,0) * x * P(n-1,0) - bnm(n,0) * P(n-2,0)
            V(n,0) = -P(n,1)
        enddo

        return

    end subroutine alfbasis

    ! -----------------------------------------------------
    ! routine to compute static normalization coeffiecents
    ! -----------------------------------------------------

    subroutine initalf(nmaxin,mmaxin)

        implicit none

        integer(4), intent(in) :: nmaxin, mmaxin
        integer(8)             :: n, m   ! 64 bits to avoid overflow for (m,n) > 60

        nmax0 = nmaxin
        mmax0 = mmaxin

        if (allocated(anm)) deallocate(anm, bnm, cm, dnm, en, marr, narr)
        allocate( anm(0:nmax0, 0:mmax0) )
        allocate( bnm(0:nmax0, 0:mmax0) )
        allocate( cm(0:mmax0) )
        allocate( dnm(0:nmax0, 0:mmax0) )
        allocate( en(0:nmax0) )
        allocate( marr(0:mmax0) )
        allocate( narr(0:nmax0) )

        do n = 1, nmax0
            narr(n) = dble(n)
            en(n)    = dsqrt(dble(n*(n+1)))
            anm(n,0) = dsqrt( dble((2*n-1)*(2*n+1)) ) / narr(n)
            bnm(n,0) = dsqrt( dble((2*n+1)*(n-1)*(n-1)) / dble(2*n-3) ) / narr(n)
        end do
        do m = 1, mmax0
            marr(m) = dble(m)
            cm(m)    = dsqrt(dble(2*m+1)/dble(2*m*m*(m+1)))
            do n = m+1, nmax0
                anm(n,m) = dsqrt( dble((2*n-1)*(2*n+1)*(n-1)) / dble((n-m)*(n+m)*(n+1)) )
                bnm(n,m) = dsqrt( dble((2*n+1)*(n+m-1)*(n-m-1)*(n-2)*(n-1)) &
                    / dble((n-m)*(n+m)*(2*n-3)*n*(n+1)) )
                dnm(n,m) = dsqrt( dble((n-m)*(n+m)*(2*n+1)*(n-1)) / dble((2*n-1)*(n+1)) )
            end do
        enddo

        return

    end subroutine initalf

end module alf
