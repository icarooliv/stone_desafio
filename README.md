# StoneDesafio

## Como executar

Você pode executar pelo REPL do Elixir, na raiz do projeto:

`$ mix iex -S`

O módulo StoneDesafio possui uma função púbica, `split_order/2`, que aceita duas listas.

### Entradas:

* `items`

Lista de items, seguindo a estrutura definida em `StoneDesafio.Item`. Exemplo:

```elixir
items = [
  %StoneDesafio.Item{base_price: 20, name: "item_1", quantity: 2},
  %StoneDesafio.Item{base_price: 15, name: "item_2", quantity: 2},
  %StoneDesafio.Item{base_price: 30, name: "item_3", quantity: 1}
]
```

* `persons`

Lista de e-mails (strings) que serão as chaves do mapa com os dados resultantes. Exemplo:

```elixir
persons = [
  "person1@email.com",
  "person2@email.com",
  "person3@email.com"
]
```

### Saídas:

Em caso de sucesso:

```elixir
{:ok,
 %{
   # <resultado>
}}
```

Em caso de alguma lista vazia:

```elixir
{:error, 
# <mensagem de erro>
}
```

### Exemplos:

```elixir
iex> StoneDesafio.split_order(items, persons)
{:ok,
 %{
   "person1@email.com" => 34,
   "person2@email.com" => 33,
   "person3@email.com" => 33
 }}
```

## Testes automatizados

Você também pode executar os testes automatizados com o comando no terminal, na raiz do projeto:

`$ mix test`

## Breve explicação da solução

O caso base segue a seguinte lógica:

1) Recebe as duas listas
2) Remove os emails duplicados
3) Calcula quantas pessoas (emails) dividirão a conta
4) Calcula o total da conta
5) Divide (divisão inteira) o total da conta pelo total de pessoas e calcula o resto dessa divisão
6) Cria uma nova lista, com o preço base (resultado da divisão inteira) distribuido pela quantidade de pessoas
7) Distribui o resto da divisão entre os participantes, um de cada vez (como a distribuição de cartas em um grupo)
8) Formata o resultado para a forma final
9) Retorna

O caso de exceção:

1) Caso uma das listas (ou ambas) esteja vazia, retorna a tupla de erro com a devida mensagem.