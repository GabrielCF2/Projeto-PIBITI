function Exercicio0()
  pkg load io


##  Matriz lida de um arquivo
  listaDisciplinas = csv2cell('teste.csv');
##  listaDisciplinas = csv2cell('TabelaMatutino.csv');
  listaDisciplinas = listaDisciplinas(2:end, :);
  qtdeDisciplinas = size(listaDisciplinas, 1);
  qtdeDias = 5;
  qtdeHorariosPorDia = 7;
  qtdeTurmas = size(unique(cell2mat(listaDisciplinas(:,4))),1);
  quantElite = 2;
  quantLoops = 200;%100
  qtdeIndividuos = 200;%200
 
  
  probMut = 0.2; % 0.02 = Probabilidade de mutação de 2% ( dois porcento )
  
  turmas = unique(cell2mat(listaDisciplinas(:,4))); %lista das turmas, por enquanto é um valor inteiro
  turnos = unique(upper(listaDisciplinas(:,5))); %lista dos turnos, por enquanto é um cell de strings
  professores = (unique(upper(listaDisciplinas(:,6))));%Essa variável contém o nome dos professores listados na tabela de entrada ordenados em ordem alfabética
  listaTurnos = upper(listaDisciplinas(:,5));
  nomeDisciplinas = listaDisciplinas(:,2);
  listaProfessores = upper(listaDisciplinas(:,6));%Essa variável contém o nome dor professores na ordem que foi retirada da tabela de entrada
  listaBlocados = cell2mat(listaDisciplinas(:,7));
  listaDisciplinas = cell2mat(listaDisciplinas(:,3:4));
  gradeDisciplinas = zeros(size(listaDisciplinas,1),length(turmas));
  
##  Variáveis para o teste com 50 instâncias
  quantInstancia = 1;
  prioridade_menor = zeros(quantInstancia, qtdeDias);
  prioridade_maior = zeros(quantInstancia, qtdeDias);
  profs_trabalharam = zeros(quantInstancia, qtdeDias);
  soma_dias_trabalhado = zeros(quantInstancia, qtdeDias);
  dias_prof_trabalhou = zeros(quantInstancia,length(professores));
  #vetor de teste para os dias da semana em que o professor quer trabalhar:
  #colunas: segunda, terça, quarta, quinta, sexta
  #linhas: lista de professores
  #Arrumar uma forma de inserir automaticamente

##  profTrabalha = [10,1,8,9,2;
##                  8,1,10,9,2;
##                  2,10,9,1,8;
##                  10,1,9,2,8;
##                  8,2,9,1,10;
##                  9,2,1,8,10;
##                  9,10,2,8,1;
##                  1,10,8,2,9;
##                  2,1,10,9,8

                  
  profTrabalha = [10,8,6,4,0;  %Alessandro
                6,10,8,4,0;  %Alexandre
                8,4,10,6,0;  %Hugo
                4,6,8,10,0;  %Loja
                2,4,6,8,10]; %Maria

##  Gera valores aleatórios para a matriz de prioridade de dias dos professores se a flag "aleatorio" estiver ativada
  aleatorio = 0;  
  prioridade = [10,9,8,2,1];
  
  for i = 1:length(turmas)
      gradeDisciplinas(:,i) = listaDisciplinas(:,1) .* (listaDisciplinas(:,2) == turmas(i));
  endfor

  if sum(gradeDisciplinas)>(qtdeDias*qtdeHorariosPorDia)%Tem mais disciplinas que horários disponíveis
    keyboard
  endif
  

  ##  Teste com 50 instâncias
  for instancia = 1:quantInstancia
    
    popBin = geraPopulacao(listaDisciplinas, qtdeHorariosPorDia, qtdeDias, qtdeDisciplinas, qtdeTurmas, qtdeIndividuos,gradeDisciplinas,listaTurnos,listaProfessores);
    cumpriRestricao = checaRestricoes(popBin,qtdeIndividuos,listaDisciplinas,gradeDisciplinas);
    [grade] = converteBinario(popBin);
    maiorNota = nan(quantLoops, 1);
    flagPlot = 1;    

    
    if aleatorio == 1
      for i =1:length(professores)
        profTrabalha(i,:) = prioridade(randperm(length(prioridade)));
      endfor
    endif
    for cont = 1:quantLoops
      %Criar um método de pontuação que faça uso de uma matriz de pesos
  ##    [pontuacao,grade] = notaPeso(popBin);
      [pontuacao, grade]= nota(grade,listaBlocados,professores,listaProfessores,profTrabalha); #Atribui uma nota a cada grade horárias
      maiorNota(cont) = pontuacao(1);
##      =================================================================================
##      PAUSADO A PLOTAGEM DO GRÁFICO PARA TESTE EXTENSO, DESCOMENTAR DEPOIS

      if flagPlot == 1
        plot(1:quantLoops, maiorNota, '*', 'markersize', 4,  'linewidth', 2);
        pause(0.1);
      endif
##      =================================================================================
      
      elite = grade(:, :, :, 1:quantElite);
      melhor = grade(:,:,:,1);
      pares = roleta(pontuacao, grade, quantElite);
      filhos = cruzamento(pares,gradeDisciplinas,listaDisciplinas,listaTurnos,listaProfessores);
      grade = cellPraMatriz(filhos);
      grade2 = mutacao(grade, probMut,listaDisciplinas,listaTurnos,listaProfessores);
      grade = zeros(qtdeHorariosPorDia, qtdeDias, qtdeTurmas, qtdeIndividuos);
      grade(:, :, :, 1:(end - quantElite)) = grade2;
      grade(:, :, :, (qtdeIndividuos - quantElite + 1):qtdeIndividuos) = elite;
      
    endfor
##    marca os horários dos professores ao final do algoritmo genético, faz isso várias vezes para tirar uma média
    [prioridade_menor, prioridade_maior,soma_dias_trabalhado,profs_trabalharam,dias_prof_trabalhou] = pega_preferencias(melhor,instancia,professores,profTrabalha,listaProfessores,prioridade_menor, prioridade_maior,soma_dias_trabalhado,profs_trabalharam,dias_prof_trabalhou);
    
##    apenas para mostrar no terminal em qual loop está, apagar depois
    instancia
  endfor

##  Salva no documento Instancias.csv o resultado dos 50 testes contendo os dias menos desejados dos professores
##  csvwrite("Resultado_Menor.csv",prioridade_menor);
##  csvwrite("Resultado_Maior.csv",prioridade_maior);
##  csvwrite("Resultado_Soma_Dias_Trabalhado.csv",soma_dias_trabalhado);
##  csvwrite("Resultado_Professores_por_Dia.csv",profs_trabalharam);
##  csvwrite("Resultado_Dias_Prof_Trabalhou.csv",dias_prof_trabalhou);
  
  gravaResultado(pontuacao,gradeDisciplinas,nomeDisciplinas,melhor);
endfunction

