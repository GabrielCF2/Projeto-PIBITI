function filhos = cruzamento(duplas, disciplinas,listaDisciplinas,listaTurnos,listaProfessores)
  quantPares = size(duplas)(1);
  quantDisciplinas = size(disciplinas)(1);
  for contPares = 1:quantPares
    numSort = randi(quantDisciplinas);
    for contDupla = 1:2
      par{contDupla} = duplas{contPares,contDupla};
      quantTurmas = size(par{contDupla})(3);
      [linhas{contDupla},colunas{contDupla}, turma{contDupla}] = ind2sub(size(par{contDupla}),find(numSort==par{contDupla}));
      quantLoops = size(linhas{contDupla})(1);

      for contLoop = 1:quantLoops
        par{contDupla}(linhas{contDupla}(contLoop),colunas{contDupla}(contLoop), turma{contDupla}(contLoop)) = 0;
      endfor

    endfor

    filhos{contPares,1}=trocaValores(par{1},linhas{2},colunas{2},turma{2},quantLoops,numSort,listaTurnos,listaProfessores);
    filhos{contPares,2}=trocaValores(par{2},linhas{1},colunas{1},turma{1},quantLoops,numSort,listaTurnos,listaProfessores);
  endfor
##  Aplicar a mutação aqui
##  Definir a probabilidade de mutação
  
endfunction

function grade=trocaValores(grade, linha, coluna, turma, quantLoops,numSort,listaTurnos,listaProfessores)
  [quantHorarios,quantDias,~]=size(grade);
  for contLoop = 1:quantLoops
    val = 0;
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
            [linha(contLoop),coluna(contLoop)] = achaValidos(grade,numSort,turma(contLoop), listaTurnos);
            
          endif
        else
          flag = 1;
          [linha(contLoop),coluna(contLoop)] = achaValidos(grade,numSort,turma(contLoop), listaTurnos);
        endif
      else
        flag = 1;
        [linha(contLoop),coluna(contLoop)] = achaValidos(grade,numSort,turma(contLoop), listaTurnos);
      endif
      %val é utilizado para saber se esse loop acontece muitas vezes
      % se acontecer é porque o algoritmo está com dificuldades de encontrar uma combinação viável
      val = val+1;
      if val>1000
        keyboard
      endif
    until flag == 0
  endfor

endfunction
#Função para o valor sorteado ser um dos horários vagos em vez de aleatoriamente escolher algum
function [linha, coluna] = achaValidos(grade,numSort,turma, listaTurnos) 
  if strcmp(listaTurnos(numSort),"MATUTINO")
    horario = 1:3;
  elseif strcmp(listaTurnos(numSort),"VESPERTINO")
    horario = 4:5;
  elseif strcmp(listaTurnos(numSort),"INTEGRAL")
    horario = 1:5;
  elseif strcmp(listaTurnos(numSort),"NOTURNO")
    horario = 6:7;
  endif
  [linhas,colunas]=find(0==grade(horario,:,turma));
  valSort = randi(length(linhas));
  linha = linhas(valSort);
  coluna = colunas(valSort);
endfunction