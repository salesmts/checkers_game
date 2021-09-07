program damas;
uses Crt;
Var
// { declaração de variáveis globais -----------------------------------}
fimDeJogo: boolean;
locaisDoTabuleiro: array[1..8,1..8] of string;
jogadorDaVez,pontosTimeX,pontosTimeY: integer;
inputAcao: string;  // { variavel para 'pausar' telas de Menu e Sobre;};
posicaoPecaAtual: array[1..2] of integer;

pecaSeMoveuSemCapturar: boolean;

// {matriz(4 linhas e 3 colunas) onde exibe os possiveis caminhos}
// {que a peça pode seguir.}
// {as duas primeiras colunas definem a linha e coluna(respectivamente)}
// {do caminho que a peça irá seguir}
// {a coluna 3 pode ser 1 ou 0! Onde 1 significa que a peça está comendo}
// {outra peça}
caminhosPossiveis: array[1..4,1..4] of integer;

posDaVezVetorDamas: integer;
caminhosPossiveisDama: array[1..13,1..4] of integer;

// { montando tabuleiro na tela ----------------------------------------}
procedure mostrarTabuleiro();
var
linha,coluna: integer;
begin
   writeln('------------------------------');
   writeln('|    TABULEIRO:              |');
   writeln('|                            |');
   writeln('|     C 1 2 3 4 5 6 7 8      |');
   writeln('|   L                        |');
   linha := 8;
   while linha >= 1 do
   begin
      write('|   ',linha,'  ');
      for coluna :=  1 to 8 do begin
         write('|');
         if(locaisDoTabuleiro[linha,coluna] = '')then begin
            write(' ');
         end else begin
            write(locaisDoTabuleiro[linha,coluna]);
         end;
         if(coluna = 8)then begin
            writeln('|     |');
         end;
      end;
      linha := linha - 1;
   end;
   writeln('|                            |');
   writeln('------------------------------');
end;

procedure mostrarTutorial();
begin
   inputAcao := 'ficarNoTutorial';
   while (inputAcao <> 'V') do begin
      ClrScr;
      writeln('  _____  _   _  _____   ___   ___  ___    _    _    ');
      writeln(' |_   _|| | | ||_   _| / _ \ | _ \|_ _|  /_\  | |   ');
      writeln('   | |  | |_| |  | |  | (_) ||   / | |  / _ \ | |__ ');
      writeln('   |_|   \___/   |_|   \___/ |_|_\|___|/_/ \_\|____|');
      writeln('- - - - - - - - - - - - - - - - - - - - - - - - - - -');
      writeln('               PRINCIPAIS REGRAS:');
      writeln('O JOGO DE DAMAS PRATICA-SE ENTRE DOIS JOGADORES:');
      writeln('JOGADOR 1, COM AS PECAS X E JOGADOR 2 COM AS PECAS Y');
      writeln('');
      writeln('O TABULEIRO E FORMADO POR 64 CASAS (8 por 8)');
      writeln('');
      writeln('               COMO JOGAR:');
      writeln('Assim que a jogada se inicia, o jogo pergunta ao');
      writeln('jogador da vez qual a posicao (linha e coluna) da');
      writeln('peca que ele deseja mover');
      writeln('');
      writeln('Apos escolher uma peca que for  valida,  o  jogo  ira');
      writeln('exibir  no   tabuleiro  as   posicoes  marcadas   com');
      writeln('asterisco(*) dos possiveis  caminhos que voce  podera');
      writeln('seguir, em seguida ira lhe perguntar  para onde  voce');
      writeln('deseja ir, repetindo isso ate que a  jogada  nao  for');
      writeln('mais possivel');
      writeln('- - - - - - - - - - - - - - - - - - - - - - - - - - -');
      writeln(' OPCOES:');
      writeln('  [V] Voltar ao Inicio');
      writeln('');
      write(' Escolha uma opcao: ');
      readln(inputAcao);
   end;
end;

procedure mostrarSobreOJogo();
begin
   inputAcao := 'ficarNoSobre';
   while (inputAcao <> 'V') do
   begin
      ClrScr;
      writeln('       ___   ___   ___  ___  ___ ');
      writeln('      / __| / _ \ | _ )| _ \| __|');
      writeln('      \__ \| (_) || _ \|   /| _| ');
      writeln('      |___/ \___/ |___/|_|_\|___|');
      writeln('- - - - - - - - - - - - - - - - - - - -');
      writeln('A verdade e que ninguem sabe exatamente');
      writeln('quando ou como o jogo  surgiu,  mas,  o');
      writeln('que e certo, e que a  Dama esta por  ai');
      writeln('ha  bastante  tempo,  tendo  sido   ate');
      writeln('mencionada por Platao como um jogo  que');
      writeln('a Grecia pegou emprestado do Egito');
      writeln('');
      writeln('Apos o jogo se popularizar na Franca  e');
      writeln('sofrer varias  mudancas  de  regras,  a');
      writeln('dama foi exportada para a Inglaterra  e');
      writeln('America, comecando a dominacao mundial');
      writeln('- - - - - - - - - - - - - - - - - - - -');
      writeln(' OPCOES:');
      writeln('  [V] Voltar ao Inicio');
      writeln('');
      write(' Escolha uma opcao: ');
      readln(inputAcao);
   end;
end;

