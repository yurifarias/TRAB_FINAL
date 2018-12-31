        !COMPILER-GENERATED INTERFACE MODULE: Mon Dec 31 19:40:44 2018
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE SPTRAN__genmod
          INTERFACE 
            SUBROUTINE SPTRAN(NNOS,RIGG,MASG,AMORT,CARM,DT)
              INTEGER(KIND=4), INTENT(IN) :: NNOS
              REAL(KIND=8), INTENT(IN) :: RIGG(3*NNOS,3*NNOS)
              REAL(KIND=8), INTENT(IN) :: MASG(3*NNOS,3*NNOS)
              REAL(KIND=8), INTENT(IN) :: AMORT(3*NNOS,3*NNOS)
              REAL(KIND=8) :: CARM(3*NNOS)
              REAL(KIND=8), INTENT(IN) :: DT
            END SUBROUTINE SPTRAN
          END INTERFACE 
        END MODULE SPTRAN__genmod
