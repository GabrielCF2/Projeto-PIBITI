function [ranque,matriz] = notaPeso(grade)
  [qtdeHorariosPorDia, qtdeDias, qtdeTurmas,qtdeMaterias, qtdeIndividuos] = size(grade);
  pesos = ones(size(grade));
  soma = zeros(qtdeIndividuos,1);
  notas = pesos .* grade;
  for individuo = 1:qtdeIndividuos
    ind = notas(:,:,:,:,individuo);
    soma(individuo) = sum(ind(:));
  endfor
   [ranque,posicao] = sort(soma,'descend');
  matriz = grade(:,:,:,:,posicao);
  
endfunction