// { mostrando menu principal e Sobre ----------------------------------}
procedure mostrarMenuPrincipal();
begin
   inputAcao := 'ficarNoMenu';
   while (inputAcao <> 'J') do begin
      ClrScr;
      writeln('- - - - - - - - - - - - - - - - - -_- - - -');
      writeln('  \ \   Seja bem-vindo(a) ao      | |      ');
      writeln('   \ \   ___    __ _   ___      __| |  ___ ');
      writeln('    \ \ / _ \  / _` | / _ \    / _` | / _ \');
      writeln(' /\_/ /| (_) || (_| || (_) |  | (_| ||  __/');
      writeln(' \___/  \___/  \__, | \___/    \__,_| \___|');
      writeln('   ___         |___/               ____   ');
      writeln('  |  _ \   __ _  _ __ ___    __ _ / ___| ');
      writeln('  | | | | / _` || ''_ ` _ \  / _` |\___ \ ');
      writeln('  | |_| || (_) || | | | | || (_) | ___) |');
      writeln('  |____/  \__,_||_| |_| |_| \__,_|/____/ ');
      writeln('- - - - - - - - - - - - - - - - - - - - - -');
      writeln(' OPCOES:');
      writeln('  [J] Jogar');
      writeln('  [T] Tutorial ');
      writeln('  [S] Sobre o jogo');
      writeln('');
      write(' Escolha uma opcao: ');
      readln(inputAcao);
      case (inputAcao) of
      'T' : mostrarTutorial();
      'S' : mostrarSobreOJogo();
      end;
   end;
end;

// { definindo os locais das peças do jogo -----------------------------}
procedure definirPecasDoJogo();
begin
   locaisDoTabuleiro[1,1] := 'x';
   locaisDoTabuleiro[1,3] := 'x';
   locaisDoTabuleiro[1,5] := 'x';
   locaisDoTabuleiro[1,7] := 'x';
   locaisDoTabuleiro[2,2] := 'x';
   locaisDoTabuleiro[2,4] := 'x';
   locaisDoTabuleiro[2,6] := 'x';
   locaisDoTabuleiro[2,8] := 'x';
   locaisDoTabuleiro[3,1] := 'x';
   locaisDoTabuleiro[3,3] := 'x';
   locaisDoTabuleiro[3,5] := 'x';
   locaisDoTabuleiro[3,7] := 'x';

   locaisDoTabuleiro[6,2] := 'y';
   locaisDoTabuleiro[6,4] := 'y';
   locaisDoTabuleiro[6,6] := 'y';
   locaisDoTabuleiro[6,8] := 'y';
   locaisDoTabuleiro[7,1] := 'y';
   locaisDoTabuleiro[7,3] := 'y';
   locaisDoTabuleiro[7,5] := 'y';
   locaisDoTabuleiro[7,7] := 'y';
   locaisDoTabuleiro[8,2] := 'y';
   locaisDoTabuleiro[8,4] := 'y';
   locaisDoTabuleiro[8,6] := 'y';
   locaisDoTabuleiro[8,8] := 'y';
end;

// { mostrando cabeçalho na tela ---------------------------------------}
procedure mostrarCabecalho();
begin
   writeln('------------------------------');
   write('      VEZ DO JOGADOR: ');
   if(jogadorDaVez = 1)then begin
      writeln('X');
   end else begin
      writeln('Y');
   end;
   writeln('------------------------------');
   writeln(' PLACAR:      X->',pontosTimeX,'     Y->',pontosTimeY);
end;

// {apagar caminhos possiveis no tabuleiro}
procedure apagarCaminhos();
var
contadorLinha:integer;
begin
   for contadorLinha :=  1 to 4 do begin
      if(caminhosPossiveis[contadorLinha,1] <> 0)then begin
         locaisDoTabuleiro[caminhosPossiveis[contadorLinha,1],caminhosPossiveis[contadorLinha,2]] := '';
         caminhosPossiveis[contadorLinha,1] := 0;
         caminhosPossiveis[contadorLinha,2] := 0;
         caminhosPossiveis[contadorLinha,3] := 0;
         caminhosPossiveis[contadorLinha,4] := 0;
      end;
   end;
   posDaVezVetorDamas := 1;
   for contadorLinha :=  1 to 13 do begin
      if(caminhosPossiveisDama[contadorLinha,1] <> 0)then begin
         locaisDoTabuleiro[caminhosPossiveisDama[contadorLinha,1],caminhosPossiveisDama[contadorLinha,2]] := '';
         caminhosPossiveisDama[contadorLinha,1] := 0;
         caminhosPossiveisDama[contadorLinha,2] := 0;
         caminhosPossiveisDama[contadorLinha,3] := 0;
         caminhosPossiveisDama[contadorLinha,4] := 0;
      end;
   end;
end;

// { procedimento para trocar de jogador}
procedure trocarJogador();
begin
   if(jogadorDaVez = 1)then begin
      jogadorDaVez := 2;
   end else begin
      jogadorDaVez := 1;
   end;
end;

// { validar se posição informada está dentro do tabuleiro (8x8) -------}
function validarPosicao(linha,coluna:integer):boolean;
begin
   if((linha >= 1) and (linha <= 8))then begin
      if((coluna >= 1) and (coluna <= 8))then begin
         validarPosicao := true;
      end else begin
         validarPosicao := false;
      end;
   end else begin
      validarPosicao := false;
   end;
end;

// { verificar se peça pode capturar para algum lado -------------------}
function pecaPodeCapturar(linha,coluna,marcarPosicao:integer):boolean;
var
podeCapturar,chegouNoLimite:boolean;
contador:integer;
posicaoPecaCapturada: array[1..2] of integer;
begin
   podeCapturar := false;

   // {verificação das peças normais}
   if((locaisDoTabuleiro[linha,coluna] = 'x') or (locaisDoTabuleiro[linha,coluna] = 'y'))then begin
      // { verificar para o Jogador 1 (X)}
      if(jogadorDaVez = 1)then begin
         // { capturar para esquerda superior}
         if(validarPosicao(linha+1,coluna-1))then begin
            if((locaisDoTabuleiro[linha+1,coluna-1] = 'y') or (locaisDoTabuleiro[linha+1,coluna-1] = 'Y'))then begin
               if(validarPosicao(linha+2,coluna-2))then begin
                  if(locaisDoTabuleiro[linha+2,coluna-2] = '')then begin
                     podeCapturar := true;
                     if(marcarPosicao = 1)then begin
                        caminhosPossiveis[1,1] := linha+2;
                        caminhosPossiveis[1,2] := coluna-2;
                        caminhosPossiveis[1,3] := linha+1;
                        caminhosPossiveis[1,4] := coluna-1;
                     end;
                  end;
               end;
            end;
         end;

         // {capturar para direita superior}
         if(validarPosicao(linha+1,coluna+1))then begin
            if((locaisDoTabuleiro[linha+1,coluna+1] = 'y') or (locaisDoTabuleiro[linha+1,coluna+1] = 'Y'))then begin
               if(validarPosicao(linha+2,coluna+2))then begin
                  if(locaisDoTabuleiro[linha+2,coluna+2] = '')then begin
                     podeCapturar := true;
                     if(marcarPosicao = 1)then begin
                        caminhosPossiveis[2,1] := linha+2;
                        caminhosPossiveis[2,2] := coluna+2;
                        caminhosPossiveis[2,3] := linha+1;
                        caminhosPossiveis[2,4] := coluna+1;
                     end;
                  end;
               end;
            end;
         end;

         // {capturar para direita inferior}
         if(validarPosicao(linha-1,coluna+1))then begin
            if((locaisDoTabuleiro[linha-1,coluna+1] = 'y') or (locaisDoTabuleiro[linha-1,coluna+1] = 'Y'))then begin
               if(validarPosicao(linha-2,coluna+2))then begin
                  if(locaisDoTabuleiro[linha-2,coluna+2] = '')then begin
                     podeCapturar := true;
                     if(marcarPosicao = 1)then begin
                        caminhosPossiveis[3,1] := linha-2;
                        caminhosPossiveis[3,2] := coluna+2;
                        caminhosPossiveis[3,3] := linha-1;
                        caminhosPossiveis[3,4] := coluna+1;
                     end;
                  end;
               end;
            end;
         end;

         // {capturar para esquerda inferior}
         if(validarPosicao(linha-1,coluna-1))then begin
            if((locaisDoTabuleiro[linha-1,coluna-1] = 'y') or (locaisDoTabuleiro[linha-1,coluna-1] = 'Y'))then begin
               if(validarPosicao(linha-2,coluna-2))then begin
                  if(locaisDoTabuleiro[linha-2,coluna-2] = '')then begin
                     podeCapturar := true;
                     if(marcarPosicao = 1)then begin
                        caminhosPossiveis[4,1] := linha-2;
                        caminhosPossiveis[4,2] := coluna-2;
                        caminhosPossiveis[4,3] := linha-1;
                        caminhosPossiveis[4,4] := coluna-1;
                     end;
                  end;
               end;
            end;
         end;

         // {verificar para jogador 2 (Y)}
      end else begin
         // { capturar para esquerda superior}
         if(validarPosicao(linha+1,coluna-1))then begin
            if((locaisDoTabuleiro[linha+1,coluna-1] = 'x') or (locaisDoTabuleiro[linha+1,coluna-1] = 'X'))then begin
               if(validarPosicao(linha+2,coluna-2))then begin
                  if(locaisDoTabuleiro[linha+2,coluna-2] = '')then begin
                     podeCapturar := true;
                     if(marcarPosicao = 1)then begin
                        caminhosPossiveis[1,1] := linha+2;
                        caminhosPossiveis[1,2] := coluna-2;
                        caminhosPossiveis[1,3] := linha+1;
                        caminhosPossiveis[1,4] := coluna-1;
                     end;
                  end;
               end;
            end;
         end;

         // {capturar para direita superior}
         if(validarPosicao(linha+1,coluna+1))then begin
            if((locaisDoTabuleiro[linha+1,coluna+1] = 'x') or (locaisDoTabuleiro[linha+1,coluna+1] = 'X'))then begin
               if(validarPosicao(linha+2,coluna+2))then begin
                  if(locaisDoTabuleiro[linha+2,coluna+2] = '')then begin
                     podeCapturar := true;
                     if(marcarPosicao = 1)then begin
                        caminhosPossiveis[2,1] := linha+2;
                        caminhosPossiveis[2,2] := coluna+2;
                        caminhosPossiveis[2,3] := linha+1;
                        caminhosPossiveis[2,4] := coluna+1;
                     end;
                  end;
               end;
            end;
         end;

         // {capturar para direita inferior}
         if(validarPosicao(linha-1,coluna+1))then begin
            if((locaisDoTabuleiro[linha-1,coluna+1] = 'x') or (locaisDoTabuleiro[linha-1,coluna+1] = 'X'))then begin
               if(validarPosicao(linha-2,coluna+2))then begin
                  if(locaisDoTabuleiro[linha-2,coluna+2] = '')then begin
                     podeCapturar := true;
                     if(marcarPosicao = 1)then begin
                        caminhosPossiveis[3,1] := linha-2;
                        caminhosPossiveis[3,2] := coluna+2;
                        caminhosPossiveis[3,3] := linha-1;
                        caminhosPossiveis[3,4] := coluna+1;
                     end;
                  end;
               end;
            end;
         end;

         // {capturar para esquerda inferior}
         if(validarPosicao(linha-1,coluna-1))then begin
            if((locaisDoTabuleiro[linha-1,coluna-1] = 'x') or (locaisDoTabuleiro[linha-1,coluna-1] = 'X'))then begin
               if(validarPosicao(linha-2,coluna-2))then begin
                  if(locaisDoTabuleiro[linha-2,coluna-2] = '')then begin
                     podeCapturar := true;
                     if(marcarPosicao = 1)then begin
                        caminhosPossiveis[4,1] := linha-2;
                        caminhosPossiveis[4,2] := coluna-2;
                        caminhosPossiveis[4,3] := linha-1;
                        caminhosPossiveis[4,4] := coluna-1;
                     end;
                  end;
               end;
            end;
         end;
      end;
      // {verificação para as peças DAMAS}
   end else begin
      // {verificação peças X}
      if(locaisDoTabuleiro[linha,coluna] = 'X')then begin

         // { verificando casas diagonal superior esquerda}
         chegouNoLimite := false;
         contador := 1;
         while (not chegouNoLimite) do begin
            if(validarPosicao(linha+contador,coluna-contador))then begin
               if((locaisDoTabuleiro[linha+contador,coluna-contador] = 'y') or (locaisDoTabuleiro[linha+contador,coluna-contador] = 'Y'))then begin
                  if(validarPosicao(linha+contador+1,coluna-contador-1))then begin
                     if(locaisDoTabuleiro[linha+contador+1,coluna-contador-1] = '')then begin
                        if(marcarPosicao = 1)then begin
                           posicaoPecaCapturada[1] := linha+contador;
                           posicaoPecaCapturada[2] := coluna-contador;
                        end;
                        podeCapturar := true;
                        if(marcarPosicao = 1)then begin
                           while (not chegouNoLimite) do begin
                              if(validarPosicao(linha+contador+1,coluna-contador-1))then begin
                                 if(locaisDoTabuleiro[linha+contador+1,coluna-contador-1] = '')then begin
                                    caminhosPossiveisDama[posDaVezVetorDamas,1] := linha+contador+1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,2] := coluna-contador-1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,3] := posicaoPecaCapturada[1];
                                    caminhosPossiveisDama[posDaVezVetorDamas,4] := posicaoPecaCapturada[2];
                                    posDaVezVetorDamas := posDaVezVetorDamas+1;
                                 end else begin
                                    chegouNoLimite := true;
                                 end;
                              end else begin
                                 chegouNoLimite := true;
                              end;
                              contador := contador + 1;
                           end;
                        end;
                     end else begin
                        chegouNoLimite := true;
                     end;
                  end else begin
                     chegouNoLimite := true;
                  end;
               end else begin
                  if(not (locaisDoTabuleiro[linha+contador,coluna-contador] = ''))then begin
                     chegouNoLimite := true;
                  end;
               end;
            end else begin
               chegouNoLimite := true;
            end;
            contador := contador + 1;
         end;
         chegouNoLimite := false;
         contador := 1;

         // { verificando casas diagonal superior direita}
         chegouNoLimite := false;
         contador := 1;
         while (not chegouNoLimite) do begin
            if(validarPosicao(linha+contador,coluna+contador))then begin
               if((locaisDoTabuleiro[linha+contador,coluna+contador] = 'y') or (locaisDoTabuleiro[linha+contador,coluna+contador] = 'Y'))then begin
                  if(validarPosicao(linha+contador+1,coluna+contador+1))then begin
                     if(locaisDoTabuleiro[linha+contador+1,coluna+contador+1] = '')then begin
                        if(marcarPosicao = 1)then begin
                           posicaoPecaCapturada[1] := linha+contador;
                           posicaoPecaCapturada[2] := coluna+contador;
                        end;
                        podeCapturar := true;
                        if(marcarPosicao = 1)then begin
                           while (not chegouNoLimite) do begin
                              if(validarPosicao(linha+contador+1,coluna+contador+1))then begin
                                 if(locaisDoTabuleiro[linha+contador+1,coluna+contador+1] = '')then begin
                                    caminhosPossiveisDama[posDaVezVetorDamas,1] := linha+contador+1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,2] := coluna+contador+1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,3] := posicaoPecaCapturada[1];
                                    caminhosPossiveisDama[posDaVezVetorDamas,4] := posicaoPecaCapturada[2];
                                    posDaVezVetorDamas := posDaVezVetorDamas+1;
                                 end else begin
                                    chegouNoLimite := true;
                                 end;
                              end else begin
                                 chegouNoLimite := true;
                              end;
                              contador := contador + 1;
                           end;
                        end;
                     end else begin
                        chegouNoLimite := true;
                     end;
                  end else begin
                     chegouNoLimite := true;
                  end;
               end else begin
                  if(not (locaisDoTabuleiro[linha+contador,coluna+contador] = ''))then begin
                     chegouNoLimite := true;
                  end;
               end;
            end else begin
               chegouNoLimite := true;
            end;
            contador := contador + 1;
         end;
         chegouNoLimite := false;
         contador := 1;

         // { verificando casas diagonal inferior direita}
         chegouNoLimite := false;
         contador := 1;
         while (not chegouNoLimite) do begin
            if(validarPosicao(linha-contador,coluna+contador))then begin
               if((locaisDoTabuleiro[linha-contador,coluna+contador] = 'y') or (locaisDoTabuleiro[linha-contador,coluna+contador] = 'Y'))then begin
                  if(validarPosicao(linha-contador-1,coluna+contador+1))then begin
                     if(locaisDoTabuleiro[linha-contador-1,coluna+contador+1] = '')then begin
                        if(marcarPosicao = 1)then begin
                           posicaoPecaCapturada[1] := linha-contador;
                           posicaoPecaCapturada[2] := coluna+contador;
                        end;
                        podeCapturar := true;
                        if(marcarPosicao = 1)then begin
                           while (not chegouNoLimite) do begin
                              if(validarPosicao(linha-contador-1,coluna+contador+1))then begin
                                 if(locaisDoTabuleiro[linha-contador-1,coluna+contador+1] = '')then begin
                                    caminhosPossiveisDama[posDaVezVetorDamas,1] := linha-contador-1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,2] := coluna+contador+1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,3] := posicaoPecaCapturada[1];
                                    caminhosPossiveisDama[posDaVezVetorDamas,4] := posicaoPecaCapturada[2];
                                    posDaVezVetorDamas := posDaVezVetorDamas+1;
                                 end else begin
                                    chegouNoLimite := true;
                                 end;
                              end else begin
                                 chegouNoLimite := true;
                              end;
                              contador := contador + 1;
                           end;
                        end;
                     end else begin
                        chegouNoLimite := true;
                     end;
                  end else begin
                     chegouNoLimite := true;
                  end;
               end else begin
                  if(not (locaisDoTabuleiro[linha-contador,coluna+contador] = ''))then begin
                     chegouNoLimite := true;
                  end;
               end;
            end else begin
               chegouNoLimite := true;
            end;
            contador := contador + 1;
         end;
         chegouNoLimite := false;
         contador := 1;

         // { verificando casas diagonal inferior esquerda}
         chegouNoLimite := false;
         contador := 1;
         while (not chegouNoLimite) do begin
            if(validarPosicao(linha-contador,coluna-contador))then begin
               if((locaisDoTabuleiro[linha-contador,coluna-contador] = 'y') or (locaisDoTabuleiro[linha-contador,coluna-contador] = 'Y'))then begin
                  if(validarPosicao(linha-contador-1,coluna-contador-1))then begin
                     if(locaisDoTabuleiro[linha-contador-1,coluna-contador-1] = '')then begin
                        if(marcarPosicao = 1)then begin
                           posicaoPecaCapturada[1] := linha-contador;
                           posicaoPecaCapturada[2] := coluna-contador;
                        end;
                        podeCapturar := true;
                        if(marcarPosicao = 1)then begin
                           while (not chegouNoLimite) do begin
                              if(validarPosicao(linha-contador-1,coluna-contador-1))then begin
                                 if(locaisDoTabuleiro[linha-contador-1,coluna-contador-1] = '')then begin
                                    caminhosPossiveisDama[posDaVezVetorDamas,1] := linha-contador-1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,2] := coluna-contador-1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,3] := posicaoPecaCapturada[1];
                                    caminhosPossiveisDama[posDaVezVetorDamas,4] := posicaoPecaCapturada[2];
                                    posDaVezVetorDamas := posDaVezVetorDamas+1;
                                 end else begin
                                    chegouNoLimite := true;
                                 end;
                              end else begin
                                 chegouNoLimite := true;
                              end;
                              contador := contador + 1;
                           end;
                        end;
                     end else begin
                        chegouNoLimite := true;
                     end;
                  end else begin
                     chegouNoLimite := true;
                  end;
               end else begin
                  if(not (locaisDoTabuleiro[linha-contador,coluna-contador] = ''))then begin
                     chegouNoLimite := true;
                  end;
               end;
            end else begin
               chegouNoLimite := true;
            end;
            contador := contador + 1;
         end;
         chegouNoLimite := false;
         contador := 1;

         // { verificar peças Y}
      end else begin

         // { verificando casas diagonal superior esquerda}
         chegouNoLimite := false;
         contador := 1;
         while (not chegouNoLimite) do begin
            if(validarPosicao(linha+contador,coluna-contador))then begin
               if((locaisDoTabuleiro[linha+contador,coluna-contador] = 'x') or (locaisDoTabuleiro[linha+contador,coluna-contador] = 'X'))then begin
                  if(validarPosicao(linha+contador+1,coluna-contador-1))then begin
                     if(locaisDoTabuleiro[linha+contador+1,coluna-contador-1] = '')then begin
                        if(marcarPosicao = 1)then begin
                           posicaoPecaCapturada[1] := linha+contador;
                           posicaoPecaCapturada[2] := coluna-contador;
                        end;
                        podeCapturar := true;
                        if(marcarPosicao = 1)then begin
                           while (not chegouNoLimite) do begin
                              if(validarPosicao(linha+contador+1,coluna-contador-1))then begin
                                 if(locaisDoTabuleiro[linha+contador+1,coluna-contador-1] = '')then begin
                                    caminhosPossiveisDama[posDaVezVetorDamas,1] := linha+contador+1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,2] := coluna-contador-1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,3] := posicaoPecaCapturada[1];
                                    caminhosPossiveisDama[posDaVezVetorDamas,4] := posicaoPecaCapturada[2];
                                    posDaVezVetorDamas := posDaVezVetorDamas+1;
                                 end else begin
                                    chegouNoLimite := true;
                                 end;
                              end else begin
                                 chegouNoLimite := true;
                              end;
                              contador := contador + 1;
                           end;
                        end;
                     end else begin
                        chegouNoLimite := true;
                     end;
                  end else begin
                     chegouNoLimite := true;
                  end;
               end else begin
                  if(not (locaisDoTabuleiro[linha+contador,coluna-contador] = ''))then begin
                     chegouNoLimite := true;
                  end;
               end;
            end else begin
               chegouNoLimite := true;
            end;
            contador := contador + 1;
         end;
         chegouNoLimite := false;
         contador := 1;

         // { verificando casas diagonal superior direita}
         chegouNoLimite := false;
         contador := 1;
         while (not chegouNoLimite) do begin
            if(validarPosicao(linha+contador,coluna+contador))then begin
               if((locaisDoTabuleiro[linha+contador,coluna+contador] = 'x') or (locaisDoTabuleiro[linha+contador,coluna+contador] = 'X'))then begin
                  if(validarPosicao(linha+contador+1,coluna+contador+1))then begin
                     if(locaisDoTabuleiro[linha+contador+1,coluna+contador+1] = '')then begin
                        if(marcarPosicao = 1)then begin
                           posicaoPecaCapturada[1] := linha+contador;
                           posicaoPecaCapturada[2] := coluna+contador;
                        end;
                        podeCapturar := true;
                        if(marcarPosicao = 1)then begin
                           while (not chegouNoLimite) do begin
                              if(validarPosicao(linha+contador+1,coluna+contador+1))then begin
                                 if(locaisDoTabuleiro[linha+contador+1,coluna+contador+1] = '')then begin
                                    caminhosPossiveisDama[posDaVezVetorDamas,1] := linha+contador+1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,2] := coluna+contador+1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,3] := posicaoPecaCapturada[1];
                                    caminhosPossiveisDama[posDaVezVetorDamas,4] := posicaoPecaCapturada[2];
                                    posDaVezVetorDamas := posDaVezVetorDamas+1;
                                 end else begin
                                    chegouNoLimite := true;
                                 end;
                              end else begin
                                 chegouNoLimite := true;
                              end;
                              contador := contador + 1;
                           end;
                        end;
                     end else begin
                        chegouNoLimite := true;
                     end;
                  end else begin
                     chegouNoLimite := true;
                  end;
               end else begin
                  if(not (locaisDoTabuleiro[linha+contador,coluna+contador] = ''))then begin
                     chegouNoLimite := true;
                  end;
               end;
            end else begin
               chegouNoLimite := true;
            end;
            contador := contador + 1;
         end;
         chegouNoLimite := false;
         contador := 1;

         // { verificando casas diagonal inferior direita}
         chegouNoLimite := false;
         contador := 1;
         while (not chegouNoLimite) do begin
            if(validarPosicao(linha-contador,coluna+contador))then begin
               if((locaisDoTabuleiro[linha-contador,coluna+contador] = 'x') or (locaisDoTabuleiro[linha-contador,coluna+contador] = 'X'))then begin
                  if(validarPosicao(linha-contador-1,coluna+contador+1))then begin
                     if(locaisDoTabuleiro[linha-contador-1,coluna+contador+1] = '')then begin
                        if(marcarPosicao = 1)then begin
                           posicaoPecaCapturada[1] := linha-contador;
                           posicaoPecaCapturada[2] := coluna+contador;
                        end;
                        podeCapturar := true;
                        if(marcarPosicao = 1)then begin
                           while (not chegouNoLimite) do begin
                              if(validarPosicao(linha-contador-1,coluna+contador+1))then begin
                                 if(locaisDoTabuleiro[linha-contador-1,coluna+contador+1] = '')then begin
                                    caminhosPossiveisDama[posDaVezVetorDamas,1] := linha-contador-1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,2] := coluna+contador+1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,3] := posicaoPecaCapturada[1];
                                    caminhosPossiveisDama[posDaVezVetorDamas,4] := posicaoPecaCapturada[2];
                                    posDaVezVetorDamas := posDaVezVetorDamas+1;
                                 end else begin
                                    chegouNoLimite := true;
                                 end;
                              end else begin
                                 chegouNoLimite := true;
                              end;
                              contador := contador + 1;
                           end;
                        end;
                     end else begin
                        chegouNoLimite := true;
                     end;
                  end else begin
                     chegouNoLimite := true;
                  end;
               end else begin
                  if(not (locaisDoTabuleiro[linha-contador,coluna+contador] = ''))then begin
                     chegouNoLimite := true;
                  end;
               end;
            end else begin
               chegouNoLimite := true;
            end;
            contador := contador + 1;
         end;
         chegouNoLimite := false;
         contador := 1;

         // { verificando casas diagonal inferior esquerda}
         chegouNoLimite := false;
         contador := 1;
         while (not chegouNoLimite) do begin
            if(validarPosicao(linha-contador,coluna-contador))then begin
               if((locaisDoTabuleiro[linha-contador,coluna-contador] = 'x') or (locaisDoTabuleiro[linha-contador,coluna-contador] = 'X'))then begin
                  if(validarPosicao(linha-contador-1,coluna-contador-1))then begin
                     if(locaisDoTabuleiro[linha-contador-1,coluna-contador-1] = '')then begin
                        if(marcarPosicao = 1)then begin
                           posicaoPecaCapturada[1] := linha-contador;
                           posicaoPecaCapturada[2] := coluna-contador;
                        end;
                        podeCapturar := true;
                        if(marcarPosicao = 1)then begin
                           while (not chegouNoLimite) do begin
                              if(validarPosicao(linha-contador-1,coluna-contador-1))then begin
                                 if(locaisDoTabuleiro[linha-contador-1,coluna-contador-1] = '')then begin
                                    caminhosPossiveisDama[posDaVezVetorDamas,1] := linha-contador-1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,2] := coluna-contador-1;
                                    caminhosPossiveisDama[posDaVezVetorDamas,3] := posicaoPecaCapturada[1];
                                    caminhosPossiveisDama[posDaVezVetorDamas,4] := posicaoPecaCapturada[2];
                                    posDaVezVetorDamas := posDaVezVetorDamas+1;
                                 end else begin
                                    chegouNoLimite := true;
                                 end;
                              end else begin
                                 chegouNoLimite := true;
                              end;
                              contador := contador + 1;
                           end;
                        end;
                     end else begin
                        chegouNoLimite := true;
                     end;
                  end else begin
                     chegouNoLimite := true;
                  end;
               end else begin
                  if(not (locaisDoTabuleiro[linha-contador,coluna-contador] = ''))then begin
                     chegouNoLimite := true;
                  end;
               end;
            end else begin
               chegouNoLimite := true;
            end;
            contador := contador + 1;
         end;
         chegouNoLimite := false;
         contador := 1;

      end;
   end;

   pecaPodeCapturar := podeCapturar;
