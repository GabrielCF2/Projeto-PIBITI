function [ranque, matriz2] = nota(matriz)

  [qtdeHorariosPorDia, qtdeDias, qtdeTurmas, qtdeIndividuos] = size(matriz);
  soma = zeros(qtdeIndividuos,1);
  ranque = zeros(qtdeIndividuos,2);
  potJunto = 0;
  potDisc = 0;
  discAnt = 0;

  for contIndividuo = 1:qtdeIndividuos
    for contTurma = 1:qtdeTurmas
      for contDia = 1:qtdeDias
        for contHorario = 1:qtdeHorariosPorDia
          potJunto++;
          potDisc++;
          if matriz(contHorario,contDia,contTurma,contIndividuo)~=0
            soma(contIndividuo) += potDisc*potJunto;
          endif
          
          if matriz(contHorario,contDia,contTurma,contIndividuo) == 0
            potJunto = 0;
          endif
          if matriz(contHorario,contDia,contTurma,contIndividuo) == discAnt && discAnt ~= 0
            potDisc *= 2;
          else
            potDisc = 0;
          endif
          discAnt = matriz(contHorario,contDia,contTurma,contIndividuo);
        endfor
        potJunto = 0;
        potDisc = 0;
      endfor
    endfor
  endfor
##  [ranque(:,1),ranque(:,2)] = sort(soma,'descend');
  [ranque,posicao] = sort(soma,'descend');
  matriz2 = matriz(:,:,:,posicao);
  

endfunction