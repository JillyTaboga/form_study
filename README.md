# form_study

Pequeno projeto de Estudo cujo objetivo é mostrar opções melhores para controle de estado do que a utilização de TextEditingControllers.
Em real todos os Controllers de uma maneira geral são classes caras cujos objetivos são ações complexas, especialmente permitir ouvir suas alterações de estado, logo utilizá-los de forma exposta apenas para se obter callback de valores ou controlar valores de variáveis não só é um disperdício de recursos, mas também diminui a legibilidade do código, aumenta a verbosidade e até fere responsabilidades como será analisado no estudo.

## Estrutura do estudo

Um formulário de registro de dados de usuário que permita a inclusão e edição de dados utilizando uma única interface, exiba erros e tenha estado de loading
Os dados do usuário serão:

- Nome
- CPF
- Telefone
- Email
- Apelido
- Data de nascimento

O objeto usuário será fornecido pela classe UserEntity que será a mesma para todo o estudo
Os validadores e os Formatters serão fornecidos igualmente para todo o estudo
A interface deverá ser capaz de chamar o useCase para salvar os dados do usuário que será fornecido a todo o estudo
Os dois formulários base tentarão se manter o mais próximo possíveis, incluindo comentários e utilização de widgets para permitir uma comparação justa
O formulário avançado já introduz uma solução pensando em todos os recursos disponíveis

## Formulário base com TextEditingControllers

Formulário com a implementação base do Flutter sem nenhu controlador de estado e utilizado os TextEditing Controllers

Linhas: 323

Vemos que foi necessário declarar 6 variáveis, instanciá-las no init, atualizá-las no didUpdate e dar dispose.

Não foi encontrado nenhum benefício extra trazido por utilizar os controladores.

## Formulário base sem TextEditingControllre

Formulário com a implementação base do Flutter sem nenhum controlador de estado e sem utilizar TextEditing Controllers

Linhas: 298

Ao contrário de declarar 6 variáveis foi declardo somente o objeto

Nos fields o próprio objeto fornece o valor inicial e o callback do onChanged usado para alterado

## Formulário avançado

Fomulário utilizando Riverpod para a gerência de estado

Linhas View: 227
Controlador: 160

Nesse exemplo o controlador é responsável por toda a lógica, do setter, parse até o cálculo de erros, a viem somente exibe o status adequado

Outra vantagem dessa abordagem é o widget stateless logo todo o ciclo de vida não é necessário ou lidado pelo controlador

## Quando o TextEditingController é realmente útil

Exemplo de quando se deve utilizar o TextEditingController:

- Alterar o conteúdo de um field em tempo de execução, por exemplo para limpar ou preencher o campo com um valor

Um bom exemplo está user list no campo de filtro

## Últimas considerações

Como se pode obervar não existe nenhuma vantagem ao se utilizar um TextEditingController para receber um callback, ao contrário força coisas que você não quer (controle de vida do widget) e maior verbosidade

Para quem não conhece é bom observar que o TextField possui internamente o ciclo de vida do TextFieldController, ou seja, ao não fornecer, o próprio widget instanciará e cuidará de tudo