end;

// { verificar se outras peças do tabuleiro podem capturar -------------}
function outraPecaPodeCapturar():boolean;
var
outraPecaDeveCapturar: boolean;
linha,coluna: integer;
begin
   outraPecaDeveCapturar := false;

   // { verificar peças do jogador 1}
   if(jogadorDaVez = 1)then begin
      for linha :=  1 to 8 do begin
         for coluna :=  1 to 8 do begin
            if((locaisDoTabuleiro[linha,coluna] = 'x') or (locaisDoTabuleiro[linha,coluna] = 'X'))then begin
               if(pecaPodeCapturar(linha,coluna,0))then begin
                  outraPecaDeveCapturar := true;
               end;
            end;
         end;
      end;
      // { verificar peças do jogador 2}
   end else begin
      for linha :=  1 to 8 do begin
         for coluna :=  1 to 8 do begin
            if((locaisDoTabuleiro[linha,coluna] = 'y') or (locaisDoTabuleiro[linha,coluna] = 'Y'))then begin
               if(pecaPodeCapturar(linha,coluna,0))then begin
                  outraPecaDeveCapturar := true;
               end;
            end;
         end;
      end;
   end;

   outraPecaPodeCapturar := outraPecaDeveCapturar;
end;

// { verificar se peça pode se mover para algum lado -------------------}
function pecaPodeSeMover(linha,coluna,marcarPosicao:integer):boolean;
var
podeSeMover,estaNoLimite:boolean;
contador:integer;
begin
   estaNoLimite := false;
   podeSeMover := false;

   // {verificar se a peça é normal ou é uma Dama}
   if((locaisDoTabuleiro[linha,coluna] = 'x') or (locaisDoTabuleiro[linha,coluna] = 'y'))then begin
      // {verificar a peça X do Jogador 1}
      if(jogadorDaVez = 1)then begin

         // {verificar se pode mover para diagonal superior esquerda}
         if(validarPosicao(linha+1,coluna-1))then begin
            if(locaisDoTabuleiro[linha+1,coluna-1] = '')then begin
               podeSeMover := true;
               if(marcarPosicao = 1)then begin
                  caminhosPossiveis[1,1] := linha+1;
                  caminhosPossiveis[1,2] := coluna-1;
               end;
            end;
         end;

         // {verificar se pode mover para diagonal superior direira}
         if(validarPosicao(linha+1,coluna+1))then begin
            if(locaisDoTabuleiro[linha+1,coluna+1] = '')then begin
               podeSeMover := true;
               if(marcarPosicao = 1)then begin
                  caminhosPossiveis[2,1] := linha+1;
                  caminhosPossiveis[2,2] := coluna+1;
               end;
            end;
         end;

         // {verificar a peça Y do Jogador 2}
      end else begin

         // {verificar se pode mover para diagonal inferior direira}
         if(validarPosicao(linha-1,coluna+1))then begin
            if(locaisDoTabuleiro[linha-1,coluna+1] = '')then begin
               podeSeMover := true;
               if(marcarPosicao = 1)then begin
                  caminhosPossiveis[3,1] := linha-1;
                  caminhosPossiveis[3,2] := coluna+1;
               end;
            end;
         end;

         // {verificar se pode mover para diagonal inferior esquerda}
         if(validarPosicao(linha-1,coluna-1))then begin
            if(locaisDoTabuleiro[linha-1,coluna-1] = '')then begin
               podeSeMover := true;
               if(marcarPosicao = 1)then begin
                  caminhosPossiveis[4,1] := linha-1;
                  caminhosPossiveis[4,2] := coluna-1;
               end;
            end;
         end;
      end;
      // {verificar as Damas}
   end else begin
      // { VERIFICAÇÃO DIAGONAL ESQUERDA SUPERIOR}
      estaNoLimite := false;
      contador := 1;
      while (not estaNoLimite) do begin
         if(validarPosicao(linha+contador,coluna-contador))then begin
            if(locaisDoTabuleiro[linha+contador,coluna-contador] = '')then begin
               podeSeMover := true;
               if(marcarPosicao = 1)then begin
                  caminhosPossiveisDama[posDaVezVetorDamas,1] := linha+contador;
                  caminhosPossiveisDama[posDaVezVetorDamas,2] := coluna-contador;

                  posDaVezVetorDamas := posDaVezVetorDamas + 1;
               end else begin
                  estaNoLimite := true;
               end;
            end else begin
               estaNoLimite := true;
            end;
         end else begin
            estaNoLimite := true;
         end;
         contador := contador + 1;
      end;

      // { VERIFICAÇÃO DIAGONAL DIREITA SUPERIOR}
      estaNoLimite := false;
      contador := 1;
      while (not estaNoLimite) do begin
         if(validarPosicao(linha+contador,coluna+contador))then begin
            if(locaisDoTabuleiro[linha+contador,coluna+contador] = '')then begin
               podeSeMover := true;
               if(marcarPosicao = 1)then begin
                  caminhosPossiveisDama[posDaVezVetorDamas,1] := linha+contador;
                  caminhosPossiveisDama[posDaVezVetorDamas,2] := coluna+contador;

                  posDaVezVetorDamas := posDaVezVetorDamas + 1;
               end else begin
                  estaNoLimite := true;
               end;
            end else begin
               estaNoLimite := true;
            end;
         end else begin
            estaNoLimite := true;
         end;
         contador := contador + 1;
      end;

      // { VERIFICAÇÃO DIAGONAL DIREITA INFERIOR}
      estaNoLimite := false;
      contador := 1;
      while (not estaNoLimite) do begin
         if(validarPosicao(linha-contador,coluna+contador))then begin
            if(locaisDoTabuleiro[linha-contador,coluna+contador] = '')then begin
               podeSeMover := true;
               if(marcarPosicao = 1)then begin
                  caminhosPossiveisDama[posDaVezVetorDamas,1] := linha-contador;
                  caminhosPossiveisDama[posDaVezVetorDamas,2] := coluna+contador;

                  posDaVezVetorDamas := posDaVezVetorDamas + 1;
               end else begin
                  estaNoLimite := true;
               end;
            end else begin
               estaNoLimite := true;
            end;
         end else begin
            estaNoLimite := true;
         end;
         contador := contador + 1;
      end;

      // { VERIFICAÇÃO DIAGONAL DIREITA INFERIOR}
      estaNoLimite := false;
      contador := 1;
      while (not estaNoLimite) do begin
         if(validarPosicao(linha-contador,coluna-contador))then begin
            if(locaisDoTabuleiro[linha-contador,coluna-contador] = '')then begin
               podeSeMover := true;
               if(marcarPosicao = 1)then begin
                  caminhosPossiveisDama[posDaVezVetorDamas,1] := linha-contador;
                  caminhosPossiveisDama[posDaVezVetorDamas,2] := coluna-contador;

                  posDaVezVetorDamas := posDaVezVetorDamas + 1;
               end else begin
                  estaNoLimite := true;
               end;
            end else begin
               estaNoLimite := true;
            end;
         end else begin
            estaNoLimite := true;
         end;
         contador := contador + 1;
      end;
   end;
   pecaPodeSeMover := podeSeMover;
