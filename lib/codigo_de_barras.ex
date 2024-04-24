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

  def hello do
    :world
  end

  def calc(lista) do
    Enum.with_index(lista, fn x, i -> x * mult(i) end)
    |> Enum.sum()
    |> rem(11)
    |> sub11()
  end

  def dvCodigoBarras(lista) do
    Enum.reverse(lista)
    |> calc()
  end
end

defmodule FatorVencimento do
  def fatorVencimento(data) do
    String.replace(data, "/", "-")
    |> Timex.parse!("{0D}-{0M}-{YYYY}")
    |> Date.diff(~D[1997-10-07])
    |> contarDias()
  end

  defp contarDias(num) when num > 9999, do: rem(num, 10000) + 1000
  defp contarDias(num), do: num
end
