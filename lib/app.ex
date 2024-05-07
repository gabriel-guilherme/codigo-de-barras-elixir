defmodule App do
  defp salvarCodificacao(codigo, registro) do
    map = %{
      boleto: registro,
      codigoDeBarras: CodigoDeBarras.toString(codigo),
      linhaDigitavel: LinhaDigitavel.gerar(codigo)
    }

    Barlix.Code39.encode!(map.codigoDeBarras) |> Barlix.PNG.print(file: "barcode.png")
  end

  def codificador(arquivo_input) do
    EntradaSaida.lerRegistros(arquivo_input)
    |> Enum.map(fn registro -> CodigoDeBarras.gerar(registro) |> salvarCodificacao(registro) end)
  end

  def decodificador(arquivo_input) do
    EntradaSaida.lerCodigos(arquivo_input)
    |> Enum.map(fn codigo -> CodigoDeBarras.decodificar(codigo) end)
  end
end
