        !COMPILER-GENERATED INTERFACE MODULE: Mon Dec 31 19:40:45 2018
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE MMMASG__genmod
          INTERFACE 
            SUBROUTINE MMMASG(NELE,NNOS,CELE,MASL,ROTS,MASG)
              INTEGER(KIND=4), INTENT(IN) :: NNOS
              INTEGER(KIND=4), INTENT(IN) :: NELE
              INTEGER(KIND=4) :: CELE(NELE,2)
              REAL(KIND=8), INTENT(IN) :: MASL(6,6,NELE)
              REAL(KIND=8), INTENT(IN) :: ROTS(6,6,NELE)
              REAL(KIND=8), INTENT(OUT) :: MASG(3*NNOS,3*NNOS)
            END SUBROUTINE MMMASG
          END INTERFACE 
        END MODULE MMMASG__genmod
