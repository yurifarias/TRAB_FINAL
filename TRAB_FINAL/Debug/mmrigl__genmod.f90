        !COMPILER-GENERATED INTERFACE MODULE: Mon Dec 31 19:40:44 2018
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE MMRIGL__genmod
          INTERFACE 
            SUBROUTINE MMRIGL(NELE,NNOS,CELE,CNOS,LAR,ALT,MEL,RIGS)
              INTEGER(KIND=4), INTENT(IN) :: NNOS
              INTEGER(KIND=4), INTENT(IN) :: NELE
              INTEGER(KIND=4), INTENT(IN) :: CELE(NELE,2)
              REAL(KIND=8), INTENT(IN) :: CNOS(NNOS,2)
              REAL(KIND=8), INTENT(IN) :: LAR(NELE)
              REAL(KIND=8), INTENT(IN) :: ALT(NELE)
              REAL(KIND=8), INTENT(IN) :: MEL(NELE)
              REAL(KIND=8), INTENT(OUT) :: RIGS(6,6,NELE)
            END SUBROUTINE MMRIGL
          END INTERFACE 
        END MODULE MMRIGL__genmod