end;

// { perguntar qual posição do tabuleiro -------------------------------}
procedure perguntarPosicaoAtual();
var
posicaoValida: boolean;
linha,coluna: integer;
begin
   posicaoValida := false;
   while (not posicaoValida) do begin
      write(' -> linha: ');
      readln(linha);
      write(' -> coluna: ');
      readln(coluna);
      if((linha = 0) and (coluna = 0))then begin
         fimDeJogo := true;
         posicaoValida := true;
      end;
      if((validarPosicao(linha,coluna)) and (not fimDeJogo))then begin
         // {JOGADOR 1}
         if(jogadorDaVez = 1)then begin
            if ((locaisDoTabuleiro[linha,coluna] = 'x') or (locaisDoTabuleiro[linha,coluna] = 'X')) then begin
               if(pecaPodeCapturar(linha,coluna,0))then begin
                  posicaoPecaAtual[1] := linha;
                  posicaoPecaAtual[2] := coluna;
                  posicaoValida := true;
               end else begin
                  if(outraPecaPodeCapturar())then begin
                     writeln('Inválida (outra peça do seu tabuleiro deve Capturar)...');
                  end else begin
                     if(pecaPodeSeMover(linha,coluna,0))then begin
                        posicaoPecaAtual[1] := linha;
                        posicaoPecaAtual[2] := coluna;
                        posicaoValida := true;
                     end else begin
                        writeln('Inválida (impossível mover esta pessa)...');
                     end;
                  end;
               end;
            end else begin
               if ((locaisDoTabuleiro[linha,coluna] = 'y') or (locaisDoTabuleiro[linha,coluna] = 'Y')) then begin
                  writeln('Inválida (peça adversária)...');
               end else begin
                  writeln('Inválida (local vazio)...');
               end;
            end;
            // {JOGADOR 2}
         end else begin
            if ((locaisDoTabuleiro[linha,coluna] = 'y') or (locaisDoTabuleiro[linha,coluna] = 'Y')) then begin
               if(pecaPodeCapturar(linha,coluna,0))then begin
                  posicaoPecaAtual[1] := linha;
                  posicaoPecaAtual[2] := coluna;
                  posicaoValida := true;
               end else begin
                  if(outraPecaPodeCapturar())then begin
                     writeln('Invalida (outra peca do seu tabuleiro deve capturar)...');
                  end else begin
                     if(pecaPodeSeMover(linha,coluna,0))then begin
                        posicaoPecaAtual[1] := linha;
                        posicaoPecaAtual[2] := coluna;
                        posicaoValida := true;
                     end else begin
                        writeln('Invalida (impossivel mover esta peca)...');
                     end;
                  end;
               end;
            end else begin
               if ((locaisDoTabuleiro[linha,coluna] = 'x') or (locaisDoTabuleiro[linha,coluna] = 'X')) then begin
                  writeln('Invalida (peca adversaria)...');
               end else begin
                  writeln('Invalida (local vazio)...');
               end;
            end;
         end;
      end else begin
         writeln('Invalida (posicao inexistente)...');
      end;
   end;
