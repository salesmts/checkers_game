Algoritmo "damas"
Var
// declaração de variáveis globais -----------------------------------
fimDeJogo: logico
locaisDoTabuleiro: vetor[1..8,1..8] de caractere
jogadorDaVez,pontosTimeX,pontosTimeY: inteiro
inputAcao:caractere // variavel para 'pausar' telas de Menu e Sobre;
posicaoPecaAtual: vetor[1..2] de inteiro

pecaSeMoveuSemCapturar: logico

//matriz(4 linhas e 3 colunas) onde exibe os possiveis caminhos
//que a peça pode seguir.
//as duas primeiras colunas definem a linha e coluna(respectivamente)
//do caminho que a peça irá seguir
//a coluna 3 pode ser 1 ou 0! Onde 1 significa que a peça está comendo
//outra peça
caminhosPossiveis: vetor[1..4,1..4] de inteiro

posDaVezVetorDamas: inteiro
caminhosPossiveisDama: vetor[1..13,1..4] de inteiro


// mostrando menu principal e Sobre ----------------------------------
procedimento mostrarMenuPrincipal()
inicio
  inputAcao <- "ficarNoMenu"
  enquanto (inputAcao <> "J") faca
    limpaTela
    escreval("- - - - - - - - - - - - - - - - - -_- - - -")
    escreval("  \ \   Seja bem-vindo(a) ao      | |      ")
    escreval("   \ \   ___    __ _   ___      __| |  ___ ")
    escreval("    \ \ / _ \  / _` | / _ \    / _` | / _ \")
    escreval(" /\_/ /| (_) || (_| || (_) |  | (_| ||  __/")
    escreval(" \___/  \___/  \__, | \___/    \__,_| \___|")
    escreval("   ___         |___/               ____   ")
    escreval("  |  _ \   __ _  _ __ ___    __ _ / ___| ")
    escreval("  | | | | / _` || '_ ` _ \  / _` |\___ \ ")
    escreval("  | |_| || (_) || | | | | || (_) | ___) |")
    escreval("  |____/  \__,_||_| |_| |_| \__,_|/____/ ")
    escreval("- - - - - - - - - - - - - - - - - - - - - -")
    escreval(" OPÇÕES:")
    escreval("  [J] Jogar")
    escreval("  [T] Tutorial ")
    escreval("  [S] Sobre o jogo")
    escreval("")
    escreva(" Escolha uma opção: ")
    leia(inputAcao)
    escolha(inputAcao)
      caso "T"
        mostrarTutorial()
      caso "S"
        mostrarSobreOJogo()
    fimescolha
  fimenquanto
fimprocedimento

procedimento mostrarTutorial()
inicio
  inputAcao <- "ficarNoTutorial"
  enquanto (inputAcao <> "V") faca
    limpaTela
    escreval("  _____  _   _  _____   ___   ___  ___    _    _    ")
    escreval(" |_   _|| | | ||_   _| / _ \ | _ \|_ _|  /_\  | |   ")
    escreval("   | |  | |_| |  | |  | (_) ||   / | |  / _ \ | |__ ")
    escreval("   |_|   \___/   |_|   \___/ |_|_\|___|/_/ \_\|____|")
    escreval("- - - - - - - - - - - - - - - - - - - - - - - - - - -")
    escreval("               PRINCIPAIS REGRAS:")
    escreval("O JOGO DE DAMAS PRATICA-SE ENTRE DOIS JOGADORES:")
    escreval("JOGADOR 1, COM AS PEÇAS X E JOGADOR 2 COM AS PEÇAS Y")
    escreval("")
    escreval("O TABULEIRO SÃO 64 CASAS (8 por 8), DESSE MODO:")
    mostrarTabuleiro()
    escreval("")
    escreval("O objetivo é  capturar  ou  imobilizar  as  peças  do")
    escreval("adversário. O jogador que conseguir capturar todas as")
    escreval("peças do inimigo ganha a partida")
    escreval("")
    escreval("As peças se movimentam apenas para frente em diagonal")
    escreval("")
    escreval("A peça que atingir a oitava casa adversária,  parando")
    escreval("ali, será promovida a dama")
    escreval("")
    escreval("Quando a peça vira  dama,  ela  pode  se  mover  para")
    escreval("frente e para trás quantas casas forem possíveis")
    escreval("")
    escreval("               COMO JOGAR:")
    escreval("Assim que a jogada se inicia, o jogo pergunta ao")
    escreval("jogador da vez qual a posição (linha e coluna) da")
    escreval("peça que ele deseja mover")
    escreval("")
    escreval("Após escolher uma peça que for  válida,  o  jogo  irá")
    escreval("exibir  no   tabuleiro  as   posições  marcadas   com")
    escreval("asterisco(*) dos possíveis  caminhos que você  poderá")
    escreval("seguir, em seguida irá lhe perguntar  para onde  você")
    escreval("deseja ir, repetindo isso até que a  jogada  não  for")
    escreval("mais possível")
    escreval("- - - - - - - - - - - - - - - - - - - - - - - - - - -")
    escreval(" OPÇÕES:")
    escreval("  [V] Voltar ao Início")
    escreval("")
    escreva(" Escolha uma opção: ")
    leia(inputAcao)
  fimenquanto
fimprocedimento

procedimento mostrarSobreOJogo()
inicio
  inputAcao <- "ficarNoSobre"
  enquanto (inputAcao <> "V") faca
    limpaTela
    escreval("       ___   ___   ___  ___  ___ ")
    escreval("      / __| / _ \ | _ )| _ \| __|")
    escreval("      \__ \| (_) || _ \|   /| _| ")
    escreval("      |___/ \___/ |___/|_|_\|___|")
    escreval("- - - - - - - - - - - - - - - - - - - -")
    escreval("A verdade é que ninguém sabe exatamente")
    escreval("quando ou como o jogo  surgiu,  mas,  o")
    escreval("que é certo, é que a Damas está por  aí")
    escreval("há  bastante  tempo,  tendo  sido   até")
    escreval("mencionada por Platão como um jogo  que")
    escreval("a Grécia pegou emprestado do Egito")
    escreval("")
    escreval("Após o jogo se popularizar na França  e")
    escreval("sofrer várias  mudanças  de  regras,  a")
    escreval("dama foi exportada para a Inglaterra  e")
    escreval("América, começando a dominação mundial")
    escreval("- - - - - - - - - - - - - - - - - - - -")
    escreval(" OPÇÕES:")
    escreval("  [V] Voltar ao Início")
    escreval("")
    escreva(" Escolha uma opção: ")
    leia(inputAcao)
  fimenquanto
fimprocedimento


// definindo os locais das peças do jogo -----------------------------
procedimento definirPecasDoJogo()
inicio
  locaisDoTabuleiro[1,1] <- "x"
  locaisDoTabuleiro[1,3] <- "x"
  locaisDoTabuleiro[1,5] <- "x"
  locaisDoTabuleiro[1,7] <- "x"
  locaisDoTabuleiro[2,2] <- "x"
  locaisDoTabuleiro[2,4] <- "x"
  locaisDoTabuleiro[2,6] <- "x"
  locaisDoTabuleiro[2,8] <- "x"
  locaisDoTabuleiro[3,1] <- "x"
  locaisDoTabuleiro[3,3] <- "x"
  locaisDoTabuleiro[3,5] <- "x"
  locaisDoTabuleiro[3,7] <- "x"

  locaisDoTabuleiro[6,2] <- "y"
  locaisDoTabuleiro[6,4] <- "y"
  locaisDoTabuleiro[6,6] <- "y"
  locaisDoTabuleiro[6,8] <- "y"
  locaisDoTabuleiro[7,1] <- "y"
  locaisDoTabuleiro[7,3] <- "y"
  locaisDoTabuleiro[7,5] <- "y"
  locaisDoTabuleiro[7,7] <- "y"
  locaisDoTabuleiro[8,2] <- "y"
  locaisDoTabuleiro[8,4] <- "y"
  locaisDoTabuleiro[8,6] <- "y"
  locaisDoTabuleiro[8,8] <- "y"
fimprocedimento

// mostrando cabeçalho na tela ---------------------------------------
procedimento mostrarCabecalho()
inicio
  escreval("------------------------------")
  escreva("      VEZ DO JOGADOR: ")
  se(jogadorDaVez = 1)entao
    escreval("X")
  senao
    escreval("Y")
  fimse
  escreval("------------------------------")
  escreval(" PLACAR:      X->",pontosTimeX,"     Y->",pontosTimeY)
fimprocedimento

// montando tabuleiro na tela ----------------------------------------
procedimento mostrarTabuleiro()
var
  linha,coluna: inteiro
inicio
  escreval("------------------------------")
  escreval("¦    TABULEIRO:              ¦")
  escreval("¦                            ¦")
  escreval("¦      C 1 2 3 4 5 6 7 8     ¦")
  escreval("¦    L                       ¦")
  para linha de 8 ate 1 passo -1 faca
    escreva("¦   ",linha,"  ")
    para coluna de 1 ate 8 faca
      escreva("|")
      se(locaisDoTabuleiro[linha,coluna] = "")entao
        escreva(" ")
      senao
        escreva(locaisDoTabuleiro[linha,coluna])
      fimse
      se(coluna = 8)entao
        escreval("|    ¦")
      fimse
    fimpara
  fimpara
  escreval("¦                            ¦")
  escreval("------------------------------")
fimprocedimento

//apagar caminhos possiveis no tabuleiro
procedimento apagarCaminhos()
var
  contadorLinha:inteiro
inicio
  para contadorLinha de 1 ate 4 faca
    se(caminhosPossiveis[contadorLinha,1] <> 0)entao
      locaisDoTabuleiro[caminhosPossiveis[contadorLinha,1],caminhosPossiveis[contadorLinha,2]] <- ""
      caminhosPossiveis[contadorLinha,1] <- 0
      caminhosPossiveis[contadorLinha,2] <- 0
      caminhosPossiveis[contadorLinha,3] <- 0
      caminhosPossiveis[contadorLinha,4] <- 0
    fimse
  fimpara
  posDaVezVetorDamas <- 1
  para contadorLinha de 1 ate 13 faca
    se(caminhosPossiveisDama[contadorLinha,1] <> 0)entao
      locaisDoTabuleiro[caminhosPossiveisDama[contadorLinha,1],caminhosPossiveisDama[contadorLinha,2]] <- ""
      caminhosPossiveisDama[contadorLinha,1] <- 0
      caminhosPossiveisDama[contadorLinha,2] <- 0
      caminhosPossiveisDama[contadorLinha,3] <- 0
      caminhosPossiveisDama[contadorLinha,4] <- 0
    fimse
  fimpara
fimprocedimento

// procedimento para trocar de jogador
procedimento trocarJogador()
inicio
  se(jogadorDaVez = 1)entao
    jogadorDaVez <- 2
  senao
    jogadorDaVez <- 1
  fimse
fimprocedimento

// validar se posição informada está dentro do tabuleiro (8x8) -------
funcao validarPosicao(linha,coluna:inteiro):logico
inicio
  se((linha >= 1) e (linha <= 8))entao
    se((coluna >= 1) e (coluna <= 8))entao
      retorne verdadeiro
    senao
      retorne falso
    fimse
  senao
    retorne falso
  fimse
fimfuncao

// verificar se peça pode capturar para algum lado -------------------
funcao pecaPodeCapturar(linha,coluna,marcarPosicao:inteiro):logico
var
  podeCapturar,novaCaptura,chegouNoLimite:logico
  contador:inteiro
  posicaoPecaCapturada: vetor[1..2] de inteiro
inicio
  podeCapturar <- falso
  
  //verificação das peças normais
  se((locaisDoTabuleiro[linha,coluna] = "x") ou (locaisDoTabuleiro[linha,coluna] = "y"))entao
  // verificar para o Jogador 1 (X)
  se(jogadorDaVez = 1)entao
    // capturar para esquerda superior
    se(validarPosicao(linha+1,coluna-1))entao
      se((locaisDoTabuleiro[linha+1,coluna-1] = "y") ou (locaisDoTabuleiro[linha+1,coluna-1] = "Y"))entao
        se(validarPosicao(linha+2,coluna-2))entao
          se(locaisDoTabuleiro[linha+2,coluna-2] = "")entao
            podeCapturar <- verdadeiro
            se(marcarPosicao = 1)entao
              caminhosPossiveis[1,1] <- linha+2
              caminhosPossiveis[1,2] <- coluna-2
              caminhosPossiveis[1,3] <- linha+1
              caminhosPossiveis[1,4] <- coluna-1
            fimse
          fimse
        fimse
      fimse
    fimse
    
    //capturar para direita superior
    se(validarPosicao(linha+1,coluna+1))entao
      se((locaisDoTabuleiro[linha+1,coluna+1] = "y") ou (locaisDoTabuleiro[linha+1,coluna+1] = "Y"))entao
        se(validarPosicao(linha+2,coluna+2))entao
          se(locaisDoTabuleiro[linha+2,coluna+2] = "")entao
            podeCapturar <- verdadeiro
            se(marcarPosicao = 1)entao
              caminhosPossiveis[2,1] <- linha+2
              caminhosPossiveis[2,2] <- coluna+2
              caminhosPossiveis[2,3] <- linha+1
              caminhosPossiveis[2,4] <- coluna+1
            fimse
          fimse
        fimse
      fimse
    fimse
    
    //capturar para direita inferior
    se(validarPosicao(linha-1,coluna+1))entao
      se((locaisDoTabuleiro[linha-1,coluna+1] = "y") ou (locaisDoTabuleiro[linha-1,coluna+1] = "Y"))entao
        se(validarPosicao(linha-2,coluna+2))entao
          se(locaisDoTabuleiro[linha-2,coluna+2] = "")entao
            podeCapturar <- verdadeiro
            se(marcarPosicao = 1)entao
              caminhosPossiveis[3,1] <- linha-2
              caminhosPossiveis[3,2] <- coluna+2
              caminhosPossiveis[3,3] <- linha-1
              caminhosPossiveis[3,4] <- coluna+1
            fimse
          fimse
        fimse
      fimse
    fimse
    
    //capturar para esquerda inferior
    se(validarPosicao(linha-1,coluna-1))entao
      se((locaisDoTabuleiro[linha-1,coluna-1] = "y") ou (locaisDoTabuleiro[linha-1,coluna-1] = "Y"))entao
        se(validarPosicao(linha-2,coluna-2))entao
          se(locaisDoTabuleiro[linha-2,coluna-2] = "")entao
            podeCapturar <- verdadeiro
            se(marcarPosicao = 1)entao
              caminhosPossiveis[4,1] <- linha-2
              caminhosPossiveis[4,2] <- coluna-2
              caminhosPossiveis[4,3] <- linha-1
              caminhosPossiveis[4,4] <- coluna-1
            fimse
          fimse
        fimse
      fimse
    fimse
    
  //verificar para jogador 2 (Y)
  senao
    // capturar para esquerda superior
    se(validarPosicao(linha+1,coluna-1))entao
      se((locaisDoTabuleiro[linha+1,coluna-1] = "x") ou (locaisDoTabuleiro[linha+1,coluna-1] = "X"))entao
        se(validarPosicao(linha+2,coluna-2))entao
          se(locaisDoTabuleiro[linha+2,coluna-2] = "")entao
            podeCapturar <- verdadeiro
            se(marcarPosicao = 1)entao
              caminhosPossiveis[1,1] <- linha+2
              caminhosPossiveis[1,2] <- coluna-2
              caminhosPossiveis[1,3] <- linha+1
              caminhosPossiveis[1,4] <- coluna-1
            fimse
          fimse
        fimse
      fimse
    fimse

    //capturar para direita superior
    se(validarPosicao(linha+1,coluna+1))entao
      se((locaisDoTabuleiro[linha+1,coluna+1] = "x") ou (locaisDoTabuleiro[linha+1,coluna+1] = "X"))entao
        se(validarPosicao(linha+2,coluna+2))entao
          se(locaisDoTabuleiro[linha+2,coluna+2] = "")entao
            podeCapturar <- verdadeiro
            se(marcarPosicao = 1)entao
              caminhosPossiveis[2,1] <- linha+2
              caminhosPossiveis[2,2] <- coluna+2
              caminhosPossiveis[2,3] <- linha+1
              caminhosPossiveis[2,4] <- coluna+1
            fimse
          fimse
        fimse
      fimse
    fimse

    //capturar para direita inferior
    se(validarPosicao(linha-1,coluna+1))entao
      se((locaisDoTabuleiro[linha-1,coluna+1] = "x") ou (locaisDoTabuleiro[linha-1,coluna+1] = "X"))entao
        se(validarPosicao(linha-2,coluna+2))entao
          se(locaisDoTabuleiro[linha-2,coluna+2] = "")entao
            podeCapturar <- verdadeiro
            se(marcarPosicao = 1)entao
              caminhosPossiveis[3,1] <- linha-2
              caminhosPossiveis[3,2] <- coluna+2
              caminhosPossiveis[3,3] <- linha-1
              caminhosPossiveis[3,4] <- coluna+1
            fimse
          fimse
        fimse
      fimse
    fimse

    //capturar para esquerda inferior
    se(validarPosicao(linha-1,coluna-1))entao
      se((locaisDoTabuleiro[linha-1,coluna-1] = "x") ou (locaisDoTabuleiro[linha-1,coluna-1] = "X"))entao
        se(validarPosicao(linha-2,coluna-2))entao
          se(locaisDoTabuleiro[linha-2,coluna-2] = "")entao
            podeCapturar <- verdadeiro
            se(marcarPosicao = 1)entao
              caminhosPossiveis[4,1] <- linha-2
              caminhosPossiveis[4,2] <- coluna-2
              caminhosPossiveis[4,3] <- linha-1
              caminhosPossiveis[4,4] <- coluna-1
            fimse
          fimse
        fimse
      fimse
    fimse
  fimse
  //verificação para as peças DAMAS
  senao
    //verificação peças X
    se(locaisDoTabuleiro[linha,coluna] = "X")entao

      // verificando casas diagonal superior esquerda
      chegouNoLimite <- falso
      contador <- 1
      enquanto (nao chegouNoLimite) faca
        se(validarPosicao(linha+contador,coluna-contador))entao
          se((locaisDoTabuleiro[linha+contador,coluna-contador] = "y") ou (locaisDoTabuleiro[linha+contador,coluna-contador] = "Y"))entao
            se(validarPosicao(linha+contador+1,coluna-contador-1))entao
              se(locaisDoTabuleiro[linha+contador+1,coluna-contador-1] = "")entao
                se(marcarPosicao = 1)entao
                  posicaoPecaCapturada[1] <- linha+contador
                  posicaoPecaCapturada[2] <- coluna-contador
                fimse
                podeCapturar <- verdadeiro
                se(marcarPosicao = 1)entao
                  enquanto (nao chegouNoLimite) faca
                    se(validarPosicao(linha+contador+1,coluna-contador-1))entao
                      se(locaisDoTabuleiro[linha+contador+1,coluna-contador-1] = "")entao
                        caminhosPossiveisDama[posDaVezVetorDamas,1] <- linha+contador+1
                        caminhosPossiveisDama[posDaVezVetorDamas,2] <- coluna-contador-1
                        caminhosPossiveisDama[posDaVezVetorDamas,3] <- posicaoPecaCapturada[1]
                        caminhosPossiveisDama[posDaVezVetorDamas,4] <- posicaoPecaCapturada[2]
                        posDaVezVetorDamas <- posDaVezVetorDamas+1
                      senao
                        chegouNoLimite <- verdadeiro
                      fimse
                    senao
                      chegouNoLimite <- verdadeiro
                    fimse
                    contador <- contador + 1
                  fimenquanto
                fimse
              senao
                chegouNoLimite <- verdadeiro
              fimse
            senao
              chegouNoLimite <- verdadeiro
            fimse
          senao
            se(nao (locaisDoTabuleiro[linha+contador,coluna-contador] = ""))entao
              chegouNoLimite <- verdadeiro
            fimse
          fimse
        senao
          chegouNoLimite <- verdadeiro
        fimse
        contador <- contador + 1
      fimenquanto
      chegouNoLimite <- falso
      contador <- 1
      
      // verificando casas diagonal superior direita
      chegouNoLimite <- falso
      contador <- 1
      enquanto (nao chegouNoLimite) faca
        se(validarPosicao(linha+contador,coluna+contador))entao
          se((locaisDoTabuleiro[linha+contador,coluna+contador] = "y") ou (locaisDoTabuleiro[linha+contador,coluna+contador] = "Y"))entao
            se(validarPosicao(linha+contador+1,coluna+contador+1))entao
              se(locaisDoTabuleiro[linha+contador+1,coluna+contador+1] = "")entao
                se(marcarPosicao = 1)entao
                  posicaoPecaCapturada[1] <- linha+contador
                  posicaoPecaCapturada[2] <- coluna+contador
                fimse
                podeCapturar <- verdadeiro
                se(marcarPosicao = 1)entao
                  enquanto (nao chegouNoLimite) faca
                    se(validarPosicao(linha+contador+1,coluna+contador+1))entao
                      se(locaisDoTabuleiro[linha+contador+1,coluna+contador+1] = "")entao
                        caminhosPossiveisDama[posDaVezVetorDamas,1] <- linha+contador+1
                        caminhosPossiveisDama[posDaVezVetorDamas,2] <- coluna+contador+1
                        caminhosPossiveisDama[posDaVezVetorDamas,3] <- posicaoPecaCapturada[1]
                        caminhosPossiveisDama[posDaVezVetorDamas,4] <- posicaoPecaCapturada[2]
                        posDaVezVetorDamas <- posDaVezVetorDamas+1
                      senao
                        chegouNoLimite <- verdadeiro
                      fimse
                    senao
                      chegouNoLimite <- verdadeiro
                    fimse
                    contador <- contador + 1
                  fimenquanto
                fimse
              senao
                chegouNoLimite <- verdadeiro
              fimse
            senao
              chegouNoLimite <- verdadeiro
            fimse
          senao
            se(nao (locaisDoTabuleiro[linha+contador,coluna+contador] = ""))entao
              chegouNoLimite <- verdadeiro
            fimse
          fimse
        senao
          chegouNoLimite <- verdadeiro
        fimse
        contador <- contador + 1
      fimenquanto
      chegouNoLimite <- falso
      contador <- 1
      
      // verificando casas diagonal inferior direita
      chegouNoLimite <- falso
      contador <- 1
      enquanto (nao chegouNoLimite) faca
        se(validarPosicao(linha-contador,coluna+contador))entao
          se((locaisDoTabuleiro[linha-contador,coluna+contador] = "y") ou (locaisDoTabuleiro[linha-contador,coluna+contador] = "Y"))entao
            se(validarPosicao(linha-contador-1,coluna+contador+1))entao
              se(locaisDoTabuleiro[linha-contador-1,coluna+contador+1] = "")entao
                se(marcarPosicao = 1)entao
                  posicaoPecaCapturada[1] <- linha-contador
                  posicaoPecaCapturada[2] <- coluna+contador
                fimse
                podeCapturar <- verdadeiro
                se(marcarPosicao = 1)entao
                  enquanto (nao chegouNoLimite) faca
                    se(validarPosicao(linha-contador-1,coluna+contador+1))entao
                      se(locaisDoTabuleiro[linha-contador-1,coluna+contador+1] = "")entao
                        caminhosPossiveisDama[posDaVezVetorDamas,1] <- linha-contador-1
                        caminhosPossiveisDama[posDaVezVetorDamas,2] <- coluna+contador+1
                        caminhosPossiveisDama[posDaVezVetorDamas,3] <- posicaoPecaCapturada[1]
                        caminhosPossiveisDama[posDaVezVetorDamas,4] <- posicaoPecaCapturada[2]
                        posDaVezVetorDamas <- posDaVezVetorDamas+1
                      senao
                        chegouNoLimite <- verdadeiro
                      fimse
                    senao
                      chegouNoLimite <- verdadeiro
                    fimse
                    contador <- contador + 1
                  fimenquanto
                fimse
              senao
                chegouNoLimite <- verdadeiro
              fimse
            senao
              chegouNoLimite <- verdadeiro
            fimse
          senao
            se(nao (locaisDoTabuleiro[linha-contador,coluna+contador] = ""))entao
              chegouNoLimite <- verdadeiro
            fimse
          fimse
        senao
          chegouNoLimite <- verdadeiro
        fimse
        contador <- contador + 1
      fimenquanto
      chegouNoLimite <- falso
      contador <- 1
      
      // verificando casas diagonal inferior esquerda
      chegouNoLimite <- falso
      contador <- 1
      enquanto (nao chegouNoLimite) faca
        se(validarPosicao(linha-contador,coluna-contador))entao
          se((locaisDoTabuleiro[linha-contador,coluna-contador] = "y") ou (locaisDoTabuleiro[linha-contador,coluna-contador] = "Y"))entao
            se(validarPosicao(linha-contador-1,coluna-contador-1))entao
              se(locaisDoTabuleiro[linha-contador-1,coluna-contador-1] = "")entao
                se(marcarPosicao = 1)entao
                  posicaoPecaCapturada[1] <- linha-contador
                  posicaoPecaCapturada[2] <- coluna-contador
                fimse
                podeCapturar <- verdadeiro
                se(marcarPosicao = 1)entao
                  enquanto (nao chegouNoLimite) faca
                    se(validarPosicao(linha-contador-1,coluna-contador-1))entao
                      se(locaisDoTabuleiro[linha-contador-1,coluna-contador-1] = "")entao
                        caminhosPossiveisDama[posDaVezVetorDamas,1] <- linha-contador-1
                        caminhosPossiveisDama[posDaVezVetorDamas,2] <- coluna-contador-1
                        caminhosPossiveisDama[posDaVezVetorDamas,3] <- posicaoPecaCapturada[1]
                        caminhosPossiveisDama[posDaVezVetorDamas,4] <- posicaoPecaCapturada[2]
                        posDaVezVetorDamas <- posDaVezVetorDamas+1
                      senao
                        chegouNoLimite <- verdadeiro
                      fimse
                    senao
                      chegouNoLimite <- verdadeiro
                    fimse
                    contador <- contador + 1
                  fimenquanto
                fimse
              senao
                chegouNoLimite <- verdadeiro
              fimse
            senao
              chegouNoLimite <- verdadeiro
            fimse
          senao
            se(nao (locaisDoTabuleiro[linha-contador,coluna-contador] = ""))entao
              chegouNoLimite <- verdadeiro
            fimse
          fimse
        senao
          chegouNoLimite <- verdadeiro
        fimse
        contador <- contador + 1
      fimenquanto
      chegouNoLimite <- falso
      contador <- 1

    // verificar peças Y
    senao

      // verificando casas diagonal superior esquerda
      chegouNoLimite <- falso
      contador <- 1
      enquanto (nao chegouNoLimite) faca
        se(validarPosicao(linha+contador,coluna-contador))entao
          se((locaisDoTabuleiro[linha+contador,coluna-contador] = "x") ou (locaisDoTabuleiro[linha+contador,coluna-contador] = "X"))entao
            se(validarPosicao(linha+contador+1,coluna-contador-1))entao
              se(locaisDoTabuleiro[linha+contador+1,coluna-contador-1] = "")entao
                se(marcarPosicao = 1)entao
                  posicaoPecaCapturada[1] <- linha+contador
                  posicaoPecaCapturada[2] <- coluna-contador
                fimse
                podeCapturar <- verdadeiro
                se(marcarPosicao = 1)entao
                  enquanto (nao chegouNoLimite) faca
                    se(validarPosicao(linha+contador+1,coluna-contador-1))entao
                      se(locaisDoTabuleiro[linha+contador+1,coluna-contador-1] = "")entao
                        caminhosPossiveisDama[posDaVezVetorDamas,1] <- linha+contador+1
                        caminhosPossiveisDama[posDaVezVetorDamas,2] <- coluna-contador-1
                        caminhosPossiveisDama[posDaVezVetorDamas,3] <- posicaoPecaCapturada[1]
                        caminhosPossiveisDama[posDaVezVetorDamas,4] <- posicaoPecaCapturada[2]
                        posDaVezVetorDamas <- posDaVezVetorDamas+1
                      senao
                        chegouNoLimite <- verdadeiro
                      fimse
                    senao
                      chegouNoLimite <- verdadeiro
                    fimse
                    contador <- contador + 1
                  fimenquanto
                fimse
              senao
                chegouNoLimite <- verdadeiro
              fimse
            senao
              chegouNoLimite <- verdadeiro
            fimse
          senao
            se(nao (locaisDoTabuleiro[linha+contador,coluna-contador] = ""))entao
              chegouNoLimite <- verdadeiro
            fimse
          fimse
        senao
          chegouNoLimite <- verdadeiro
        fimse
        contador <- contador + 1
      fimenquanto
      chegouNoLimite <- falso
      contador <- 1

      // verificando casas diagonal superior direita
      chegouNoLimite <- falso
      contador <- 1
      enquanto (nao chegouNoLimite) faca
        se(validarPosicao(linha+contador,coluna+contador))entao
          se((locaisDoTabuleiro[linha+contador,coluna+contador] = "x") ou (locaisDoTabuleiro[linha+contador,coluna+contador] = "X"))entao
            se(validarPosicao(linha+contador+1,coluna+contador+1))entao
              se(locaisDoTabuleiro[linha+contador+1,coluna+contador+1] = "")entao
                se(marcarPosicao = 1)entao
                  posicaoPecaCapturada[1] <- linha+contador
                  posicaoPecaCapturada[2] <- coluna+contador
                fimse
                podeCapturar <- verdadeiro
                se(marcarPosicao = 1)entao
                  enquanto (nao chegouNoLimite) faca
                    se(validarPosicao(linha+contador+1,coluna+contador+1))entao
                      se(locaisDoTabuleiro[linha+contador+1,coluna+contador+1] = "")entao
                        caminhosPossiveisDama[posDaVezVetorDamas,1] <- linha+contador+1
                        caminhosPossiveisDama[posDaVezVetorDamas,2] <- coluna+contador+1
                        caminhosPossiveisDama[posDaVezVetorDamas,3] <- posicaoPecaCapturada[1]
                        caminhosPossiveisDama[posDaVezVetorDamas,4] <- posicaoPecaCapturada[2]
                        posDaVezVetorDamas <- posDaVezVetorDamas+1
                      senao
                        chegouNoLimite <- verdadeiro
                      fimse
                    senao
                      chegouNoLimite <- verdadeiro
                    fimse
                    contador <- contador + 1
                  fimenquanto
                fimse
              senao
                chegouNoLimite <- verdadeiro
              fimse
            senao
              chegouNoLimite <- verdadeiro
            fimse
          senao
            se(nao (locaisDoTabuleiro[linha+contador,coluna+contador] = ""))entao
              chegouNoLimite <- verdadeiro
            fimse
          fimse
        senao
          chegouNoLimite <- verdadeiro
        fimse
        contador <- contador + 1
      fimenquanto
      chegouNoLimite <- falso
      contador <- 1

      // verificando casas diagonal inferior direita
      chegouNoLimite <- falso
      contador <- 1
      enquanto (nao chegouNoLimite) faca
        se(validarPosicao(linha-contador,coluna+contador))entao
          se((locaisDoTabuleiro[linha-contador,coluna+contador] = "x") ou (locaisDoTabuleiro[linha-contador,coluna+contador] = "X"))entao
            se(validarPosicao(linha-contador-1,coluna+contador+1))entao
              se(locaisDoTabuleiro[linha-contador-1,coluna+contador+1] = "")entao
                se(marcarPosicao = 1)entao
                  posicaoPecaCapturada[1] <- linha-contador
                  posicaoPecaCapturada[2] <- coluna+contador
                fimse
                podeCapturar <- verdadeiro
                se(marcarPosicao = 1)entao
                  enquanto (nao chegouNoLimite) faca
                    se(validarPosicao(linha-contador-1,coluna+contador+1))entao
                      se(locaisDoTabuleiro[linha-contador-1,coluna+contador+1] = "")entao
                        caminhosPossiveisDama[posDaVezVetorDamas,1] <- linha-contador-1
                        caminhosPossiveisDama[posDaVezVetorDamas,2] <- coluna+contador+1
                        caminhosPossiveisDama[posDaVezVetorDamas,3] <- posicaoPecaCapturada[1]
                        caminhosPossiveisDama[posDaVezVetorDamas,4] <- posicaoPecaCapturada[2]
                        posDaVezVetorDamas <- posDaVezVetorDamas+1
                      senao
                        chegouNoLimite <- verdadeiro
                      fimse
                    senao
                      chegouNoLimite <- verdadeiro
                    fimse
                    contador <- contador + 1
                  fimenquanto
                fimse
              senao
                chegouNoLimite <- verdadeiro
              fimse
            senao
              chegouNoLimite <- verdadeiro
            fimse
          senao
            se(nao (locaisDoTabuleiro[linha-contador,coluna+contador] = ""))entao
              chegouNoLimite <- verdadeiro
            fimse
          fimse
        senao
          chegouNoLimite <- verdadeiro
        fimse
        contador <- contador + 1
      fimenquanto
      chegouNoLimite <- falso
      contador <- 1

      // verificando casas diagonal inferior esquerda
      chegouNoLimite <- falso
      contador <- 1
      enquanto (nao chegouNoLimite) faca
        se(validarPosicao(linha-contador,coluna-contador))entao
          se((locaisDoTabuleiro[linha-contador,coluna-contador] = "x") ou (locaisDoTabuleiro[linha-contador,coluna-contador] = "X"))entao
            se(validarPosicao(linha-contador-1,coluna-contador-1))entao
              se(locaisDoTabuleiro[linha-contador-1,coluna-contador-1] = "")entao
                se(marcarPosicao = 1)entao
                  posicaoPecaCapturada[1] <- linha-contador
                  posicaoPecaCapturada[2] <- coluna-contador
                fimse
                podeCapturar <- verdadeiro
                se(marcarPosicao = 1)entao
                  enquanto (nao chegouNoLimite) faca
                    se(validarPosicao(linha-contador-1,coluna-contador-1))entao
                      se(locaisDoTabuleiro[linha-contador-1,coluna-contador-1] = "")entao
                        caminhosPossiveisDama[posDaVezVetorDamas,1] <- linha-contador-1
                        caminhosPossiveisDama[posDaVezVetorDamas,2] <- coluna-contador-1
                        caminhosPossiveisDama[posDaVezVetorDamas,3] <- posicaoPecaCapturada[1]
                        caminhosPossiveisDama[posDaVezVetorDamas,4] <- posicaoPecaCapturada[2]
                        posDaVezVetorDamas <- posDaVezVetorDamas+1
                      senao
                        chegouNoLimite <- verdadeiro
                      fimse
                    senao
                      chegouNoLimite <- verdadeiro
                    fimse
                    contador <- contador + 1
                  fimenquanto
                fimse
              senao
                chegouNoLimite <- verdadeiro
              fimse
            senao
              chegouNoLimite <- verdadeiro
            fimse
          senao
            se(nao (locaisDoTabuleiro[linha-contador,coluna-contador] = ""))entao
              chegouNoLimite <- verdadeiro
            fimse
          fimse
        senao
          chegouNoLimite <- verdadeiro
        fimse
        contador <- contador + 1
      fimenquanto
      chegouNoLimite <- falso
      contador <- 1

    fimse
  fimse
  
  retorne podeCapturar
fimfuncao

// verificar se outras peças do tabuleiro podem capturar -------------
funcao outraPecaPodeCapturar():logico
var
  outraPecaDeveCapturar: logico
  linha,coluna: inteiro
inicio
  outraPecaDeveCapturar <- falso

  // verificar peças do jogador 1
  se(jogadorDaVez = 1)entao
    para linha de 1 ate 8 faca
      para coluna de 1 ate 8 faca
        se((locaisDoTabuleiro[linha,coluna] = "x") ou (locaisDoTabuleiro[linha,coluna] = "X"))entao
          se(pecaPodeCapturar(linha,coluna,0))entao
            outraPecaDeveCapturar <- verdadeiro
          fimse
        fimse
      fimpara
    fimpara
  // verificar peças do jogador 2
  senao
    para linha de 1 ate 8 faca
      para coluna de 1 ate 8 faca
        se((locaisDoTabuleiro[linha,coluna] = "y") ou (locaisDoTabuleiro[linha,coluna] = "Y"))entao
          se(pecaPodeCapturar(linha,coluna,0))entao
            outraPecaDeveCapturar <- verdadeiro
          fimse
        fimse
      fimpara
    fimpara
  fimse
  
  retorne outraPecaDeveCapturar
fimfuncao

// verificar se peça pode se mover para algum lado -------------------
funcao pecaPodeSeMover(linha,coluna,marcarPosicao:inteiro):logico
var
  podeSeMover,estaNoLimite:logico
  contador:inteiro
inicio
  estaNoLimite <- falso
  podeSeMover <- falso
  
  //verificar se a peça é normal ou é uma Dama
  se((locaisDoTabuleiro[linha,coluna] = "x") ou (locaisDoTabuleiro[linha,coluna] = "y"))entao
    //verificar a peça X do Jogador 1
    se(jogadorDaVez = 1)entao
  
      //verificar se pode mover para diagonal superior esquerda
      se(validarPosicao(linha+1,coluna-1))entao
        se(locaisDoTabuleiro[linha+1,coluna-1] = "")entao
          podeSeMover <- verdadeiro
          se(marcarPosicao = 1)entao
            caminhosPossiveis[1,1] <- linha+1
            caminhosPossiveis[1,2] <- coluna-1
          fimse
        fimse
      fimse
    
      //verificar se pode mover para diagonal superior direira
      se(validarPosicao(linha+1,coluna+1))entao
        se(locaisDoTabuleiro[linha+1,coluna+1] = "")entao
          podeSeMover <- verdadeiro
          se(marcarPosicao = 1)entao
            caminhosPossiveis[2,1] <- linha+1
            caminhosPossiveis[2,2] <- coluna+1
          fimse
        fimse
      fimse

    //verificar a peça Y do Jogador 2
    senao
  
      //verificar se pode mover para diagonal inferior direira
      se(validarPosicao(linha-1,coluna+1))entao
        se(locaisDoTabuleiro[linha-1,coluna+1] = "")entao
          podeSeMover <- verdadeiro
          se(marcarPosicao = 1)entao
            caminhosPossiveis[3,1] <- linha-1
            caminhosPossiveis[3,2] <- coluna+1
          fimse
        fimse
      fimse
    
      //verificar se pode mover para diagonal inferior esquerda
      se(validarPosicao(linha-1,coluna-1))entao
        se(locaisDoTabuleiro[linha-1,coluna-1] = "")entao
          podeSeMover <- verdadeiro
          se(marcarPosicao = 1)entao
            caminhosPossiveis[4,1] <- linha-1
            caminhosPossiveis[4,2] <- coluna-1
          fimse
        fimse
      fimse
    fimse
  //verificar as Damas
  senao
    // VERIFICAÇÃO DIAGONAL ESQUERDA SUPERIOR
    estaNoLimite <- falso
    contador <- 1
    enquanto (nao estaNoLimite) faca
      se(validarPosicao(linha+contador,coluna-contador))entao
        se(locaisDoTabuleiro[linha+contador,coluna-contador] = "")entao
        podeSeMover <- verdadeiro
        se(marcarPosicao = 1)entao
          caminhosPossiveisDama[posDaVezVetorDamas,1] <- linha+contador
          caminhosPossiveisDama[posDaVezVetorDamas,2] <- coluna-contador
          
          posDaVezVetorDamas <- posDaVezVetorDamas + 1
        senao
          estaNoLimite <- verdadeiro
        fimse
        senao
          estaNoLimite <- verdadeiro
        fimse
      senao
        estaNoLimite <- verdadeiro
      fimse
      contador <- contador + 1
    fimenquanto
    
    // VERIFICAÇÃO DIAGONAL DIREITA SUPERIOR
    estaNoLimite <- falso
    contador <- 1
    enquanto (nao estaNoLimite) faca
      se(validarPosicao(linha+contador,coluna+contador))entao
        se(locaisDoTabuleiro[linha+contador,coluna+contador] = "")entao
        podeSeMover <- verdadeiro
        se(marcarPosicao = 1)entao
          caminhosPossiveisDama[posDaVezVetorDamas,1] <- linha+contador
          caminhosPossiveisDama[posDaVezVetorDamas,2] <- coluna+contador

          posDaVezVetorDamas <- posDaVezVetorDamas + 1
        senao
          estaNoLimite <- verdadeiro
        fimse
        senao
          estaNoLimite <- verdadeiro
        fimse
      senao
        estaNoLimite <- verdadeiro
      fimse
      contador <- contador + 1
    fimenquanto
    
    // VERIFICAÇÃO DIAGONAL DIREITA INFERIOR
    estaNoLimite <- falso
    contador <- 1
    enquanto (nao estaNoLimite) faca
      se(validarPosicao(linha-contador,coluna+contador))entao
        se(locaisDoTabuleiro[linha-contador,coluna+contador] = "")entao
        podeSeMover <- verdadeiro
        se(marcarPosicao = 1)entao
          caminhosPossiveisDama[posDaVezVetorDamas,1] <- linha-contador
          caminhosPossiveisDama[posDaVezVetorDamas,2] <- coluna+contador

          posDaVezVetorDamas <- posDaVezVetorDamas + 1
        senao
          estaNoLimite <- verdadeiro
        fimse
        senao
          estaNoLimite <- verdadeiro
        fimse
      senao
        estaNoLimite <- verdadeiro
      fimse
      contador <- contador + 1
    fimenquanto
    
    // VERIFICAÇÃO DIAGONAL DIREITA INFERIOR
    estaNoLimite <- falso
    contador <- 1
    enquanto (nao estaNoLimite) faca
      se(validarPosicao(linha-contador,coluna-contador))entao
        se(locaisDoTabuleiro[linha-contador,coluna-contador] = "")entao
        podeSeMover <- verdadeiro
        se(marcarPosicao = 1)entao
          caminhosPossiveisDama[posDaVezVetorDamas,1] <- linha-contador
          caminhosPossiveisDama[posDaVezVetorDamas,2] <- coluna-contador

          posDaVezVetorDamas <- posDaVezVetorDamas + 1
        senao
          estaNoLimite <- verdadeiro
        fimse
        senao
          estaNoLimite <- verdadeiro
        fimse
      senao
        estaNoLimite <- verdadeiro
      fimse
      contador <- contador + 1
    fimenquanto
  fimse
  retorne podeSeMover
fimfuncao

// perguntar qual posição do tabuleiro -------------------------------
procedimento perguntarPosicaoAtual()
var
  posicaoValida: logico
  linha,coluna: inteiro
inicio
  posicaoValida <- falso
  enquanto (nao posicaoValida) faca
    escreva(" -> linha: ")
    leia(linha)
    escreva(" -> coluna: ")
    leia(coluna)
    se((linha = 0) e (coluna = 0))entao
      fimDeJogo <- verdadeiro
      posicaoValida <- verdadeiro
    fimse
    se((validarPosicao(linha,coluna)) e (nao fimDeJogo))entao
      //JOGADOR 1
      se(jogadorDaVez = 1)entao
        se ((locaisDoTabuleiro[linha,coluna] = "x") ou (locaisDoTabuleiro[linha,coluna] = "X")) entao
          se(pecaPodeCapturar(linha,coluna,0))entao
            posicaoPecaAtual[1] <- linha
            posicaoPecaAtual[2] <- coluna
            posicaoValida <- verdadeiro
          senao
            se(outraPecaPodeCapturar())entao
              escreval("Inválida (outra peça do seu tabuleiro deve Capturar)...")
            senao
              se(pecaPodeSeMover(linha,coluna,0))entao
                posicaoPecaAtual[1] <- linha
                posicaoPecaAtual[2] <- coluna
                posicaoValida <- verdadeiro
              senao
                escreval("Inválida (impossível mover esta pessa)...")
              fimse
            fimse
          fimse
        senao
          se ((locaisDoTabuleiro[linha,coluna] = "y") ou (locaisDoTabuleiro[linha,coluna] = "Y")) entao
            escreval("Inválida (peça adversária)...")
          senao
            escreval("Inválida (local vazio)...")
          fimse
        fimse
      //JOGADOR 2
      senao
        se ((locaisDoTabuleiro[linha,coluna] = "y") ou (locaisDoTabuleiro[linha,coluna] = "Y")) entao
          se(pecaPodeCapturar(linha,coluna,0))entao
            posicaoPecaAtual[1] <- linha
            posicaoPecaAtual[2] <- coluna
            posicaoValida <- verdadeiro
          senao
            se(outraPecaPodeCapturar())entao
              escreval("Inválida (outra peça do seu tabuleiro deve Capturar)...")
            senao
              se(pecaPodeSeMover(linha,coluna,0))entao
                posicaoPecaAtual[1] <- linha
                posicaoPecaAtual[2] <- coluna
                posicaoValida <- verdadeiro
              senao
                escreval("Inválida (impossível mover esta pessa)...")
              fimse
            fimse
          fimse
        senao
          se ((locaisDoTabuleiro[linha,coluna] = "x") ou (locaisDoTabuleiro[linha,coluna] = "X")) entao
            escreval("Inválida (peça adversária)...")
          senao
            escreval("Inválida (local vazio)...")
          fimse
        fimse
      fimse
    senao
      escreval("Inválida (posição inexistente)...")
    fimse
  fimenquanto
fimprocedimento

// qual caminho a peça irá seguir: -----------------------------------
procedimento perguntarCaminhoDaPeca()
var
  fimDaJogada,posicaoValida: logico
  linha,coluna,quantidadeDeJogadas: inteiro
inicio

limpaTela()
mostrarCabecalho()
exibirCaminhosPossiveis(posicaoPecaAtual[1],posicaoPecaAtual[2])
mostrarTabuleiro()
escreval("VOCÊ ESCOLHEU A PEÇA:")
escreva("linha: ")
escreva(posicaoPecaAtual[1],"|")
escreva("coluna: ")
escreval(posicaoPecaAtual[2])
escreval("---------------------")
escreval("QUAL CAMINHO ELA IRÁ SEGUIR?")
escreval("----------------------------")

posicaoValida <- falso
enquanto (nao posicaoValida) faca
  escreva(" -> Linha: ")
  leia(linha)
  escreva(" -> Coluna: ")
  leia(coluna)
  se(caminhoEValido(linha,coluna))entao
    posicaoValida <- verdadeiro
  fimse
fimenquanto
moverPeca(posicaoPecaAtual[1],posicaoPecaAtual[2],linha,coluna)

enquanto (pecaPodeCapturar(posicaoPecaAtual[1],posicaoPecaAtual[2],0) e (nao pecaSeMoveuSemCapturar)) faca
  limpaTela()
  mostrarCabecalho()
  exibirCaminhosPossiveis(posicaoPecaAtual[1],posicaoPecaAtual[2])
  mostrarTabuleiro()
  escreval("SUA NOVA POSIÇÃO É:")
  escreva("linha: ")
  escreva(posicaoPecaAtual[1],"|")
  escreva("coluna: ")
  escreval(posicaoPecaAtual[2])
  escreval("---------------------")
  escreval("VOCÊ PODE JOGAR DE NOVO!")
  escreval("QUAL CAMINHO ELA IRÁ SEGUIR?")
  escreval("----------------------------")
  posicaoValida <- falso
  enquanto (nao posicaoValida) faca
    escreva(" -> Linha: ")
    leia(linha)
    escreva(" -> Coluna: ")
    leia(coluna)
    se(caminhoEValido(linha,coluna))entao
      posicaoValida <- verdadeiro
    fimse
  fimenquanto
  moverPeca(posicaoPecaAtual[1],posicaoPecaAtual[2],linha,coluna)
fimenquanto

verificarDamas()

pecaSeMoveuSemCapturar <- falso
fimprocedimento

//verificar se caminho que o usuario colocar é válido
funcao caminhoEValido(linha,coluna:inteiro):logico
var
  validade: logico
  contadorLinha,tipoDaInvalidade: inteiro
  linhaPecaAtual,colunaPecaAtual:inteiro
inicio
  validade <- falso
  
  linhaPecaAtual <- posicaoPecaAtual[1]
  colunaPecaAtual <- posicaoPecaAtual[2]
  
  // verificação para peças comuns
  se((locaisDoTabuleiro[linhaPecaAtual,colunaPecaAtual] = "x") ou (locaisDoTabuleiro[linhaPecaAtual,colunaPecaAtual] = "y"))entao
    se(validarPosicao(linha,coluna))entao
      para contadorLinha de 1 ate 4 faca
        se(caminhosPossiveis[contadorLinha,1] = linha)entao
          se(caminhosPossiveis[contadorLinha,2] = coluna)entao
            validade <- verdadeiro
          senao
            tipoDaInvalidade <- 1
          fimse
        senao
          tipoDaInvalidade <- 1
        fimse
      fimpara
    senao
      tipoDaInvalidade <- 2
    fimse
    
  // verificação para peças Damas
  senao
    se(validarPosicao(linha,coluna))entao
      para contadorLinha de 1 ate 13 faca
        se(caminhosPossiveisDama[contadorLinha,1] = linha)entao
          se(caminhosPossiveisDama[contadorLinha,2] = coluna)entao
            validade <- verdadeiro
          senao
            tipoDaInvalidade <- 1
          fimse
        senao
          tipoDaInvalidade <- 1
        fimse
      fimpara
    senao
      tipoDaInvalidade <- 2
    fimse
  fimse
  
  se(nao validade)entao
    escolha (tipoDaInvalidade)
      caso 1
        escreval("Inválida (você não pode mover para essa posição)...")
      caso 2
        escreval("Inválida (essa posição não existe no tabuleiro)...")
    fimescolha
  fimse
  
  retorne validade
fimfuncao

// mover peça no tabuleiro
procedimento moverPeca(linhaInicio,colunaInicio,linhaDestinho,colunaDestino:inteiro)
var
  posicaoPecaCapturada: vetor[1..2] de inteiro
  contadorLinha: inteiro
inicio
  // verificar se é um movimento que captura uma peça adversária
  se((locaisDoTabuleiro[linhaInicio,colunaInicio] = "x") ou (locaisDoTabuleiro[linhaInicio,colunaInicio] = "y"))entao
    para contadorLinha de 1 ate 4 faca
      se(caminhosPossiveis[contadorLinha,1] = linhaDestinho)entao
        se(caminhosPossiveis[contadorLinha,2] = colunaDestino)entao
          se(caminhosPossiveis[contadorLinha,3] <> 0)entao
            posicaoPecaCapturada[1] <- caminhosPossiveis[contadorLinha,3]
            posicaoPecaCapturada[2] <- caminhosPossiveis[contadorLinha,4]
          fimse
        fimse
      fimse
    fimpara
  senao
    para contadorLinha de 1 ate 13 faca
      se(caminhosPossiveisDama[contadorLinha,1] = linhaDestinho)entao
        se(caminhosPossiveisDama[contadorLinha,2] = colunaDestino)entao
          se(caminhosPossiveisDama[contadorLinha,3] <> 0)entao
            posicaoPecaCapturada[1] <- caminhosPossiveisDama[contadorLinha,3]
            posicaoPecaCapturada[2] <- caminhosPossiveisDama[contadorLinha,4]
          fimse
        fimse
      fimse
    fimpara
  fimse
  
  apagarCaminhos()
  
  se(posicaoPecaCapturada[1] <> 0)entao
    locaisDoTabuleiro[posicaoPecaCapturada[1],posicaoPecaCapturada[2]] <- ""
    se(jogadorDaVez = 1)entao
      pontosTimeX <- pontosTimeX + 1
    senao
      pontosTimeY <- pontosTimeY + 1
    fimse
  senao
    pecaSeMoveuSemCapturar <- verdadeiro
  fimse
  posicaoPecaCapturada[1] <- 0
  posicaoPecaCapturada[2] <- 0

  //colocando peça em sua nova posição
  se(jogadorDaVez = 1)entao
    se(locaisDoTabuleiro[linhaInicio,colunaInicio] = "X")entao
      locaisDoTabuleiro[linhaDestinho,colunaDestino] <- "X"
    senao
      locaisDoTabuleiro[linhaDestinho,colunaDestino] <- "x"
    fimse
  senao
    se(locaisDoTabuleiro[linhaInicio,colunaInicio] = "Y")entao
      locaisDoTabuleiro[linhaDestinho,colunaDestino] <- "Y"
    senao
      locaisDoTabuleiro[linhaDestinho,colunaDestino] <- "y"
    fimse
  fimse

  //removendo peça da sua antiga posição
  locaisDoTabuleiro[linhaInicio,colunaInicio] <- ""

  posicaoPecaAtual[1] <- linhaDestinho
  posicaoPecaAtual[2] <- colunaDestino
fimprocedimento

// marcar no tabuleiro os possíveis caminhos da peça
procedimento exibirCaminhosPossiveis(linhaDaPeca,colunaDaPeca:inteiro)
var
  contadorLinha,linha,coluna:inteiro
inicio
  se ((locaisDoTabuleiro[linhaDaPeca,colunaDaPeca] = "x") ou (locaisDoTabuleiro[linhaDaPeca,colunaDaPeca] = "y")) entao
    se(pecaPodeCapturar(linhaDaPeca,colunaDaPeca,1))entao
      para contadorLinha de 1 ate 4 faca
        se(caminhosPossiveis[contadorLinha,1] <> 0)entao
          linha <- caminhosPossiveis[contadorLinha,1]
          coluna <- caminhosPossiveis[contadorLinha,2]
          locaisDoTabuleiro[linha,coluna] <- "*"
        fimse
      fimpara
    senao
      se(pecaPodeSeMover(linhaDaPeca,colunaDaPeca,1))entao
        para contadorLinha de 1 ate 4 faca
          se(caminhosPossiveis[contadorLinha,1] <> 0)entao
            linha <- caminhosPossiveis[contadorLinha,1]
            coluna <- caminhosPossiveis[contadorLinha,2]
            locaisDoTabuleiro[linha,coluna] <- "*"
          fimse
        fimpara
      fimse
    fimse
  senao
    se(pecaPodeCapturar(linhaDaPeca,colunaDaPeca,1))entao
      para contadorLinha de 1 ate 13 faca
        se(caminhosPossiveisDama[contadorLinha,1] <> 0)entao
          linha <- caminhosPossiveisDama[contadorLinha,1]
          coluna <- caminhosPossiveisDama[contadorLinha,2]
          locaisDoTabuleiro[linha,coluna] <- "*"
        fimse
      fimpara
    senao
      se(pecaPodeSeMover(linhaDaPeca,colunaDaPeca,1))entao
        para contadorLinha de 1 ate 13 faca
          se(caminhosPossiveisDama[contadorLinha,1] <> 0)entao
            linha <- caminhosPossiveisDama[contadorLinha,1]
            coluna <- caminhosPossiveisDama[contadorLinha,2]
            locaisDoTabuleiro[linha,coluna] <- "*"
          fimse
        fimpara
      fimse
    fimse
  fimse
fimprocedimento

// verificar se alguma nova peça do tabuleiro virou dama
procedimento verificarDamas()
var
  contadorColuna: inteiro
inicio
  //peças X
  para contadorColuna de 1 ate 8 faca
    se(locaisDoTabuleiro[8,contadorColuna] = "x")entao
      locaisDoTabuleiro[8,contadorColuna] <- "X"
    fimse
  fimpara
  //peças Y
  para contadorColuna de 1 ate 8 faca
    se(locaisDoTabuleiro[1,contadorColuna] = "y")entao
      locaisDoTabuleiro[1,contadorColuna] <- "Y"
    fimse
  fimpara
fimprocedimento

Inicio
//atribuindo valores iniciais à variaveis importantes
posDaVezVetorDamas <- 1
jogadorDaVez <- 1
pontosTimeX <- 0
pontosTimeY <- 0
definirPecasDoJogo()

//menu principal
mostrarMenuPrincipal()

//inicio de jogo
enquanto (nao fimDeJogo) faca
  limpaTela
  
  mostrarCabecalho()
  mostrarTabuleiro()
  
  escreval("QUAL PEÇA IRÁ MOVER?")
  escreval("--------------------")
  perguntarPosicaoAtual()

  se(nao fimDeJogo)entao
    perguntarCaminhoDaPeca()
  fimse
  
  se((pontosTimeX = 12) ou (pontosTimeX = 12))entao
    fimDeJogo <- verdadeiro
  senao
    trocarJogador()
  fimse
fimenquanto

//TELA FINAL
limpaTela
escreval("---------------------------------")
escreval("  ___   _                _       ")
escreval(" | __| (_)  _ __      __| |  ___ ")
escreval(" | _|  | | | '  \    / _` | / -_)")
escreval(" |_| _ |_| |_|_|_|   \__,_| \___|")
escreval("  _ | |  ___   __ _   ___ ")
escreval(" | || | / _ \ / _` | / _ \")
escreval("  \__/  \___/ \__, | \___/")
escreval("              |___/")
escreval("---------------------------------")
escreval(" RESULTADOS:")
escreval(" - Pontuação dos jogadores:")
escreval("     Jogador X: ",pontosTimeX)
escreval("     Jogador Y: ",pontosTimeY)

Fimalgoritmo