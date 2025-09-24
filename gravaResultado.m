function gravaResultado(nota,gradeDisciplinas,nomeDisciplinas,melhor)
##  melhor = grade(:,:,:,1);
  [qtdeHorariosPorDia,qtdeDias,qtdeDisciplinas] = size(melhor);
  arquivo = cell(qtdeHorariosPorDia*qtdeDisciplinas+qtdeDisciplinas,qtdeDias);
  
  arquivo(1,:) = {"SEGUNDA",'TERÇA','QUARTA','QUINTA','SEXTA'};
  for contHorario = 1:qtdeHorariosPorDia
    for contDia = 1:qtdeDias
      for contDisciplina = 1:qtdeDisciplinas
        if melhor(contHorario,contDia,contDisciplina) ~= 0
          arquivo{contHorario+contDisciplina+((contDisciplina-1)*qtdeHorariosPorDia),contDia} =  nomeDisciplinas{melhor(contHorario,contDia,contDisciplina)};
        endif
      endfor
    endfor
  endfor
  arquivo(3,qtdeDias+2) = {"Nota do resultado"};
  arquivo(4,qtdeDias+2) = {nota(1)};
  cell2csv('resultado.csv', arquivo);
endfunction