function [ranque, matriz2] = nota(matriz,listaBlocados,professores,listaProfessores,profTrabalha)
  [qtdeHorariosPorDia, qtdeDias, qtdeTurmas, qtdeIndividuos] = size(matriz);
  soma = zeros(qtdeIndividuos,1);
  ranque = zeros(qtdeIndividuos,2);
  potJunto = 0;#Aumenta quando há matérias seguidas, zera se tiver um espaço vazio
  potDisc = 0;#Potência da disciplina, dobra cada vez que repete uma disciplina
  discAnt = 0;#Disciplina anterior

  for contIndividuo = 1:qtdeIndividuos
    for contTurma = 1:qtdeTurmas
      for contDia = 1:qtdeDias
        for contHorario = 1:qtdeHorariosPorDia
          potJunto++;
          potDisc++;
          if matriz(contHorario,contDia,contTurma,contIndividuo)~=0
            %Adiciona um valor ao fitness com base na blocagem de matérias iguais e diferentes
            soma(contIndividuo) += (potDisc*potJunto);

            %Vê se o professor da referia matéria optou por ter aula no dia
            %Se o professor tiver aula no dia de sua escolha o valor do fitness é incrementado, se não, então o valor não é alterado
            soma(contIndividuo) += profTrabalha(find(strcmp(listaProfessores(matriz(contHorario,contDia,contTurma,contIndividuo)),professores)),contDia)/2;
          endif
          if matriz(contHorario,contDia,contTurma,contIndividuo) == 0
            potJunto = 0;
          endif
          if matriz(contHorario,contDia,contTurma,contIndividuo) == discAnt && discAnt ~= 0
            %Recompensa caso seja blocado e punição caso não seja
            potDisc *= 2*(listaBlocados(matriz(contHorario,contDia,contTurma,contIndividuo))-0.5);
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
  [ranque,posicao] = sort(soma,'descend');
  matriz2 = matriz(:,:,:,posicao);

endfunction