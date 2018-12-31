        !COMPILER-GENERATED INTERFACE MODULE: Mon Dec 31 19:40:46 2018
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE MMMASL__genmod
          INTERFACE 
            SUBROUTINE MMMASL(NELE,NNOS,CELE,CNOS,LAR,ALT,MESP,TIPO,MASL&
     &)
              INTEGER(KIND=4), INTENT(IN) :: NNOS
              INTEGER(KIND=4), INTENT(IN) :: NELE
              INTEGER(KIND=4), INTENT(IN) :: CELE(NELE,2)
              REAL(KIND=8), INTENT(IN) :: CNOS(NNOS,2)
              REAL(KIND=8), INTENT(IN) :: LAR(NELE)
              REAL(KIND=8), INTENT(IN) :: ALT(NELE)
              REAL(KIND=8), INTENT(IN) :: MESP(NELE)
              CHARACTER(LEN=1), INTENT(IN) :: TIPO
              REAL(KIND=8), INTENT(OUT) :: MASL(6,6,NELE)
            END SUBROUTINE MMMASL
          END INTERFACE 
        END MODULE MMMASL__genmod
