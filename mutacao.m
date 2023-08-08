function matriz = mutacao(matriz, probMut,listaDisciplinas,listaTurnos,listaProfessores)
  [qtdHorarios,qtdDias,qtdMaterias,qtdIndividuos] = size(matriz);
  for contIndividuo = 1:qtdIndividuos
    probabilidade = rand(1);
    if probabilidade<=probMut
##      Escolher uma matéria para se alterar os seus dados
##      Primeiro zera toda ocorrência dessa matéria na tabela
##      Depois sorteia novos valores para matéria, cumprindo a carga horária e a turma
      numMut = randi(qtdMaterias);
      
      [horario,dia,turma]=ind2sub(size(matriz(:,:,:,contIndividuo)),find(numMut==matriz(:,:,:,contIndividuo)));
      quantLoops = size(horario)(1);
##      if listaDisciplinas(numMut,1) ~= quantLoops
##        keyboard
##      endif
      for contLoop = 1:quantLoops
        matriz(horario(contLoop),dia(contLoop), turma(contLoop),contIndividuo) = 0;
      endfor
##      if find(numMut==matriz(:,:,:,contIndividuo)) ~= 0
##        keyboard
##      endif
      for contLoop = 1:quantLoops
        do
          flag = 0;
          horario = randi(qtdHorarios);
          dia = randi(qtdDias);
          if matriz(horario,dia,turma(contLoop),contIndividuo)==0 && ((strcmp(listaTurnos(numMut),"MATUTINO") && horario<4) || (strcmp(listaTurnos(numMut),"VESPERTINO") && (horario>3 && horario<6) ) || (strcmp(listaTurnos(numMut),"INTEGRAL")&&horario<6) || (strcmp(listaTurnos(numMut),"NOTURNO")&&horario>5))
            [~,~,indices] = find(matriz(horario,dia,:,contIndividuo));
            if sum(strcmp(listaProfessores(numMut),listaProfessores(indices)))==0
              matriz(horario,dia,turma(contLoop),contIndividuo) = numMut;
              flag = 0;
            else
              flag = 1;
            endif
          else
            flag = 1;
          endif
        until flag == 0
      endfor
##      if cont~=quantLoops
##        keyboard
##      endif
##      if size(find(numMut==matriz(:,:,:,contIndividuo)),1) ~= quantLoops
##        keyboard
##      endif
    endif

  endfor
endfunction
