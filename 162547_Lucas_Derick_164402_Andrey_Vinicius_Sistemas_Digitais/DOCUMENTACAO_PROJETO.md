# Documentação Completa - Projeto Sistemas Digitais

## 📋 Visão Geral do Projeto

Este é um projeto de **Sistemas Digitais** desenvolvido em **VHDL** que implementa um sistema de armazenamento de dados com visualização em display de 7 segmentos. O projeto integra:

1. **Memória 2x2** para armazenamento de dados (8 bits)
2. **Conversor Binário para BCD** (Binary Coded Decimal)
3. **Display Multiplexado de 7 Segmentos** para visualização de 3 dígitos decimais
4. **Flip-flops D Assíncronos** para elementos de memória
5. **Decodificadores** para seleção de endereços

**Objetivo:** Permitir ao usuário escrever valores de 8 bits na memória, que são automaticamente convertidos para formato decimal BCD e exibidos em um display de 7 segmentos.

---

## 🔧 Arquivos do Projeto

### 1. **top_level.vhd** ⭐ (Arquivo Principal)

**Descrição:** Módulo de integração (top-level) que conecta todos os componentes do sistema.

**Função Principal:**

- Recebe dados de entrada do usuário (8 bits)
- Controla a escrita na memória
- Converte dados para BCD
- Envia para o display

**Sinais de Entrada:**

- `i_clk`: Clock do sistema (100 MHz)
- `i_reset`: Sinal de reset (ativo alto)
- `i_wrt`: Sinal de escrita (ativo baixo)
- `i_sel_x`: Seleção de linha da memória (2x2)
- `i_sel_y`: Seleção de coluna da memória (2x2)
- `i_Datas[7:0]`: Dados de entrada (8 bits)

**Sinais de Saída:**

- `o_segments[6:0]`: 7 segmentos do display
- `o_anodes[3:0]`: Anodos para seleção de dígito

**Fluxo de Dados:**

```
Entrada (8 bits)
    ↓
    └─→ Memória 2x2 (armazena)
            ↓
            └─→ Conversor Binário → BCD
                    ↓
                    └─→ Display (visualiza 3 dígitos)
```

---

### 2. **memoria_2x2.vhd** 🗄️ (Memória Principal)

**Descrição:** Memória 2x2 de 8 bits (4 células, cada uma com 8 bits).

**Função:** Armazenar até 4 valores diferentes de 8 bits em uma matriz 2×2.

**Sinais:**

- Entrada: 8 bits de dados
- Saída: 8 bits do endereço selecionado
- Controle: `i_sel_x`, `i_sel_y` (endereçamento), `i_wrt` (escrita)

**Estrutura Interna:**

```
Memória 2x2:
┌─────┬─────┐
│ 00  │ 01  │  (i_sel_y=0, 1)
├─────┼─────┤
│ 10  │ 11  │
└─────┴─────┘
(i_sel_x=0,1)
```

**Componentes Internos:**

- 2 Decodificadores 1×2 (para X e Y)
- 4 Memórias de 8 bits (`memoria_8bit`)
- Lógica de escrita selecionada (AND gates)
- Multiplexador de leitura

---

### 3. **memoria_8bit.vhd** 💾 (Célula de Memória)

**Descrição:** Uma célula de memória de 8 bits, componente básico da memória 2x2.

**Função:** Armazenar 8 bits quando ativada e retornar o valor quando selecionada para leitura.

**Operação:**

- **Escrita:** Quando `i_wrt = '0'` e célula selecionada, armazena os 8 bits
- **Leitura:** Quando `i_sel_x = '1'` e `i_sel_y = '1'`, retorna o valor armazenado
- **Reset:** Quando `i_rst = '0'`, zera a memória

**Componentes Internos:**

- 1 Flip-flop D assíncrono de 8 bits (`dff8_nsync`)

---

### 4. **dff8_nsync.vhd** 🔄 (Flip-flop de 8 bits)

**Descrição:** Flip-flop D assíncrono de 8 bits - "Boneca Russa" de flip-flops.

**Função:** Armazenar 8 bits usando 4 instâncias de flip-flops de 2 bits.

**Característica:** Estrutura hierárquica (estrutural) para modularização:

```
dff8_nsync (8 bits)
    ↓
    ├─→ dff2_nsync (bits 0-1)
    ├─→ dff2_nsync (bits 2-3)
    ├─→ dff2_nsync (bits 4-5)
    └─→ dff2_nsync (bits 6-7)
```

