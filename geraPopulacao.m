function popBin = geraPopulacao(listaDisciplinas, qtdeHorariosPorDia, qtdeDias, qtdeDisciplinas, qtdeTurmas, qtdeIndividuos,gradeDisciplinas,listaTurnos,listaProfessores)
##  Gerar uma população inicial
##  gradeSemana controla a tabela de horários


  % Preencher a nova matriz com os dados das matérias separados por turma
  popBinSub = zeros(qtdeHorariosPorDia,qtdeDias,qtdeDisciplinas);
  popBin = zeros(qtdeHorariosPorDia, qtdeDias, qtdeDisciplinas, qtdeTurmas, qtdeIndividuos);
  % Vamos gerar horários aleátorios para cada par disciplina-indivíduo
  for contIndividuo = 1:qtdeIndividuos
    for contTurma = 1:qtdeTurmas
      popBinSub = zeros(qtdeHorariosPorDia,qtdeDias,qtdeDisciplinas);
      for contDisciplina = 1:qtdeDisciplinas
        cargaHorariaDisciplina = listaDisciplinas(contDisciplina, 1);
        if gradeDisciplinas(contDisciplina,contTurma)~=0
          do
            popBinSub(:,:,contDisciplina) = popBin(:,:,contDisciplina,contTurma,contIndividuo);
            flagColisao = 0;
            popBinChecagem = 0;
            diasDisciplina = randi([1 qtdeDias], 1, cargaHorariaDisciplina);
            horarioDisciplina = randi([1 qtdeHorariosPorDia], 1, cargaHorariaDisciplina);
            parDiaHorario = [diasDisciplina; horarioDisciplina];
            for i = 1:qtdeTurmas
              popBinChecagem = popBinChecagem + popBin(:,:,:,i,contIndividuo);
            endfor
            for contDiaHorario1 = 1:cargaHorariaDisciplina
##              Impede que um professor dê aula em mais de um lugar ao mesmo tempo
              indices = find(popBinChecagem(horarioDisciplina(contDiaHorario1),diasDisciplina(contDiaHorario1),:));
              if sum(strcmp(listaProfessores(contDisciplina),listaProfessores(indices))) == 0
                if popBinSub(horarioDisciplina(contDiaHorario1),diasDisciplina(contDiaHorario1),:)==0
                  if strcmp(listaTurnos(contDisciplina),"MATUTINO") && (horarioDisciplina(contDiaHorario1)<4)
                    popBinSub(horarioDisciplina(contDiaHorario1),diasDisciplina(contDiaHorario1),contDisciplina) = 1;
                  elseif (strcmp(listaTurnos(contDisciplina),"VESPERTINO") &&(horarioDisciplina(contDiaHorario1)>3 &&(horarioDisciplina(contDiaHorario1)<6)))
                    popBinSub(horarioDisciplina(contDiaHorario1),diasDisciplina(contDiaHorario1),contDisciplina) = 1;
                  elseif (strcmp(listaTurnos(contDisciplina),"INTEGRAL") && horarioDisciplina(contDiaHorario1)<6)
                    popBinSub(horarioDisciplina(contDiaHorario1),diasDisciplina(contDiaHorario1),contDisciplina) = 1;
                  elseif (strcmp(listaTurnos(contDisciplina),"NOTURNO")&&horarioDisciplina(contDiaHorario1)>5)
                    popBinSub(horarioDisciplina(contDiaHorario1),diasDisciplina(contDiaHorario1),contDisciplina) = 1;
                  else
                    flagColisao = 1;
                    break
                  endif
                else
                  flagColisao = 1;
                  break
                endif
              else
                flagColisao = 1;
                break
              endif
            endfor
          until flagColisao ~= 1
          popBin(:,:,contDisciplina,contTurma,contIndividuo) = popBinSub(:,:,contDisciplina);      
        endif
      endfor
    endfor
  endfor
  
endfunction
