        !COMPILER-GENERATED INTERFACE MODULE: Mon Dec 31 19:40:44 2018
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE MVDESL__genmod
          INTERFACE 
            SUBROUTINE MVDESL(NELE,NNOS,CELE,DESG,ROTS,DESL)
              INTEGER(KIND=4), INTENT(IN) :: NNOS
              INTEGER(KIND=4), INTENT(IN) :: NELE
              INTEGER(KIND=4), INTENT(IN) :: CELE(NELE,2)
              REAL(KIND=8), INTENT(IN) :: DESG(3*NNOS)
              REAL(KIND=8), INTENT(IN) :: ROTS(6,6,NELE)
              REAL(KIND=8), INTENT(OUT) :: DESL(6,NELE)
            END SUBROUTINE MVDESL
          END INTERFACE 
        END MODULE MVDESL__genmod
