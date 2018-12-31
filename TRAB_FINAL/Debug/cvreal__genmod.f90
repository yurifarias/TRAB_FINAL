        !COMPILER-GENERATED INTERFACE MODULE: Mon Dec 31 19:40:44 2018
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE CVREAL__genmod
          INTERFACE 
            SUBROUTINE CVREAL(NELE,NNOS,CELE,ESFL,DESL,RIGS,REAC)
              INTEGER(KIND=4), INTENT(IN) :: NELE
              INTEGER(KIND=4), INTENT(IN) :: NNOS
              INTEGER(KIND=4), INTENT(IN) :: CELE(NELE,2)
              REAL(KIND=8), INTENT(IN) :: ESFL(6,NELE)
              REAL(KIND=8), INTENT(IN) :: DESL(6,NELE)
              REAL(KIND=8), INTENT(IN) :: RIGS(6,6,NELE)
              REAL(KIND=8), INTENT(OUT) :: REAC(6,NELE)
            END SUBROUTINE CVREAL
          END INTERFACE 
        END MODULE CVREAL__genmod
