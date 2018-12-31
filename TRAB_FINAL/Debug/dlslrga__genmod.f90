        !COMPILER-GENERATED INTERFACE MODULE: Mon Dec 31 19:40:45 2018
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE DLSLRGA__genmod
          INTERFACE 
            SUBROUTINE DLSLRGA(NM,NR,H,FS,IAT,FA)
              INTEGER(KIND=4) :: NR
              INTEGER(KIND=4) :: NM
              REAL(KIND=8) :: H(NR,NR)
              REAL(KIND=8) :: FS(NR)
              INTEGER(KIND=4) :: IAT
              REAL(KIND=8) :: FA(NR)
            END SUBROUTINE DLSLRGA
          END INTERFACE 
        END MODULE DLSLRGA__genmod
