function [prioridade_menor, prioridade_maior,soma_dias_trabalhado,profs_trabalharam,dias_prof_trabalhou] = pega_preferencias(matriz,instancia,professores,profTrabalha,listaProfessores,prioridade_menor, prioridade_maior,soma_dias_trabalhado,profs_trabalharam,dias_prof_trabalhou)
  num_professores = length(professores);
##  Substitui a matriz com as matérias por uma matriz com os respectivos professores de cada matéria
  [horarios, dias, turmas] = size(matriz);
  matriz2 = zeros(horarios, dias, turmas);
  for turma = 1:turmas
    for dia = 1:dias
      for hora = 1:horarios
        if matriz(hora,dia,turma) ~= 0
            matriz2(hora, dia, turma) = find(strcmp(listaProfessores(matriz(hora,dia,turma)),professores));
        endif
      endfor
    endfor
  endfor
  % Percorre cada professor
  for prof = 1:num_professores
      dias_trabalho = [];
      preferencias = profTrabalha(prof,:);
      % Percorre a matriz para encontrar os dias que o professor trabalhou
      for dia = 1:dias
          if any(any(matriz2(:, dia, :) == prof))
              dias_trabalho = [dias_trabalho, dia];
          endif
      endfor
##      Zera a variável para retirar resíduos
      prof_dias_trabalhado = zeros(1,length(dias_trabalho));
      
      if ~isempty(dias_trabalho)
        
        valores_preferencias = preferencias(dias_trabalho);
        
      % Verifica se o professor trabalhou no dia menos desejado 
        [~, idx] = min(valores_preferencias);
        menor_preferencia = find(sort(preferencias, 'descend') == preferencias(dias_trabalho(idx)));
        
                    

      % Verifica se o professor trabalhou no dia mais desejado
        [~, idx2] = max(valores_preferencias);
        maior_preferencia = find(sort(preferencias, 'descend') == preferencias(dias_trabalho(idx2)));
       
        

        %Conta quantos dias cada professor trabalhou
        cont_dias(prof) = length(dias_trabalho);
        
        for i = 1:length(dias_trabalho)
          prof_dias_trabalhado(i) = find(sort(preferencias, 'descend') == preferencias(dias_trabalho(i)));
        endfor
          
      endif
      %O marcador é incrementeado no dia de menor preferência que o professor teve que trabalhar
      prioridade_menor(instancia, menor_preferencia) +=1 ;
      %O marcador é incrementado no dia de maior preferência que o professor trabalhou
      prioridade_maior(instancia, maior_preferencia) +=1 ;

      soma_dias_trabalhado(instancia,prof_dias_trabalhado) +=1;

      
  endfor
  %retorna quantos professores trabalharam em cada dia
  for dia = 1:dias
    profs_trabalharam(instancia,dia) = length(unique(matriz2(:,dia,:)))-1;
  endfor
  %retorna quantos dias cada professor trabalhou
  dias_prof_trabalhou(instancia,:) = cont_dias;

endfunction