**Operação:**

- Armazena dados na borda de subida do clock
- Reset assíncrono (ativo alto) zera todos os bits
- Escrita seletiva baseada em `i_wrt`, `i_sel_x`, `i_sel_y`

---

### 5. **dff2_nsync.vhd** 🔲 (Flip-flop de 2 bits)

**Descrição:** Flip-flop D assíncrono de 2 bits.

**Função:** Instancia 2 flip-flops D de 1 bit (`dff_nsync`) para armazenar 2 bits.

**Estrutura:**

```
dff2_nsync (2 bits)
    ↓
    ├─→ dff_nsync (bit 0)
    └─→ dff_nsync (bit 1)
```

**Operação:** Mesma operação da dff8_nsync, mas com 2 bits.

---

### 6. **dff_nsync.vhd** 🔹 (Flip-flop de 1 bit - Elemento Básico)

**Descrição:** Flip-flop D assíncrono de 1 bit - o elemento básico de armazenamento.

**Função:** Elemento fundamental para armazenar 1 bit de informação.

**Sinais:**

- `i_d`: Dado de entrada (1 bit)
- `i_clk`: Clock
- `i_reset`: Reset assíncrono (ativo alto)
- `i_sel_x`, `i_sel_y`: Sinais de seleção
- `i_wrt`: Sinal de escrita (ativo baixo)
- `o_q`: Saída

**Operação:**

```
Se reset = '1':
    Saída = 0
Senão se rising_edge(clock) e wrt='0' e selecionado:
    Armazena entrada
Senão:
    Retorna valor armazenado (se wrt='1' e selecionado)
```

**Importante:** Os botões são **Active Low** (ativo em nível baixo), por isso `i_wrt` é invertido.

---

### 7. **binary_to_bcd.vhd** 🔢 (Conversor Binário → BCD)

**Descrição:** Conversor de 8 bits binário para 12 bits BCD (3 dígitos decimais).

**Função:** Transforma um número de 8 bits (0-255) em formato BCD.

**Entrada:** 8 bits binários (0 a 255)
**Saída:** 12 bits BCD (3 dígitos de 4 bits cada)

```
Saída BCD[11:8] = centenas
Saída BCD[7:4]  = dezenas
Saída BCD[3:0]  = unidades
```

**Algoritmo Utilizado:** **Double Dabble**

O algoritmo funciona assim:

1. Começa com BCD = 0
2. Para cada bit do número binário (de MSB para LSB):
   - Se qualquer dígito BCD > 4, adiciona 3
   - Desloca BCD para esquerda
   - Adiciona próximo bit do binário

**Exemplo:** 42 em binário

```
Entrada: 00101010 (42 decimal)
Saída: 0100 0010 (4 centenas, 2 dezenas, 0 unidades) = 420? NÃO!
Saída correta: 0000 0100 0010 (0 centenas, 4 dezenas, 2 unidades) = 42 ✓
```

**Faixa de Operação:**

- Entrada: 0-255
- Saída: 000 a 255 (em BCD)

---

### 8. **display.vhd** 📺 (Controlador de Display 7 Segmentos)

**Descrição:** Controlador multiplexado para display de 3 dígitos de 7 segmentos.

**Função:**

- Recebe 3 valores BCD (unidades, dezenas, centenas)
- Alterna rapidamente entre os dígitos
- Converte cada dígito BCD para padrão de 7 segmentos

**Entrada:**

- `i_unit[3:0]`: Dígito das unidades (BCD)
- `i_deci[3:0]`: Dígito das dezenas (BCD)
- `i_cent[3:0]`: Dígito das centenas (BCD)

**Saída:**

- `o_segments[6:0]`: Mapa dos 7 segmentos (a-g)
- `o_anodes[3:0]`: Seletor de qual dígito está ativo

**Mapeamento dos Segmentos:**

```
    a
   ---
  |   |
f |   | b
   -g-
  |   |
e |   | c
   ---
    d

Índices: a=0, b=1, c=2, d=3, e=4, f=5, g=6
```

**Multiplexação:**

- Usa contador de 20 bits baseado no clock
- Os 2 bits mais significativos (19:18) selecionam qual dígito exibir
- Alterna entre os 3 dígitos (~10 ms por dígito em 100 MHz)

**Seleção de Anodos:**

```
digit_select = 00: mostrar unidades   (anodo = 1110)
digit_select = 01: mostrar dezenas    (anodo = 1101)
digit_select = 10: mostrar centenas   (anodo = 1011)
```

