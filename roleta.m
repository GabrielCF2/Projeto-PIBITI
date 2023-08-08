function pares = roleta(nota, gradeHoraria, quantElite)
  aptidao=(nota);
  tamPopulacao = size(aptidao, 1);
  tamPares = (size(aptidao, 1) - quantElite)/2;
  totalAptidao = sum(aptidao);
  PDFAptidao = aptidao./totalAptidao;
  roletaIndividuos = cumsum(PDFAptidao);
  
  
  for contPar = 1:tamPares
    for contPai = 1:2
      prob = rand(1);
      idIndividuo = find(roletaIndividuos >=prob,1,"first");
      if isempty(idIndividuo)
        idIndividuo = tamPopulacao;
      endif
      pares{contPar,contPai} = gradeHoraria(:,:,:,idIndividuo);
##      keyboard
    endfor
  endfor
 
  
endfunction