end;

// { marcar no tabuleiro os possíveis caminhos da peça}
procedure exibirCaminhosPossiveis(linhaDaPeca,colunaDaPeca:integer);
var
contadorLinha,linha,coluna:integer;
begin
   if ((locaisDoTabuleiro[linhaDaPeca,colunaDaPeca] = 'x') or (locaisDoTabuleiro[linhaDaPeca,colunaDaPeca] = 'y')) then begin
      if(pecaPodeCapturar(linhaDaPeca,colunaDaPeca,1))then begin
         for contadorLinha :=  1 to 4 do begin
            if(caminhosPossiveis[contadorLinha,1] <> 0)then begin
               linha := caminhosPossiveis[contadorLinha,1];
               coluna := caminhosPossiveis[contadorLinha,2];
               locaisDoTabuleiro[linha,coluna] := '*';
            end;
         end;
      end else begin
         if(pecaPodeSeMover(linhaDaPeca,colunaDaPeca,1))then begin
            for contadorLinha :=  1 to 4 do begin
               if(caminhosPossiveis[contadorLinha,1] <> 0)then begin
                  linha := caminhosPossiveis[contadorLinha,1];
                  coluna := caminhosPossiveis[contadorLinha,2];
                  locaisDoTabuleiro[linha,coluna] := '*';
               end;
            end;
         end;
      end;
   end else begin
      if(pecaPodeCapturar(linhaDaPeca,colunaDaPeca,1))then begin
         for contadorLinha :=  1 to 13 do begin
            if(caminhosPossiveisDama[contadorLinha,1] <> 0)then begin
               linha := caminhosPossiveisDama[contadorLinha,1];
               coluna := caminhosPossiveisDama[contadorLinha,2];
               locaisDoTabuleiro[linha,coluna] := '*';
            end;
         end;
      end else begin
         if(pecaPodeSeMover(linhaDaPeca,colunaDaPeca,1))then begin
            for contadorLinha :=  1 to 13 do begin
               if(caminhosPossiveisDama[contadorLinha,1] <> 0)then begin
                  linha := caminhosPossiveisDama[contadorLinha,1];
                  coluna := caminhosPossiveisDama[contadorLinha,2];
                  locaisDoTabuleiro[linha,coluna] := '*';
               end;
            end;
         end;
      end;
   end;
