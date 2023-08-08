function correspondencia = checaHorario(popBin)
  [qtdeHorariosPorDia, qtdeDias, qtdeDisciplinas, qtdeTurmas, qtdeIndividuos] = size(popBin);
  correspondencia = zeros(qtdeHorariosPorDia, qtdeDias,qtdeTurmas,qtdeIndividuos);
  for contIndividuo = 1:qtdeIndividuos
    for contTurma = 1:qtdeTurmas
      for contDia= 1:qtdeDias
        for contHorario = 1:qtdeHorariosPorDia
          totalAulas = sum(popBin(contHorario,contDia,:,contTurma,contIndividuo));
          if totalAulas<=1
            correspondencia(contHorario, contDia, contTurma, contIndividuo) = 1;
          endif
        endfor
      endfor
    endfor
  endfor
endfunction