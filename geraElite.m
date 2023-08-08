function [elite,novaGrade]=geraElite(grade,nota,quantElite)
  quantIndividuos = size(grade)(4);
  for contElite = 1:quantElite
    elite(:,:,:,contElite)=grade(:,:,:,contElite);
  endfor
  for cont = quantElite+1:quantIndividuos
    novaGrade(:,:,:,cont-quantElite)=grade(:,:,:,cont);
  endfor
  
endfunction
