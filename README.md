## Universidade Federal de Santa Catarina
**Disciplina:** EEL5105: Circuitos e Técnicas Digitais  
**Semestre:** 2024/2  
**Projeto:** Jogo Detector de Código

## Descrição do Projeto
O projeto consiste na implementação de um circuito na placa de desenvolvimento DE2, utilizando estruturas e conhecimentos obtidos durante o curso. O circuito implementa um jogo interativo para a obtenção de um código secreto de 10 bits.

## Comportamento do Jogo
1. **Estado Init:** O usuário inicia o jogo pressionando o botão de pressão enter (KEY1).
2. **Estado Setup:** O usuário escolhe uma das 16 sequências possíveis com os Switches 3 a 0 (SW 3..0). Os Switches 7 a 4 (SW 7..4) são usados para escolher o tempo de jogo por rodada (entre 5 e 10 segundos). Os displays HEX5 e HEX3 mostram a letra 't' de tempo e 'n' de nível, enquanto os displays HEX4 e HEX2 mostram o valor do tempo e a linha da memória escolhida.
3. **Estado Play:** O usuário tem o tempo escolhido para selecionar uma sequência usando os Switches SW (9..0). Os displays HEX5 e HEX4 mostram a letra 't' de tempo e uma contagem ascendente com frequência de 1Hz. O jogador pode introduzir apenas quatro '1' lógicos por rodada.
4. **Estado Count_Round:** Contagem de rodada e transição para o estado Check.
5. **Estado Check:** Avaliação das condições:
   - Se o jogador não introduziu quatro '1' lógicos (sinal de status sw_erro).
   - Se o jogador atingiu o número máximo de rodadas (sinal de status end_round).
   - Se o jogador adivinhou as posições dos quatro '1' lógicos (sinal de status end_game).
6. **Estado Wait:** Os displays HEX3 e HEX2 mostram a letra 'r' de round e a contagem da rodada. Os displays HEX1 e HEX0 mostram a letra 'A' de acertos e o número de acertos. O jogador pressiona enter para voltar ao estado Play para a próxima rodada.
7. **Estado Result:** Mostra nos LEDs vermelhos (LEDR 9..0) a sequência a ser adivinhada e o resultado final em hexadecimal nos displays HEX1 e HEX0. O resultado final segue a fórmula: 16 × end_game + Round. O usuário pressiona enter para voltar ao estado Init e iniciar outra rodada.

## Sincronização de Botões
O Button Press Synchronizer (ButtonSync) será utilizado para converter apertos das KEYS em pulsos com período de um ciclo de clock.

## Implementação
O projeto será implementado usando a abordagem datapath-control vista nas aulas de teoria. O datapath será projetado e integrado com o controlador.

## Uso
Projeto funcionando para kit DE1 ou DE2 ou no simulador disponível em [FPGA Emulator](https://fpgaemu.sites.ufsc.br).

## Diagrama de Bloco do Datapath e Instruções
Para mais detalhes, consulte os PDFs disponíveis no repositório:
- [Instruções do Jogo](Instruções/Jogo.pdf)
- [Diagrama de Bloco do Datapath](Instruções/Datapath.pdf)