end;

// {verificar se caminho que o usuario colocar é válido}
function caminhoEValido(linha,coluna:integer):boolean;
var
validade: boolean;
contadorLinha,tipoDaInvalidade: integer;
linhaPecaAtual,colunaPecaAtual:integer;
begin
   validade := false;

   linhaPecaAtual := posicaoPecaAtual[1];
   colunaPecaAtual := posicaoPecaAtual[2];

   // { verificação para peças comuns}
   if((locaisDoTabuleiro[linhaPecaAtual,colunaPecaAtual] = 'x') or (locaisDoTabuleiro[linhaPecaAtual,colunaPecaAtual] = 'y'))then begin
      if(validarPosicao(linha,coluna))then begin
         for contadorLinha :=  1 to 4 do begin
            if(caminhosPossiveis[contadorLinha,1] = linha)then begin
               if(caminhosPossiveis[contadorLinha,2] = coluna)then begin
                  validade := true;
               end else begin
                  tipoDaInvalidade := 1;
               end;
            end else begin
               tipoDaInvalidade := 1;
            end;
         end;
      end else begin
         tipoDaInvalidade := 2;
      end;

      // { verificação para peças Damas}
   end else begin
      if(validarPosicao(linha,coluna))then begin
         for contadorLinha :=  1 to 13 do begin
            if(caminhosPossiveisDama[contadorLinha,1] = linha)then begin
               if(caminhosPossiveisDama[contadorLinha,2] = coluna)then begin
                  validade := true;
               end else begin
                  tipoDaInvalidade := 1;
               end;
            end else begin
               tipoDaInvalidade := 1;
            end;
         end;
      end else begin
         tipoDaInvalidade := 2;
      end;
   end;

   if(not validade)then begin
{Atenção: As restrições de case ... of no Pascal são maiores que de
          escolha ... fimescolha no Visualg 3}
      case (tipoDaInvalidade) of
      1 : writeln('Invalida (voce nao pode mover para essa posicao)...');
      2 : writeln('Invalida (essa posicao nao existe no tabuleiro)...');
      end;
   end;

   caminhoEValido := validade;
