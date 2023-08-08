function [matriz,matrizBin]=converteBinario(popBin)
  [qtdeHorariosPorDia, qtdeDias, qtdeDisciplinas, qtdeTurmas, qtdeIndividuos] = size(popBin);
  matriz = zeros(qtdeHorariosPorDia, qtdeDias, qtdeTurmas, qtdeIndividuos);
  matrizBin = zeros(qtdeHorariosPorDia, qtdeDias, qtdeTurmas, qtdeIndividuos);  
  for contIndividuo = 1:qtdeIndividuos
    for contTurma = 1:qtdeTurmas
      for contDisciplina = 1:qtdeDisciplinas
        for contDia = 1:qtdeDias
          for contHorario = 1:qtdeHorariosPorDia
            if popBin(contHorario,contDia,contDisciplina,contTurma,contIndividuo) ~=0
              matriz(contHorario,contDia,contTurma,contIndividuo) = contDisciplina;
              matrizBin(contHorario,contDia,contTurma,contIndividuo) += 1;
            endif
          endfor
        endfor
      endfor
    endfor
  endfor
endfunction
