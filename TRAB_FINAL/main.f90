PROGRAM trabalhofinal
    IMPLICIT NONE

    ! Vari�veis de entrada de dados
    INTEGER, PARAMETER :: f1 = 10, f2 = 11, f3 =12
    CHARACTER(len=50) :: titulo
    INTEGER :: num_elem, num_nos, i, j
    INTEGER, DIMENSION(:,:), ALLOCATABLE :: conf_ele
    REAL(kind=8) :: tmovel_inicial, tmovel_final, a_0, a_1
    REAL(kind=8), DIMENSION(:,:), ALLOCATABLE :: conf_nos, car_elem
    REAL(kind=8), DIMENSION(:), ALLOCATABLE :: car_noda, mod_elas, mas_espe, larg, altu, carg_mov
    LOGICAL, DIMENSION(:), ALLOCATABLE :: res_noda
    CHARACTER(len=1) :: tipo_mas, movel, amort

    ! Vari�veis de processamento de dados
    CHARACTER(len=20) :: form
    CHARACTER(len=100) :: file_var
    INTEGER :: fvar = 1000 ! arquivo que vai variar de n�mero
    REAL(kind=8), DIMENSION(:,:,:), ALLOCATABLE :: rigs_loc, mass_loc, mrot
    REAL(kind=8), DIMENSION(:,:), ALLOCATABLE :: esfo_loc, rig_estr, desl_loc, reac_loc, mas_estr, amo_estr
    REAL(kind=8), DIMENSION(:), ALLOCATABLE :: esfo_glo, desl_glo, freq
    INTEGER, DIMENSION(:), ALLOCATABLE :: vaux
    REAL(kind=8) :: delta_t


    ! f1: unit do arquivo de entrada 'entrada.txt'
    ! f2: unit do arquivo de sa�da 'saida.txt'
    ! titulo: vari�vel que armazena o t�tulo do trabalho
    ! num_elem: vari�vel que armazena n�mero de elementos
    ! num_nos: vari�vel que armazena n�mero de n�s
    ! i: vari�vel para iterar
    ! j: vari�vel para iterar
    ! conf_ele: matriz que armazena �ndices dos n�s iniciais e finais de cada elemento [n�i,n�f]
    ! conf_nos: posi��es x e y de cada n� [pos_x,pos_y]
    ! car_elem: matriz que armazena carregamentos locais de cada elemento em kN/m [Nli,Nlf,Qli,Qlf]
    ! car_noda: vetor que armazena cargas nodais em kN/kNm
    ! carg_mov: vetor que armazena cargas m�veis nodais em kN/kNm
    ! mod_elas: vetor que armazena m�dulo de elasticidade de cada elemento em MPa
    ! larg: vetor que armazena largura de cada elemento em metros
    ! altu: vetor que armazena altura de cada elemento em metros
    ! res_noda: vetor que armazena restri��es em cada n� em TRUE/FALSE

    ! form: vari�vel para armazenar formats vari�veis
    ! rigs_loc: matriz 3D que armazena matriz de rigidez local de cada elemento [6,6,num_elem]
    ! mrot: matriz 3D que armazena matriz de rota��o de cada elemento [6,6,num_elem]
    ! esfo_loc: matriz 2D que armazena vetor de esfor�o local em cada elemento [6,num_elem]
    ! rig_estr: matriz de rigidez global da estrutura [3*num_nos,3*num_nos]
    ! mas_estr: matriz de massa global da estrutura [3*num_nos,3*num_nos]
    ! esfo_glo: vetor de esfor�os globais na estrutura {3*num_nos}
    ! desl_glo: vetor de deslocamentos globais na estrutura {3*num_nos}
    ! amo_estr: matriz de amortecimento da estrutura [3*num_nos,3*num_nos]

    ! IN�CIO DE ROTINAS PARA LEITURA DOS DADOS DE ENTRADA

    ! Rotina para abrir arquivos de entrada e de sa�da
    OPEN(f1,file='entrada.txt')

    ! Rotina para pegar t�tulo do trabalho
    READ(f1, '(a)') titulo      ! Linha 01
    WRITE(f2, '(a)') titulo

    ! Rotina para pegar n�mero de elementos
    READ(f1, *)                 ! Linha 02
    READ(f1, *)                 ! Linha 03
    READ(f1, *) num_elem        ! Linha 04

    ! Rotina para alocar matrizes
    ALLOCATE(conf_ele(num_elem, 2))         ! [n�i, n�f]
    ALLOCATE(car_elem(num_elem, 4))         ! [Nli, Nlf, Qli, Qlf]
    ALLOCATE(mod_elas(num_elem))
    ALLOCATE(mas_espe(num_elem))
    ALLOCATE(larg(num_elem))
    ALLOCATE(altu(num_elem))

    ! Rotina para pegar dados dos elementos
    READ(f1, *)                 ! Linha 05
    READ(f1, *)                 ! Linha 06
    READ(f1, *)                 ! Linha 07
    DO i=1, num_elem
        READ(f1, *) j, conf_ele(j,1), conf_ele(j,2), mod_elas(j), mas_espe(j), larg(j), &
                & altu(j), car_elem(j,1), car_elem(j,2), car_elem(j,3), car_elem(j,4)
    END DO                      ! Linha 08 a 07 + num_elem

    ! Rotina para pegar n�mero de n�s
    READ(f1, *)                 ! Linha 08 + num_elem
    READ(f1, *)                 ! Linha 09 + num_elem
    READ(f1, *) num_nos         ! Linha 10 + num_elem

    ! Rotina para alocar matrizes
    ALLOCATE(conf_nos(num_nos,2))
    ALLOCATE(car_noda(3*num_nos))
    ALLOCATE(carg_mov(3*num_nos))
    ALLOCATE(res_noda(3*num_nos))

    ! Rotina para pegar dados dos n�s
    READ(f1, *)                 ! Linha 11 + num_elem
    READ(f1, *)                 ! Linha 12 + num_elem
    READ(f1, *)                 ! Linha 13 + num_elem
    DO i=1, num_nos
        READ(f1, *) j, conf_nos(i,1), conf_nos(i,2), car_noda(3*i-2), car_noda(3*i-1), &
                & car_noda(3*i), res_noda(3*i-2), res_noda(3*i-1), res_noda(3*i), &
                & carg_mov(3*i-2), carg_mov(3*i-1), carg_mov(3*i)
    END DO                      ! Linha 14 + num_elem a 13 + num_elem + num_nos

    ! Rotina para definir o tipo de matriz de massa
    READ(f1, *)                 ! Linha 14 + num_elem + num_nos
    READ(f1, *)                 ! Linha 15 + num_elem + num_nos
    READ(f1, *) tipo_mas        ! Linha 16 + num_elem + num_nos

    ! Rotina para definir se a estrutura tem carga m�vel ou n�o
    READ(f1, *)                 ! Linha 17 + num_elem + num_nos
    READ(f1, *) movel           ! Linha 18 + num_elem + num_nos

    ! Rotina para definir tempo atuante da carga m�vel
    READ(f1, *)                 ! Linha 19 + num_elem + num_nos
    READ(f1, *)                 ! Linha 20 + num_elem + num_nos
    READ(f1, *) tmovel_inicial, tmovel_final        ! Linha 21 + num_elem + num_nos

    ! Rotina para definir matriz de amortecimento
    READ(f1, *)                 ! Linha 22 + num_elem + num_nos
    READ(f1, *) amort           ! Linha 23 + num_elem + num_nos

    IF (amort == 'S') THEN
        READ(f1, *)             ! Linha 24 + num_elem + num_nos
        READ(f1, *)             ! Linha 25 + num_elem + num_nos
        READ(f1, *) a_0, a_1    ! Linha 26 + num_elem + num_nos
    END IF

    ! Fechar arquivo de entrada de dados entrada.txt
    CLOSE(f1)

    ! FIM DE ROTINAS PARA LEITURA DOS DADOS DE ENTRADA

    ! IN�CIO DE ROTINAS PARA PROCESSAMENTO DE DADOS

    ! Roteiro:
    ! 1. Convers�es de unidades
    ! 2. Montagem de matriz 3D das matrizes de rigidez local de cada elemento (MMRIGL)
    ! 3. Montagem de matriz 3D das matrizes de rota��o de cada elemento (MMROT)
    ! 4. Montagem de matriz de rigidez global da estrutura (MMRIGG)
    ! 5. Montagem de matriz 2D de vetores dos esfor�os locais em cada elemento (MVESFL)
    ! 6. Montagem de vertor de esfor�os globais (MVESFG)
    ! 7. Montagem de matriz 3D das matrizes de massa local de cada elemento (MMMASL)
    ! 8. Montagem de matriz de massa global da estrutura (MMMASG)
    ! 9. Inserir restri��es em matrizes de rigidez, esfor�os e massa (RESTR)
    ! 10. C�lculo da resposta -deslocamentos globais- est�tica da estrutura (DLSLRGa)
    ! 11. Montagem da matriz 2D dos vetores de deslocamentos locais de cada elemento (MVDESL)
    ! 12. C�lculo das rea��es locais de cada elemento (CVREAL)
    ! 13. Transforma��o do vetor de restri��es nodais em true/false para 1/0
    ! 14. C�lculo da resposta -deslocamentos globais- transiente da estrutura (AUTOPROBLEMA)

    ! 1. Convers�es
    mod_elas = mod_elas * 1000000   ! MPa para N/m�
    car_elem = car_elem * 1000      ! kN/m para N/m
    car_noda = car_noda * 1000      ! kN para N e kN*m para N*m
    carg_mov = carg_mov * 1000      ! kN para N e kN*m para N*m

    ! 2. Montagem de matrizes de rigidez local
    ALLOCATE(rigs_loc(6,6,num_elem))
    CALL MMRIGL(num_elem,num_nos,conf_ele,conf_nos,larg,altu,mod_elas,rigs_loc)

    ! 3. Montagem de matrizes de rota��o
    ALLOCATE(mrot(6,6,num_elem))
    CALL MMROT(num_elem,num_nos,conf_ele,conf_nos,mrot)

    ! 4. Montagem da matriz de rigidez global da estrutura
    ALLOCATE(rig_estr(3*num_nos,3*num_nos))
    CALL MMRIGG(num_elem,num_nos,conf_ele,rigs_loc,mrot,rig_estr)

    ! 5. Montagem de vetores de esfor�os locais
    ALLOCATE(esfo_loc(6,num_elem))
    CALL MVESFL(num_elem,num_nos,conf_ele,conf_nos,car_elem,esfo_loc)

    ! 6. Montagem do vetor de esfor�os globais
    ALLOCATE(esfo_glo(3*num_nos))
    CALL MVESFG(num_elem,num_nos,conf_ele,mrot,esfo_loc,car_noda,esfo_glo)

    ! 7. Montar matriz de massa local de cada elemento
    ALLOCATE(mass_loc(6,6,num_elem))
    CALL MMMASL(num_elem,num_nos,conf_ele,conf_nos,larg,altu,mas_espe,tipo_mas,mass_loc)

    ! 8. Montar matriz de massa global da estrutura
    ALLOCATE(mas_estr(3*num_nos,3*num_nos))
    CALL MMMASG(num_elem,num_nos,conf_ele,mass_loc,mrot,mas_estr)

    ! 9. Incluir matriz de amortecimento ou n�o
