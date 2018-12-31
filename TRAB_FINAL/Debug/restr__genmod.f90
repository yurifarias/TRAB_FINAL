        !COMPILER-GENERATED INTERFACE MODULE: Mon Dec 31 19:40:46 2018
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE RESTR__genmod
          INTERFACE 
            SUBROUTINE RESTR(NNOS,REST,RIGG,MASG,AMOG,ESFG,CARM)
              INTEGER(KIND=4), INTENT(IN) :: NNOS
              LOGICAL(KIND=4), INTENT(IN) :: REST(3*NNOS)
              REAL(KIND=8) :: RIGG(3*NNOS,3*NNOS)
              REAL(KIND=8) :: MASG(3*NNOS,3*NNOS)
              REAL(KIND=8) :: AMOG(3*NNOS,3*NNOS)
              REAL(KIND=8) :: ESFG(3*NNOS)
              REAL(KIND=8) :: CARM(3*NNOS)
            END SUBROUTINE RESTR
          END INTERFACE 
        END MODULE RESTR__genmod
