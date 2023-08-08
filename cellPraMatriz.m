function popBin=cellPraMatriz(pares)
  quantPares = size(pares)(1);
  cont = 1;
  pos = 1;
  while cont<=quantPares*2
    for par=1:2
      popBin(:,:,:,cont) = pares{pos,par};
      cont++;
    endfor
    pos++;
  endwhile
endfunction