!    OPEN(101,file='matriz_de_amortecimento.txt')
    ALLOCATE(amo_estr(3*num_nos,3*num_nos))
    IF (amort == 'S') THEN
        amo_estr = (a_0 * mas_estr) + (a_1 * rig_estr)
    ELSE
        amo_estr = 0
    END IF
!    WRITE(101,'(27es16.3)') amo_estr
!    CLOSE(101)

    ! 10. Inserir restri��es
    CALL RESTR(num_nos,res_noda,rig_estr,mas_estr,amo_estr,esfo_glo,carg_mov)

    ! 11. C�lculo dos deslocamentos globais da estrutura
    ALLOCATE(desl_glo(3*num_nos))
    CALL DLSLRGa(3*num_nos,3*num_nos,rig_estr,esfo_glo,1,desl_glo)

    ! 12. Montar matriz 2D que armazena deslocamentos locais de cada elemento
    ALLOCATE(desl_loc(6,num_elem))
    CALL MVDESL(num_elem,num_nos,conf_ele,desl_glo,mrot,desl_loc)

    ! 13. Calcular rea��es locais em cada elemento
    ALLOCATE(reac_loc(6,num_elem))
    CALL CVREAL(num_elem,num_nos,conf_ele,esfo_loc,desl_loc,rigs_loc,reac_loc)

    ! 14. C�lculo do delta_t para incremento
    CALL CDELTAT(num_elem,num_nos,conf_ele,conf_nos,larg,altu,mod_elas,mas_espe,delta_t)

    ! 15. Solucionar problema transiente
    CALL SPTRAN(num_nos,rig_estr,mas_estr,amo_estr,carg_mov,delta_t)

    ! FIM DE ROTINAS PARA PROCESSAMENTO DE DADOS

    ! IN�CIO DE ROTINAS PARA SA�DA DE DADOS

    DO i=1, num_elem
        fvar = fvar + i
        WRITE(file_var, '(a13,i4,a4)') 'elem\elemento',i,'.txt'
        OPEN(fvar, file=file_var)

        ! Matrizes de rigidez local de cada elemento
        WRITE(fvar, '(a26,i3)') 'SAIDA DE DADOS DO ELEMENTO', i
        WRITE(fvar, *)
        WRITE(fvar, '(a36,i3)') 'MATRIZ DE RIGIDEZ LOCAL DO ELEMENTO ', i
        DO j=1, 6
            WRITE(fvar, '(6f16.1)') rigs_loc(j,1,i), rigs_loc(j,2,i), rigs_loc(j,3,i), &
                    & rigs_loc(j,4,i), rigs_loc(j,5,i), rigs_loc(j,6,i)
        END DO

        ! Matrizes de massa local de cada elemento
        WRITE(fvar, *)
        WRITE(fvar, '(a34,i3)') 'MATRIZ DE MASSA LOCAL DO ELEMENTO ', i
        DO j=1, 6
            WRITE(fvar, '(6f16.1)') mass_loc(j,1,i), mass_loc(j,2,i), mass_loc(j,3,i), &
                    & mass_loc(j,4,i), mass_loc(j,5,i), mass_loc(j,6,i)
        END DO

        ! Matrizes de rota��o local de cada elemento
        WRITE(fvar, *)
        WRITE(fvar, '(a36,i3)') 'MATRIZ DE ROTACAO LOCAL DO ELEMENTO ', i
        DO j=1, 6
            WRITE(fvar, '(6f16.1)') mrot(j,1,i), mrot(j,2,i), mrot(j,3,i), &
                    & mrot(j,4,i), mrot(j,5,i), mrot(j,6,i)
        END DO

        ! Vetores de esfor�os locais no elemento
        WRITE(fvar, *)
        WRITE(fvar, '(a37,i3)') 'VETOR DE ESFORCOS LOCAIS DO ELEMENTO ', i
        DO j=1, 6
            WRITE(fvar, '(f16.1)') esfo_loc(j,i)
        END DO

        ! Deslocamentos locais de cada elemento
        WRITE(fvar, *)
        WRITE(fvar, '(a41,i3)') 'VETOR DE DESLOCAMENTOS LOCAIS DO ELEMENTO', i
        DO j=1, 6
            WRITE(f2, '(es16.3)') desl_loc(j,i)
        END DO

        ! Rea��es locais em cada elemento
        WRITE(fvar, *)
        WRITE(fvar, '(a19,i3)') 'REACOES NO ELEMENTO', i
        WRITE(fvar, '(a)') '                 Esf Normal (N) Esf Cortante (N) Mom Fletor (Nm)'
        WRITE(fvar, '(a13,3es16.3)') 'No inicial:  ', reac_loc(1,i), reac_loc(2,i), reac_loc(3,i)
        WRITE(fvar, '(a13,3es16.3)') 'No final:    ', reac_loc(4,i), reac_loc(5,i), reac_loc(6,i)

        CLOSE(fvar)
    END DO

    ! Abrir arquivo de sa�da de dados da estrutura saida.txt
    OPEN(f2,file='saida.txt')

    ! Matriz de rigidez global da estrutura
    WRITE(form, '(a1,i4,a6)') '(',3*num_nos,'f16.3)'
    WRITE(f2, *)
    WRITE(f2, '(a)') 'MATRIZ DE RIGIDEZ GLOBAL DA ESTRUTURA'
    WRITE(f2, form) rig_estr

    ! Matriz de rigidez global da estrutura
    WRITE(form, '(a1,i4,a6)') '(',3*num_nos,'f16.3)'
    WRITE(f2, *)
    WRITE(f2, '(a)') 'MATRIZ DE MASSA GLOBAL DA ESTRUTURA'
    WRITE(f2, form) mas_estr

    ! Matriz de rigidez global da estrutura
    WRITE(form, '(a1,i4,a6)') '(',3*num_nos,'f16.3)'
    WRITE(f2, *)
    WRITE(f2, '(a)') 'MATRIZ DE AMORTECIMENTO GLOBAL DA ESTRUTURA'
    WRITE(f2, form) amo_estr

    ! Vetor de esfor�os globais na estrutura
    WRITE(f2, *)
    WRITE(f2, '(a)') 'VETOR DE ESFORCOS GLOBAIS NA ESTRUTURA'
    WRITE(f2, '(f16.1)') esfo_glo

    ! Deslocamentos globais na estrutura
    WRITE(f2, *)
    WRITE(f2, '(a)') 'VETOR DE DESLOCAMENTOS GLOBAIS NA ESTRUTURA'
    WRITE(f2, '(es16.3)') desl_glo

    ! Cargas moveis globais na estrutura
    WRITE(f2, *)
    WRITE(f2, '(a)') 'VETOR DE CARGAS MOVEIS GLOBAIS NA ESTRUTURA'
    WRITE(f2, '(es16.3)') carg_mov

    CLOSE(f2)
    CLOSE(f3)

    ! FIM DE ROTINAS PARA SA�DA DE DADOS

END PROGRAM trabalhofinal