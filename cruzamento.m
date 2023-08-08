function filhos = cruzamento(duplas, disciplinas,listaDisciplinas,listaTurnos,listaProfessores)
  quantPares = size(duplas)(1);
  quantDisciplinas = size(disciplinas)(1);
##  keyboard
  for contPares = 1:quantPares
    numSort = randi(quantDisciplinas);
    for contDupla = 1:2
      par{contDupla} = duplas{contPares,contDupla};
      quantTurmas = size(par{contDupla})(3);
      [linhas{contDupla},colunas{contDupla}, turma{contDupla}] = ind2sub(size(par{contDupla}),find(numSort==par{contDupla}));
      quantLoops = size(linhas{contDupla})(1);
##      if listaDisciplinas(numSort,1) ~= quantLoops
##        keyboard
##      endif
      for contLoop = 1:quantLoops
        par{contDupla}(linhas{contDupla}(contLoop),colunas{contDupla}(contLoop), turma{contDupla}(contLoop)) = 0;
      endfor
##      if find(numSort==par{contDupla}) ~= 0
##        keyboard
##      endif
    endfor
##    if size(linhas{1},1)~=quantLoops
##      keyboard
##    endif
    filhos{contPares,1}=trocaValores(par{1},linhas{2},colunas{2},turma{2},quantLoops,numSort,listaTurnos,listaProfessores);
    filhos{contPares,2}=trocaValores(par{2},linhas{1},colunas{1},turma{1},quantLoops,numSort,listaTurnos,listaProfessores);
  endfor
##  Aplicar a mutação aqui
##  Definir a probabilidade de mutação
  

endfunction

function grade=trocaValores(grade, linha, coluna, turma, quantLoops,numSort,listaTurnos,listaProfessores)
  [quantHorarios,quantDias,~]=size(grade);
  for contLoop = 1:quantLoops
    
    do
      flag = 0;
      if grade(linha(contLoop),coluna(contLoop),turma(contLoop))==0
        [~,~,indices] = find(grade(linha(contLoop),coluna(contLoop),:));
        if sum(strcmp(listaProfessores(numSort),listaProfessores(indices)))==0
          if (strcmp(listaTurnos(numSort),"MATUTINO") && linha(contLoop)<4)
            grade(linha(contLoop),coluna(contLoop),turma(contLoop)) = numSort;
            flag=0;
          elseif (strcmp(listaTurnos(numSort),"VESPERTINO") && (linha(contLoop) > 3 && linha(contLoop) < 6))
            grade(linha(contLoop),coluna(contLoop),turma(contLoop)) = numSort;
            flag=0;
          elseif (strcmp(listaTurnos(numSort),"INTEGRAL")&&linha(contLoop)<6)
            grade(linha(contLoop),coluna(contLoop),turma(contLoop)) = numSort;
            flag=0;
          elseif (strcmp(listaTurnos(numSort),"NOTURNO")&&linha(contLoop)>5)
            grade(linha(contLoop),coluna(contLoop),turma(contLoop)) = numSort;
            flag=0;
          else
            flag = 1;
            linha(contLoop) = randi(quantHorarios);
            coluna(contLoop) = randi(quantDias);
          endif
        else
          linha(contLoop) = randi(quantHorarios);
          coluna(contLoop) = randi(quantDias);
          flag = 1;
        endif
      else
        flag = 1;
        linha(contLoop) = randi(quantHorarios);
        coluna(contLoop) = randi(quantDias);
      endif
      
    until flag == 0
  endfor
##  if size(find(numSort==grade),1) ~= quantLoops
##    keyboard
##  endif
##  if cont~=quantLoops
##    keyboard
##  endif

endfunction