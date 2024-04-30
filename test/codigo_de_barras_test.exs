defmodule CodigoDeBarrasTest do
  use ExUnit.Case
  doctest CodigoDeBarras

  test "DV do código de barras" do
    assert CodigoDeBarras.dvCodigoBarras([0,0,1,9,3,7,3,7,0,0,0,0,0,0,0,1,0,0,0,5,0,0,9,4,0,1,4,4,8,1,6,0,6,0,6,8,0,9,3,5,0,3,1]) == 3
  end

  test "Gerador de código de barras" do
    assert CodigoDeBarras.codigoBarrasGen() == [0, 0, 1, 9, 0, 9, 7, 1, 6, 0, 0, 0, 0, 0, 0, 5, 5, 6, 5, 1, 2, 3, 4, 5, 6, 1, 2, 3, 7, 8, 9, 4, 5, 8, 7, 9, 8, 5, 6, 3, 2, 1, 4]
  end


end

defmodule FatorVencimentoTest do
  use ExUnit.Case
  doctest FatorVencimento

  test "Fator de Vencimento 1" do
    assert FatorVencimento.fatorVencimento("29-04-2024") == "9701"
  end

  test "Fator de Vencimento 2" do
    assert FatorVencimento.fatorVencimento("21/02/2025") == "9999"
  end

  test "Fator de Vencimento 3" do
    assert FatorVencimento.fatorVencimento("22/02/2025") == "1000"
  end

  test "Fator de Vencimento 4" do
    assert FatorVencimento.fatorVencimento("05-07-2000") == "1002"
  end

end

defmodule LinhaDigitavelTest do
  use ExUnit.Case
  doctest LinhaDigitavel

  test "dv linha digitável primeira parte" do
    assert LinhaDigitavel.dvBlocoLinhaDigitavel(1,[0,0,1,9,0,5,0,0,9]) == 5
  end

	test "dv linha digitável segunda parte" do
		assert LinhaDigitavel.dvBlocoLinhaDigitavel(2,[4,0,1,4,4,8,1,6,0,6]) == 9
	end

	test "dv linha digitável terceira parte" do
		assert LinhaDigitavel.dvBlocoLinhaDigitavel(3,[0,6,8,0,9,3,5,0,3,1]) == 4
	end

end
