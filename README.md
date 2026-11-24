# Birdle: Flutter Getting Started (PPDM)

**Unidade Curricular:** Programação para Dispositivos Móveis (PPDM)
**Tópicos:** 01 - Dispositivos Móveis | 02 - Criação de Interface
**Aluno(a):** [Seu nome] - [RA/Matrícula]
**Base:** Trilha oficial Flutter, Passo 3: [Flutter tutorial](https://docs.flutter.dev/learn/pathway/tutorial)

---

## Parte 1: Respostas Conceituais

### 1. Diferença entre desenvolvimento Nativo e Cross-Platform/Híbrido

No desenvolvimento **nativo**, cada plataforma tem seu próprio código, linguagem
e SDK: Kotlin/Java para Android e Swift/Objective-C para iOS. Isso garante
acesso total e imediato aos recursos do sistema e o melhor desempenho, mas
exige duas bases de código e, geralmente, duas equipes.

No desenvolvimento **cross-platform** (como o Flutter), existe **uma única base
de código em Dart** que gera apps para Android, iOS, web e desktop. O Flutter não
usa os componentes visuais nativos de cada sistema: ele desenha a interface por
conta própria com seu motor gráfico (Impeller), o que mantém a aparência
consistente entre plataformas e reduz custo e tempo de desenvolvimento. Em
troca, o acesso a recursos específicos do dispositivo depende de plugins ou de
platform channels.

### 2. StatelessWidget vs. StatefulWidget

No Flutter, a interface é uma árvore de widgets.

- **StatelessWidget:** é imutável. Sua aparência depende apenas dos parâmetros
  recebidos e não muda por conta própria.
  *Exemplo de uso:* elementos fixos, como um título, um ícone ou um rótulo
  (`Text`, `Icon`). Neste projeto, o `Tile` e o `GameBoard`.
- **StatefulWidget:** possui um objeto `State` separado, que guarda dados que
  mudam durante a execução. Quando esses dados mudam, a interface é reconstruída.
  *Exemplo de uso:* contador, checkbox, formulário ou campo de texto. Neste
  projeto, a `GamePage` (estado do jogo) e o `GuessInput` (texto digitado).

### 3. O que acontece ao chamar `setState()`

O `setState()` executa a função recebida, que atualiza as variáveis do `State`,
e **marca o widget como "sujo" (dirty)**. O framework então agenda uma nova
chamada ao método `build()` desse widget no próximo frame, e a tela é
redesenhada com os novos valores. Apenas a parte da árvore ligada a esse widget
é reconstruída, não o app inteiro. Se uma variável for alterada **sem**
`setState()`, o valor muda na memória, mas a tela não é atualizada.

---

## Parte 2: Prática Hands-on

Projeto **Birdle**, um jogo de adivinhar palavras de 5 letras (estilo Wordle),
desenvolvido a partir do tutorial oficial do Flutter.

### Como funciona

- O app sorteia uma palavra secreta de 5 letras.
- O jogador tem 6 tentativas.
- Após cada tentativa, as letras são coloridas:
  - 🟩 **verde:** letra certa na posição certa
  - 🟨 **amarelo:** letra existe na palavra, mas em outra posição
  - ⬛ **cinza:** letra não existe na palavra
- Ao acertar ou esgotar as tentativas, é possível iniciar um novo jogo.

### Conceitos aplicados

| Conceito | Onde foi aplicado |
|---|---|
| Árvore de widgets (`Scaffold`) | `lib/main.dart` (`GamePage`) |
| `Row` e `Column` | `lib/widgets/game_board.dart` |
| `Container` (versão animada) | `lib/widgets/tile.dart` (`AnimatedContainer`) |
| Interatividade | `lib/widgets/guess_input.dart` (campo de texto e botão) |
| Alteração de estado | `setState()` em `GamePage` |
| Separação de componentes | pasta `widgets/` e lógica isolada em `game.dart` |
| Prevenção de overflow | `SingleChildScrollView`, `FittedBox`, `Expanded` e `SafeArea` |

### Estrutura do projeto

```
birdle/
├── lib/
│   ├── main.dart              # runApp, MaterialApp e GamePage
│   ├── game.dart              # lógica do jogo (sem UI)
│   ├── words.dart             # lista de palavras
│   └── widgets/
│       ├── tile.dart          # quadrado de uma letra
│       ├── game_board.dart    # grade de tentativas
│       └── guess_input.dart   # campo de texto + botão
├── test/
│   └── widget_test.dart
├── pubspec.yaml
└── README.md
```

### Como executar

**Pré-requisitos:** [Flutter SDK](https://docs.flutter.dev/install) instalado
(confira com `flutter doctor`).

```bash
git clone https://github.com/[SEU_USUARIO]/birdle.git
cd birdle
flutter pub get
flutter run -d chrome   # ou escolha um emulador/dispositivo com: flutter devices
```

### Verificação de qualidade

```bash
flutter analyze   # análise estática, sem erros
flutter test      # teste de widget
```

O layout foi testado em janelas estreitas e com o teclado aberto, sem
overflow (faixa amarela e preta).

### Referências

- [Flutter tutorial (oficial)](https://docs.flutter.dev/learn/pathway/tutorial)
- [Documentação de widgets de layout](https://docs.flutter.dev/ui/widgets/layout)
- [State management: ephemeral vs app state](https://docs.flutter.dev/data-and-backend/state-mgmt/ephemeral-vs-app)