---

### 9. **bcd_to_7seg.vhd** 🔤 (Decodificador BCD → 7 Segmentos)

**Descrição:** Tabela de conversão BCD (0-9) para padrão de 7 segmentos.

**Função:** Para cada dígito BCD (0-15), retorna qual segmento ativar.

**Tabela de Conversão:**

```
BCD | Segmentos (abcdefg) | Dígito
----|---------------------|-------
0000| 0000001 (LED format)| 0
0001| 1001111             | 1
0010| 0010010             | 2
0011| 0000110             | 3
0100| 1001100             | 4
0101| 0100100             | 5
0110| 0100000             | 6
0111| 0001111             | 7
1000| 0000000             | 8
1001| 0000100             | 9
...outras| 1111111 (apagado)| -
```

**Formato:** "0" = segmento aceso, "1" = segmento apagado (lógica invertida para LEDs)

---

### 10. **decoder1_x_2.vhd** 🎛️ (Decodificador 1:2)

**Descrição:** Decodificador 1 entrada para 2 saídas.

**Função:** Seleciona uma de duas saídas baseado em um sinal de entrada.

**Operação:**

```
i_a = '0' → o_y0 = '1', o_y1 = '0' (seleciona linha/coluna 0)
i_a = '1' → o_y0 = '0', o_y1 = '1' (seleciona linha/coluna 1)
```

**Uso:** Selecionam qual linha (X) e coluna (Y) da memória 2x2 estarão ativas.

---

### 11. **and_gate2.vhd** 🚪 (Porta AND)

**Descrição:** Porta lógica AND simples de 2 entradas.

**Função:** Operação lógica AND básica.

**Nota:** Conforme comentário no arquivo, esta porta é "totalmente inútil" no projeto. Mantém-se como documentação das considerações de design:

- Os botões são **Active Low** (Reset e Write invertidos)
- O reset do display foi propositalmente fixado em '0' para não bugar a exibição

---

### 12. **boolean_board.xdc** 🔌 (Arquivo de Restrições)

**Descrição:** Arquivo de restrições de timing e mapeamento de I/O (Vivado).

**Função:** Define como os sinais VHDL se conectam ao hardware físico da placa.

**Mapeamento de Hardware:**

**Clock e Reset:**

```
i_clk    → PACKAGE_PIN F14 (clock 100 MHz)
i_reset  → PACKAGE_PIN J2  (botão)
i_wrt    → PACKAGE_PIN J5  (botão)
```

**Entrada de Dados (8 bits):**

```
i_Datas[0:7] → PACKAGE_PIN P1, N2, N1, M2, M1, L1, K2, K1 (switches SW8-SW15)
```

**Seleção de Endereço (2 bits):**

```
i_sel_x → PACKAGE_PIN U2 (switch SW0)
i_sel_y → PACKAGE_PIN V2 (switch SW1)
```

**Display 7 Segmentos:**

```
Segmentos (o_segments[0:6]) → PACKAGE_PIN B5, D6, A7, B7, A5, C5, D7
Anodos (o_anodes[0:3])      → PACKAGE_PIN D5, C4, C7, A8
```

---

## 🔗 Fluxo de Dados Completo

```
┌─────────────────────────────────────────────────────────────────┐
│                      ENTRADA (Placa FPGA)                       │
├─────────────────────────────────────────────────────────────────┤
│ • 8 switches (i_Datas[7:0])    → valor a armazenar             │
│ • 2 switches (i_sel_x, i_sel_y) → endereço da memória           │
│ • 1 botão (i_wrt)              → comando de escrita             │
│ • 1 botão (i_reset)            → comando de reset               │
│ • 1 clock (i_clk)              → 100 MHz                        │
└─────────────────────────────────────────────────────────────────┘
                              ↓
                    [ TOP_LEVEL ]
                   /            \
                  /              \
                 ↓                ↓
        ┌─────────────────┐  ┌──────────────────┐
        │  MEMORIA_2X2    │  │ BINARY_TO_BCD    │
        │  (Armazenamento)│  │ (Conversão)      │
        └─────────────────┘  └──────────────────┘
                 │                    │
                 └────────┬───────────┘
                          ↓
                    [ DISPLAY ]
                    (Multiplexado)
                          ↓
        ┌────────────────────────────────┐
        │  SAÍDA (Placa FPGA)            │
        ├────────────────────────────────┤
        │ • 7 LEDs (o_segments[6:0])    │
        │ • 3 anodos (o_anodes[2:0])    │
        │ → Display mostra 3 dígitos    │
        └────────────────────────────────┘
```

