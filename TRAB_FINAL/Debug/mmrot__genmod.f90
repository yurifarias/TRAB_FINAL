        !COMPILER-GENERATED INTERFACE MODULE: Mon Dec 31 19:40:46 2018
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE MMROT__genmod
          INTERFACE 
            SUBROUTINE MMROT(NELE,NNOS,CELE,CNOS,ROTS)
              INTEGER(KIND=4), INTENT(IN) :: NNOS
              INTEGER(KIND=4), INTENT(IN) :: NELE
              INTEGER(KIND=4), INTENT(IN) :: CELE(NELE,2)
              REAL(KIND=8), INTENT(IN) :: CNOS(NNOS,2)
              REAL(KIND=8), INTENT(OUT) :: ROTS(6,6,NELE)
            END SUBROUTINE MMROT
          END INTERFACE 
        END MODULE MMROT__genmod
