defmodule App do
  defp salvarCodificacao(codigo, registro) do
    codigoFormatado = CodigoDeBarras.toString(codigo)

    Barlix.ITF.encode!(codigoFormatado) |> Barlix.PNG.print(file: "imagens/barcode_#{codigoFormatado}.png")

    %{
      boleto: registro,
      codigoDeBarras: codigoFormatado,
      linhaDigitavel: LinhaDigitavel.gerar(codigo)
    }
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
