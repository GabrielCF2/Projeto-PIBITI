function Exercicio0()
  pkg load io


##  Matriz lida de um arquivo
  listaDisciplinas = csv2cell('TesteCompleto.csv');
  listaDisciplinas = listaDisciplinas(2:end, :);
  qtdeDisciplinas = size(listaDisciplinas, 1);
  qtdeDias = 5;
  qtdeHorariosPorDia = 7;
  qtdeTurmas = size(unique(cell2mat(listaDisciplinas(:,4))),1);
  quantElite = 2;
  quantLoops = 100;
  qtdeIndividuos = 50;
  

  
  probMut = 0.02; %Probabilidade de mutação de 2% ( dois porcento )
  
  turmas = unique(cell2mat(listaDisciplinas(:,4))); %lista das turmas, por enquanto é um valor inteiro
  turnos = unique(upper(listaDisciplinas(:,5))); %lista dos turnos, por enquanto é um cell de strings
##  professores = (unique(upper(listaDisciplinas(:,6))));
  listaTurnos = upper(listaDisciplinas(:,5));
  nomeDisciplinas = listaDisciplinas(:,2);
  listaProfessores = upper(listaDisciplinas(:,6));
  listaDisciplinas = cell2mat(listaDisciplinas(:,3:4));
  gradeDisciplinas = zeros(size(listaDisciplinas,1),length(turmas));
##  a = strcmp(listaProfessores,professores{3});
##  if sum(a)>0
##    printf("Batata");
##  endif
  
  for i = 1:length(turmas)
      gradeDisciplinas(:,i) = listaDisciplinas(:,1) .* (listaDisciplinas(:,2) == turmas(i));
  endfor

   
  if sum(gradeDisciplinas)>(qtdeDias*qtdeHorariosPorDia)%Tem mais disciplinas que horários disponíveis
    keyboard
  endif
  
  popBin = geraPopulacao(listaDisciplinas, qtdeHorariosPorDia, qtdeDias, qtdeDisciplinas, qtdeTurmas, qtdeIndividuos,gradeDisciplinas,listaTurnos);
  cumpriRestricao = checaRestricoes(popBin,qtdeIndividuos,listaDisciplinas,gradeDisciplinas);
  [grade] = converteBinario(popBin);
  maiorNota = nan(quantLoops, 1);
  flagPlot = 1;
  for cont = 1:quantLoops
    [pontuacao, grade]= nota(grade);
    maiorNota(cont) = pontuacao(1);
    if flagPlot == 1
      plot(1:quantLoops, maiorNota, '*', 'markersize', 4,  'linewidth', 2);
      pause(0.1);
    endif
    elite = grade(:, :, :, 1:quantElite);
  ##  [elite,grade,nota]=geraElite(grade,nota,quantElite);

    pares = roleta(pontuacao, grade, quantElite);
    filhos = cruzamento(pares,gradeDisciplinas,listaDisciplinas,listaTurnos,listaProfessores);
    grade = cellPraMatriz(filhos);
    grade2 = mutacao(grade, probMut,listaDisciplinas,listaTurnos,listaProfessores);
    grade = zeros(qtdeHorariosPorDia, qtdeDias, qtdeTurmas, qtdeIndividuos);
    grade(:, :, :, 1:(end - quantElite)) = grade2;
    grade(:, :, :, (qtdeIndividuos - quantElite + 1):qtdeIndividuos) = elite;
    
  endfor

  gravaResultado(pontuacao,gradeDisciplinas,nomeDisciplinas,grade);
endfunction

