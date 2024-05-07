defmodule CodigoDeBarras do
  defp mult(x) when x > 7, do: rem(x, 8) + 2
  defp mult(x), do: x + 2

  defp ajustarDv(x) when x >= 10, do: 1
  defp ajustarDv(x), do: x

  # Talvez seja melhor colocar a cal diretamente dentro de dvCodigoBarras para otimizar
  defp calc(lista) do
    Enum.with_index(lista, fn x, i -> x * mult(i) end)
    |> Enum.sum()
    |> (&(11 - rem(&1, 11))).()
    |> ajustarDv()
  end

  def dvCodigoBarras(lista) do
    Enum.reverse(lista)
    |> calc()
  end

  defp formatarValor(valor) do
    String.replace(valor, ",", "")
    |> String.pad_leading(10, "0")
  end

  def gerar(registro) do
    (registro.banco <>
       registro.moeda <>
       FatorVencimento.fatorVencimento(registro.dataVencimento) <>
       formatarValor(registro.valor) <> registro.convenio)
    |> String.graphemes()
    |> Enum.map(&String.to_integer(&1))
    |> then(fn lista -> List.insert_at(lista, 4, dvCodigoBarras(lista)) end)
  end

  def toString(codigo), do: Enum.join(codigo, "")

  def gerarLinhaDigitavel(codigo) do
    String.graphemes(codigo)
    |> Enum.map(&String.to_integer(&1))
    |> LinhaDigitavel.gerar()
  end

  defp ajustarMoeda(valor) do
    cond do
      String.length(valor) == 3 -> "0" <> valor
      String.length(valor) == 2 -> String.replace(valor, ",", "0,0")
      true -> valor
    end
  end

  def stringParaMoeda(valor) do
    String.to_integer(valor)
    |> Integer.to_string()
    |> String.split_at(-2)
    |> then(fn {inicio, fim} -> inicio <> "," <> fim end)
    |> ajustarMoeda()
  end

  def decodificar(codigo) do
    %{
      boleto: %{
        banco: String.slice(codigo, 0..2),
        moeda: String.slice(codigo, 3..3),
        dataVencimento: String.slice(codigo, 5..8) |> FatorVencimento.decode(),
        valor: String.slice(codigo, 9..18) |> stringParaMoeda(),
        convenio: String.slice(codigo, 19..43)
      },
      linhaDigitavel: gerarLinhaDigitavel(codigo),
      codigoDeBarras: codigo
    }
  end
end

defmodule FatorVencimento do
  defp contarDias(num) when num > 8999, do: rem(num, 9000) |> contarDias
  defp contarDias(num), do: num + 1000

  defp ajustarDataFutura(data) do
    if Date.compare(data, Date.utc_today()) == :lt do
      Date.add(data, 9000)
      |> ajustarDataFutura()
    else
      data
    end
  end

  def fatorVencimento(data) do
    String.replace(data, "/", "-")
    |> Timex.parse!("{0D}-{0M}-{YYYY}")
    |> Date.diff(~D[2000-07-03])
    |> contarDias()
    |> Integer.to_string()
  end

  def decode(fator) do
    {_, data} =
      String.to_integer(fator)
      |> then(fn x -> Date.add(~D[2000-07-03], x - 1000) end)
      |> ajustarDataFutura()
      |> Timex.format("{0D}/{0M}/{YYYY}")

    data
  end
end
