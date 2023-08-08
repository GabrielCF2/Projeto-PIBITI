function correspondencia = checaCarga(popBin,listaDisciplinas,gradeDisciplinas)
  [qtdeHorariosPorDia, qtdeDias, qtdeDisciplinas, qtdeTurmas, qtdeIndividuos] = size(popBin);
  correspondencia = zeros(qtdeDisciplinas,qtdeTurmas,qtdeIndividuos);
  for contIndividuo = 1:qtdeIndividuos
    for contTurma = 1:qtdeTurmas
      for contDisciplina = 1:qtdeDisciplinas
        valDisciplina = sum(sum(popBin(:,:,contDisciplina, contTurma, contIndividuo)));
##        cargaHorariaDisciplina = listaDisciplinas(contDisciplina, 1);
        if valDisciplina == gradeDisciplinas(contDisciplina,contTurma)
          correspondencia(contDisciplina, contTurma, contIndividuo) = 1;
        endif
      endfor
    endfor
  endfor
endfunction