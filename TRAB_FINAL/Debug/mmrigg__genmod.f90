        !COMPILER-GENERATED INTERFACE MODULE: Mon Dec 31 19:40:45 2018
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE MMRIGG__genmod
          INTERFACE 
            SUBROUTINE MMRIGG(NELE,NNOS,CELE,RIGS,ROTS,RIGG)
              INTEGER(KIND=4), INTENT(IN) :: NNOS
              INTEGER(KIND=4), INTENT(IN) :: NELE
              INTEGER(KIND=4) :: CELE(NELE,2)
              REAL(KIND=8), INTENT(IN) :: RIGS(6,6,NELE)
              REAL(KIND=8), INTENT(IN) :: ROTS(6,6,NELE)
              REAL(KIND=8), INTENT(OUT) :: RIGG(3*NNOS,3*NNOS)
            END SUBROUTINE MMRIGG
          END INTERFACE 
        END MODULE MMRIGG__genmod
