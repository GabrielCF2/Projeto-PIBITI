function passou =  checaRestricoes(popBin,qtdeIndividuos,listaDisciplinas,gradeDisciplinas)
  [qtdeHorariosPorDia, qtdeDias, qtdeDisciplinas, qtdeTurmas, qtdeIndividuos] = size(popBin);
  passou = zeros(qtdeTurmas,qtdeIndividuos);
  corrHorario = checaHorario(popBin);
  corrCarga = checaCarga(popBin,listaDisciplinas,gradeDisciplinas);
  corrHorario = sum(sum(corrHorario));
  corrCarga = sum(corrCarga);
  for contIndividuo = 1:qtdeIndividuos
    for contTurma = 1:qtdeTurmas
      if corrHorario(1,1,contTurma,contIndividuo) == (qtdeHorariosPorDia*qtdeDias) && corrCarga(1,contTurma,contIndividuo) == qtdeDisciplinas
        passou(contTurma,contIndividuo) = 1;
      endif
    endfor
  endfor
endfunction