end;

// { mover peça no tabuleiro}
procedure moverPeca(linhaInicio,colunaInicio,linhaDestinho,colunaDestino:integer);
var
posicaoPecaCapturada: array[1..2] of integer;
contadorLinha: integer;
begin
   posicaoPecaCapturada[1] := 0;
   posicaoPecaCapturada[2] := 0;
   // { verificar se é um movimento que captura uma peça adversária}
   if((locaisDoTabuleiro[linhaInicio,colunaInicio] = 'x') or (locaisDoTabuleiro[linhaInicio,colunaInicio] = 'y'))then begin
      for contadorLinha :=  1 to 4 do begin
         if(caminhosPossiveis[contadorLinha,1] = linhaDestinho)then begin
            if(caminhosPossiveis[contadorLinha,2] = colunaDestino)then begin
               if(caminhosPossiveis[contadorLinha,3] <> 0)then begin
                  posicaoPecaCapturada[1] := caminhosPossiveis[contadorLinha,3];
                  posicaoPecaCapturada[2] := caminhosPossiveis[contadorLinha,4];
               end;
            end;
         end;
      end;
   end else begin
      for contadorLinha :=  1 to 13 do begin
         if(caminhosPossiveisDama[contadorLinha,1] = linhaDestinho)then begin
            if(caminhosPossiveisDama[contadorLinha,2] = colunaDestino)then begin
               if(caminhosPossiveisDama[contadorLinha,3] <> 0)then begin
                  posicaoPecaCapturada[1] := caminhosPossiveisDama[contadorLinha,3];
                  posicaoPecaCapturada[2] := caminhosPossiveisDama[contadorLinha,4];
               end;
            end;
         end;
      end;
   end;

   apagarCaminhos();

   if(posicaoPecaCapturada[1] <> 0)then begin
      locaisDoTabuleiro[posicaoPecaCapturada[1],posicaoPecaCapturada[2]] := '';
      if(jogadorDaVez = 1)then begin
         pontosTimeX := pontosTimeX + 1;
      end else begin
         pontosTimeY := pontosTimeY + 1;
      end;
   end else begin
      pecaSeMoveuSemCapturar := true;
   end;

   posicaoPecaCapturada[1] := 0;
   posicaoPecaCapturada[2] := 0;

   // {colocando peça em sua nova posição}
   if(jogadorDaVez = 1)then begin
      if(locaisDoTabuleiro[linhaInicio,colunaInicio] = 'X')then begin
         locaisDoTabuleiro[linhaDestinho,colunaDestino] := 'X';
      end else begin
         locaisDoTabuleiro[linhaDestinho,colunaDestino] := 'x';
      end;
   end else begin
      if(locaisDoTabuleiro[linhaInicio,colunaInicio] = 'Y')then begin
         locaisDoTabuleiro[linhaDestinho,colunaDestino] := 'Y';
      end else begin
         locaisDoTabuleiro[linhaDestinho,colunaDestino] := 'y';
      end;
   end;

   // {removendo peça da sua antiga posição}
   locaisDoTabuleiro[linhaInicio,colunaInicio] := '';

   posicaoPecaAtual[1] := linhaDestinho;
   posicaoPecaAtual[2] := colunaDestino;