---

## 📊 Hierarquia de Componentes

```
top_level
├── memoria_2x2
│   ├── decoder1_x_2 (x2)
│   │   └── (lógica combinacional)
│   └── memoria_8bit (x4)
│       └── dff8_nsync
│           ├── dff2_nsync (x4)
│           │   └── dff_nsync (x2 cada)
│           │       └── (lógica de armazenamento)
│
├── binary_to_bcd
│   └── (lógica de conversão Double Dabble)
│
└── display
    ├── bcd_to_7seg (x3)
    │   └── (tabela de conversão)
    └── (lógica de multiplexação)
```

---

## ⚙️ Operação do Sistema

### 1️⃣ Modo Escrita (Armazenar Dados)

**Passos:**

1. Usuário configura os 8 switches (i_Datas) com o valor desejado (0-255)
2. Usuário ajusta 2 switches para endereço (i_sel_x, i_sel_y) - resultado em 4 endereços (00, 01, 10, 11)
3. Usuário pressiona botão WRITE (i_wrt = '0')
4. Na borda de subida do clock, o valor é armazenado na memória

### 2️⃣ Modo Leitura (Visualizar Dados)

**Passos:**

1. Usuário ajusta endereço (i_sel_x, i_sel_y)
2. Memória retorna automaticamente o valor armazenado
3. Valor é convertido de binário para BCD
4. Display mostra 3 dígitos decimais (centenas, dezenas, unidades)
5. Multiplexação alternância entre dígitos (~30 Hz)

### 3️⃣ Modo Reset

**Passos:**

1. Usuário pressiona botão RESET (i_reset = '1')
2. Todas as células de memória são zeradas
3. Display retorna a mostrar 0

---

## 🎯 Características Principais

| Característica            | Valor                         |
| ------------------------- | ----------------------------- |
| **Capacidade de Memória** | 4 × 8 bits = 32 bits totais   |
| **Faixa de Valores**      | 0 a 255 (8 bits)              |
| **Exibição em Decimal**   | 0 a 999 (3 dígitos BCD)       |
| **Frequência de Clock**   | 100 MHz                       |
| **Taxa de Multiplexação** | ~30 Hz (3 dígitos)            |
| **Tempo de Acesso**       | ~10 ns (lógica combinacional) |
| **Endereçamento**         | 2×2 = 4 células               |

---

## 🔍 Detalhes Técnicos Importantes

### Botões Active Low

- **Reset (i_reset):** Invertido no top_level
- **Write (i_wrt):** Usado como '0' para escrita

### Sinais Invertidos

```vhdl
wrt_inverted   <= not i_wrt;      -- Ativo em '0'
reset_inverted <= not i_reset;    -- Ativo em '0'
```

### Display Reset Desativado

O display recebe `i_reset = '0'` (padrão) para evitar bugar:

```vhdl
display_ctrl: display port map (
    ...
    i_reset => '0',  -- Desativado propositalmente
    ...
);
```

### Formato BCD

```
BCD 12 bits: [CCCC][DDDD][UUUU]
             centenas, dezenas, unidades
```

### Double Dabble

Algoritmo eficiente para conversão binário → BCD:

- Não usa divisão ou multiplicação
- Usa apenas shifts e comparações
- Tempo constante: 8 iterações

---

## 🛠️ Compilação e Síntese

**Ferramenta:** Xilinx Vivado

**Arquivos Necessários:**

1. Todos os arquivos `.vhd` deste projeto
2. Arquivo de restrições: `boolean_board.xdc`

**Fluxo:**

1. Criar novo projeto em Vivado
2. Adicionar todos os arquivos VHD
3. Adicionar arquivo XDC
4. Definir `top_level` como entidade superior
5. Sintetizar
6. Gerar bitstream
7. Programar placa FPGA

---

## 📝 Resumo

Este é um projeto acadêmico completo de **Sistemas Digitais** que demonstra:

- ✅ Hierarquia de componentes (top-down design)
- ✅ Arquitetura estrutural e comportamental
- ✅ Memória e elementos de armazenamento
- ✅ Conversão de dados (binário → BCD)
- ✅ Multiplexação de displays
- ✅ Controle de I/O com FPGA
- ✅ Boas práticas de VHDL

**Autores:** Lucas Derick (162547), Andrey Vinicius (164402)

---

_Documentação gerada automaticamente - Projeto de Sistemas Digitais_

