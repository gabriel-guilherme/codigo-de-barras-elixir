defmodule CodigoDeBarras do
  defp mult(x) when x > 7, do: rem(x, 8) + 2
  defp mult(x), do: x + 2

  defp sub11(x) do
    if 11 - x == 0 or 11 - x == 10 or 11 - x == 11 do
      0
    else
      11 - x
    end
  end

  def calc(lista) do
    Enum.with_index(lista, fn x, i -> x * mult(i) end)
    |> Enum.sum()
    |> rem(11)
    |> sub11()
  end

  def formatarValor(valor) do
    String.replace(valor, ",", "")
    |> String.pad_leading(10, "0")
  end

  def dvCodigoBarras(lista) do
    Enum.reverse(lista)
    |> calc()
  end

  def inserirCodigoBarrasDV(lista) do
    List.insert_at(lista, 4, dvCodigoBarras(lista))
  end

  def codigoBarrasGen() do
    x = FileReader.read_file("input.txt")

    (x.banco <>
       x.moeda <> FatorVencimento.fatorVencimento(x.data) <> formatarValor(x.valor) <> x.conteudo)
    |> String.graphemes()
    |> Enum.map(&String.to_integer(&1))
    |> inserirCodigoBarrasDV()
  end
end

defmodule FatorVencimento do
  def fatorVencimento(data) do
    String.replace(data, "/", "-")
    |> Timex.parse!("{0D}-{0M}-{YYYY}")
    |> Date.diff(~D[1997-10-07])
    |> contarDias()
    |> Integer.to_string()
  end

  defp contarDias(num) when num > 9999, do: rem(num, 10000) + 1000
  defp contarDias(num), do: num
end

defmodule LinhaDigitavel do
  defp multiplicadorBlocoLinhaDigitavel(1, indice) when rem(indice, 2) == 1, do: 1
  defp multiplicadorBlocoLinhaDigitavel(1, indice) when rem(indice, 2) == 0, do: 2
  defp multiplicadorBlocoLinhaDigitavel(_, indice) when rem(indice, 2) == 0, do: 1
  defp multiplicadorBlocoLinhaDigitavel(_, indice) when rem(indice, 2) == 1, do: 2
  defp reduzirAUmAlgarismo(18), do: 9
  defp reduzirAUmAlgarismo(numero) when numero <= 9, do: numero
  defp reduzirAUmAlgarismo(numero), do: rem(numero, 9)
  defp modESubtracao(soma), do: 10 - rem(soma, 10)

  def dvBlocoLinhaDigitavel(bloco, l) do
    Enum.with_index(l, fn elemento, indice ->
      reduzirAUmAlgarismo(elemento * multiplicadorBlocoLinhaDigitavel(bloco, indice))
    end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
    |> modESubtracao()
  end

  def insereDvLinhaDigitavel(lista) do
    lista
    |> Enum.slice(0..8)
    |> Codigodebarra.dvBlocoLinhaDigitavel(1)
  end

  def ordenaParaLinhaDigitavel(lista) do
    lista
    |> Enum.slice(0..3)
    |> Kernel.++(Enum.slice(lista, 19..23))
    |> Kernel.++(Enum.slice(lista, 24..33))
    |> Kernel.++(Enum.slice(lista, 34..43))
    |> Kernel.++(Enum.slice(lista, 4..4))
    |> Kernel.++(Enum.slice(lista, 5..8))
    |> Kernel.++(Enum.slice(lista, 9..18))
  end
end

defmodule FileReader do
  def read_file(file_path) do
    case File.read(file_path) do
      {:ok, content} ->
        [banco, moeda, data, valor, conteudo] = String.split(content, "\n")
        %{banco: banco, moeda: moeda, data: data, valor: valor, conteudo: conteudo}

      {:error, _reason} ->
        IO.puts("Erro ao ler o arquivo")
        %{}
    end
  end
end
