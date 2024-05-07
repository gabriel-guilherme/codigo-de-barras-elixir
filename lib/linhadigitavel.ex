defmodule LinhaDigitavel do

	def dvBloco(lista) do
		Enum.reverse(lista)
		|> Enum.map_every(2, fn x -> x * 2 |>  Integer.digits() |> Enum.sum() end)
		|> Enum.sum()
		|> (&(10 - rem(&1,10))).()
	end

	def ordenar(codigodebarras) do
		codigodebarras
		|> Enum.slice(9..18)
		|> then(fn append -> Enum.slice(codigodebarras, 5..8) ++ append end)
		|> then(fn append -> Enum.slice(codigodebarras, 4..4) ++ append end)
		|> then(fn append -> Enum.slice(codigodebarras, 34..43) ++ append end)
		|> then(fn append -> Enum.slice(codigodebarras, 24..33) ++ append end)
		|> then(fn append -> Enum.slice(codigodebarras, 19..23) ++ append end)
		|> then(fn append -> Enum.slice(codigodebarras, 0..3) ++ append end)
	end
	
	def inserirDvs(lista) do
		lista
		|> Enum.slice(0..8)
		|> dvBloco()
		|> then(fn dv ->  List.insert_at(lista, 9, dv) end)
		|> then(fn novaLista -> Enum.slice(novaLista, 10..19) |> dvBloco() |> (&List.insert_at(novaLista, 20, &1)).() end)
		|> then(fn novaLista -> Enum.slice(novaLista, 21..30) |> dvBloco() |> (&List.insert_at(novaLista, 31, &1)).() end)
	end

	def toString(lista) do
		lista
		|> List.insert_at(5, ".")
		|> List.insert_at(11, " ")
		|> List.insert_at(17, ".")
		|> List.insert_at(24, " ")
		|> List.insert_at(30, ".")
		|> List.insert_at(37, " ")
		|> List.insert_at(39, " ")
		|> Enum.join("")
	end

	def gerar(lista) do
		ordenar(lista)
		|> inserirDvs()
		|> toString()
	end

end