end;

// { verificar se alguma nova peça do tabuleiro virou dama}
procedure verificarDamas();
var
contadorColuna: integer;
begin
   // {peças X}
   for contadorColuna :=  1 to 8 do begin
      if(locaisDoTabuleiro[8,contadorColuna] = 'x')then begin
         locaisDoTabuleiro[8,contadorColuna] := 'X';
      end;
   end;
   // {peças Y}
   for contadorColuna :=  1 to 8 do begin
      if(locaisDoTabuleiro[1,contadorColuna] = 'y')then begin
         locaisDoTabuleiro[1,contadorColuna] := 'Y';
      end;
   end;
end;

// { qual caminho a peça irá seguir: -----------------------------------}
procedure perguntarCaminhoDaPeca();
var
fimDaJogada,posicaoValida: boolean;
linha,coluna,quantidadeDeJogadas: integer;
begin

   ClrScr();
   mostrarCabecalho();
   exibirCaminhosPossiveis(posicaoPecaAtual[1],posicaoPecaAtual[2]);
   mostrarTabuleiro();
   writeln('VOCE ESCOLHEU A PECA:');
   write('linha: ');
   write(posicaoPecaAtual[1],'|');
   write('coluna: ');
   writeln(posicaoPecaAtual[2]);
   writeln('---------------------');
   writeln('QUAL CAMINHO ELA IRA SEGUIR?');
   writeln('----------------------------');

   posicaoValida := false;
   while (not posicaoValida) do begin
      write(' -> Linha: ');
      readln(linha);
      write(' -> Coluna: ');
      readln(coluna);
      if(caminhoEValido(linha,coluna))then begin
         posicaoValida := true;
      end;
   end;
   moverPeca(posicaoPecaAtual[1],posicaoPecaAtual[2],linha,coluna);

   while (pecaPodeCapturar(posicaoPecaAtual[1],posicaoPecaAtual[2],0) and (not pecaSeMoveuSemCapturar)) do begin
      ClrScr();
      mostrarCabecalho();
      exibirCaminhosPossiveis(posicaoPecaAtual[1],posicaoPecaAtual[2]);
      mostrarTabuleiro();
      writeln('SUA NOVA POSIÇÃO É:');
      write('linha: ');
      write(posicaoPecaAtual[1],'|');
      write('coluna: ');
      writeln(posicaoPecaAtual[2]);
      writeln('---------------------');
      writeln('VOCE PODE JOGAR DE NOVO!');
      writeln('QUAL CAMINHO ELA IRA SEGUIR?');
      writeln('----------------------------');
      posicaoValida := false;
      while (not posicaoValida) do begin
         write(' -> Linha: ');
         readln(linha);
         write(' -> Coluna: ');
         readln(coluna);
         if(caminhoEValido(linha,coluna))then begin
            posicaoValida := true;
         end;
      end;
      moverPeca(posicaoPecaAtual[1],posicaoPecaAtual[2],linha,coluna);
   end;

   verificarDamas();

   pecaSeMoveuSemCapturar := false;
end;

begin
   // {atribuindo valores iniciais à variaveis importantes}
   posDaVezVetorDamas := 1;
   jogadorDaVez := 1;
   pontosTimeX := 0;
   pontosTimeY := 0;
   definirPecasDoJogo();

   // {menu principal}
   mostrarMenuPrincipal();

   // {inicio de jogo}
   while (not fimDeJogo) do begin
      ClrScr;

      mostrarCabecalho();
      mostrarTabuleiro();

      writeln('QUAL PECA IRA MOVER?');
      writeln('--------------------');
      perguntarPosicaoAtual();

      if(not fimDeJogo)then begin
         perguntarCaminhoDaPeca();
      end;

      if((pontosTimeX = 12) or (pontosTimeX = 12))then begin
         fimDeJogo := true;
      end else begin
         trocarJogador();
      end;
   end;

   // {TELA FINAL}
   ClrScr;
   writeln('---------------------------------');
   writeln('  ___   _                _       ');
   writeln(' | __| (_)  _ __      __| |  ___ ');
   writeln(' | _|  | | | ''  \    / _` | / -_)');
   writeln(' |_| _ |_| |_|_|_|   \__,_| \___|');
   writeln('  _ | |  ___   __ _   ___ ');
   writeln(' | || | / _ \ / _` | / _ \');
   writeln('  \__/  \___/ \__, | \___/');
   writeln('              |___/');
   writeln('---------------------------------');
   writeln(' RESULTADOS:');
   writeln(' - Pontuacao dos jogadores:');
   writeln('     Jogador X: ',pontosTimeX);
   writeln('     Jogador Y: ',pontosTimeY);
   readln();
end.
