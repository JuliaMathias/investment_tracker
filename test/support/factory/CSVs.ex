# credo:disable-for-this-file Credo.Check.Refactor.LongQuoteBlocks
defmodule InvestmentTracker.Factory.CSVs do
  @moduledoc false
  alias InvestmentTracker.CSVs.CSV

  defmacro __using__(_opts) do
    quote do
      def csv_factory do
        %CSV{
          id: Ecto.UUID.generate(),
          content: "some content",
          title: "some title",
          type: :renda_fixa,
          imported?: false
        }
      end

      def renda_fixa_csv_factory do
        content = """
        EXTRATO DE POSIÇÃO DE RENDA FIXA,,,,,,,,,,,,,
        Emissão: 28/03/2023,,,,,,,,,,,,,
        ,,,,,"Bank X
        Avenida da Maria, 9999, Aparecida, SP/SP - Cep: 99999999
        Contato: (99) 9999-9999
        www.bankx.com.br/mesa@bankx.com.br
        CNPJ: 000.000.000/0000-00",,,,,,,,
        Agência:,1,Conta:,,,000000001 Posição em: 28/03/2023,,,,,,,,
        EXTRATO DE POSIÇÃO DE RENDA FIXA,,,,,,,,,,,,,
        CDB YZC,,,,,,,,,,,,,
        ,"Valor Bruto R$ 1.234,56",,,,"Valor Líquido Total: R$ 1.219,21",,,,,"Valor Aplicado Total: R$ 1.050,00",,,
        Nota,Data Início,"Data
        Vencimento","Valor
        Aplicação","Tipo
        Aplicação","Taxa
        Aplicação",,"Valor
        Rendimento","Valor
        Retirada","Valor
        Desconto","Valor
        Bruto","Valor Previsão
        Desconto","Valor
        Líquido",IR/IOF
        000001,01/01/2022,01/01/2024,"R$ 1.000,00",CDB,"CDI + 6,00% a.a.",,-,-,-,"R$ 1.234,56","R$ 15,35","R$ 1.219,21","15,35%"
        CDB LIMIT PLUS,,,,,,,,,,,,,
        ,"Valor Bruto R$ 12.345,67",,,,,"Valor Líquido Total: R$ 12.311,49",,,,"Valor Aplicado Total: R$ 12.000,00",,,
        Nota,Data Início,"Data
        Vencimento",,"Valor
        Aplicação","Tipo
        Aplicação","Taxa
        Aplicação","Valor
        Rendimento","Valor
        Retirada","Valor
        Desconto","Valor
        Bruto","Valor Previsão
        Desconto","Valor
        Líquido",IR/IOF
        000002,01/01/2022,01/01/2025,"R$ 1.200,00",,CDB,80% do CDI,"R$ 41,65","R$ 0,00","R$ 0,00","R$ 1.241,65","R$ 9,37","R$ 1.232,28","22,5%"
        000002,01/01/2022,01/01/2025,"R$ 1.200,00",,CDB,80% do CDI,"R$ 41,65","R$ 0,00","R$ 0,00","R$ 1.241,65","R$ 9,37","R$ 1.232,28","22,5%"
        000003,01/01/2023,01/01/2026,"R$ 10.000,00",,CDB,80% do CDI,"R$ 110,28","R$ 0,00","R$ 0,00","R$ 10.110,28","R$ 24,81","R$ 10.085,47","22,5%"
        Página 1 de 3,,,,,,,,,,,,
        ,,,,,,,,,,,,,
        EXTRATO DE POSIÇÃO DE RENDA FIXA,,,,,,,,,,,,,
        CRA GREEN130S2,,,,,,,,,,,,,
        ,"Valor Bruto R$ 1.128,30",,,,"Valor Líquido Total: R$ 1.128,30",,,,"Valor Aplicado Total: R$ 1.078,25",,,,
        Nota,Data Início,"Data
        Vencimento","Valor
        Aplicação","Tipo
        Aplicação","Taxa
        Aplicação","Valor
        Rendimento","Valor
        Retirada","Valor
        Desconto","Valor
        Bruto","Valor Previsão
        Desconto","Valor
        Líquido",IR/IOF,
        475331,22/11/2022,17/07/2029,"R$ 1.078,25",CRA,"IPCA + 6,85% a.a.",-,-,-,"R$ 1.128,30","R$ 0,00","R$ 1.128,30",0%,
        CRI STRAIGHTS175E2,,,,,,,,,,,,,
        ,"Valor Bruto R$ 2.034,56",,,,"Valor Líquido Total: R$ 2.034,56",,,,"Valor Aplicado Total: R$ 2.900,34",,,,
        Nota,Data Início,"Data
        Vencimento","Valor
        Aplicação","Tipo
        Aplicação","Taxa
        Aplicação","Valor
        Rendimento","Valor
        Retirada","Valor
        Desconto","Valor
        Bruto","Valor Previsão
        Desconto","Valor
        Líquido",IR/IOF,
        193210,15/06/2021,20/11/2024,"R$ 2.900,34",CRI,"IPCA + 5,80% a.a.",-,-,-,"R$ 2.034,56","R$ 0,00","R$ 2.034,56",0%,
        193210,15/06/2022,20/11/2024,"R$ 2.900,34",CRI,"IPCA + 5,80% a.a.",-,-,-,"R$ 2.034,56","R$ 0,00","R$ 2.034,56",0%,
        DEBENTURE LIGHB6,,,,,,,,,,,,,
        ,"Valor Bruto R$ 5.734,25",,,,"Valor Líquido Total: R$ 5.734,25",,,,"Valor Aplicado Total: R$ 5.573,61",,,,
        Nota,Data Início,"Data
        Vencimento","Valor
        Aplicação","Tipo
        Aplicação","Taxa
        Aplicação","Valor
        Rendimento","Valor
        Retirada","Valor
        Desconto","Valor
        Bruto","Valor Previsão
        Desconto","Valor
        Líquido",IR/IOF,
        193210,15/06/2022,17/10/2025,"R$ 5.573,61",DEB,"IPCA + 5,75% a.a.",-,-,-,"R$ 5.734,25","R$ 0,00","R$ 5.734,25",0%,
        Página 2 de 3,,,,,,,,,,,,,
        ,,,,,,,,,,,,,
        EXTRATO DE POSIÇÃO DE RENDA FIXA,,,,,,,,,,,,,
        LCA XYZ,,,,,,,,,,,,,
        ,"Valor Bruto R$ 3.292,38",,,,"Valor Líquido Total: R$ 3.292,38",,,,"Valor Aplicado Total: R$ 3.112,14",,,,
        Nota,Data Início,"Data
        Vencimento","Valor
        Aplicação","Tipo
        Aplicação","Taxa
        Aplicação","Valor
        Rendimento","Valor
        Retirada","Valor
        Desconto","Valor
        Bruto","Valor Previsão
        Desconto","Valor
        Líquido",IR/IOF,
        284430,22/08/2022,12/08/2023,"R$ 3.112,14",LCA,"IPCA + 5,65% a.a.",-,-,-,"R$ 3.292,38","R$ 0,00","R$ 3.292,38",0%,
        LCI MNO,,,,,,,,,,,,,
        ,"Valor Bruto R$ 3.365,24",,,,"Valor Líquido Total: R$ 3.365,24",,,,"Valor Aplicado Total: R$ 3.117,29",,,,
        Nota,Data Início,"Data
        Vencimento","Valor
        Aplicação","Tipo
        Aplicação","Taxa
        Aplicação","Valor
        Rendimento","Valor
        Retirada","Valor
        Desconto","Valor
        Bruto","Valor Previsão
        Desconto","Valor
        Líquido",IR/IOF,
        284428,22/08/2022,11/08/2023,"R$ 3.117,29",LCI,"12,45% a.a.",-,-,-,"R$ 3.365,24","R$ 0,00","R$ 3.365,24",0%,
        Canais de Atendimento UniBank,,,,,,,,,,,,,
        SAC: 0800 123 4567 (opção 09) - Deficiente de Fala e Audição 0800 987 6543,,,,,,,,,,,,,
        Ouvidoria: 0800 123 6789 - ouvidoria@unibank.com.br,,,,,,,,,,,,,
        Página 3 de 3,,,,,,,,,,,,,
        """

        attrs = %{
          content: content,
          title: "Renda Fixa",
          type: :renda_fixa
        }

        build(:csv, attrs)
      end

      def fundos_csv_factory do
        content = """
        "","","","","","","",""
        "TABLE 1","","","","","","",""
        "","","","","","","",""
        "","","","ANON ACCESS","ABC CAPITAL","FIM","",""
        "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
        "01/01/2023","5108.42276296","R $ 1,36241335","R $ 6.469,65","R $ 6.959,78","R $ 66,86","R $ 0,00","R $ 6.892,92"
        "","","","","","","",""
        "","","","","","","",""
        "TABLE 2","","","","","","",""
        "","","","","","","",""
        "","","","DAICHI KARAZUNO","FIC FIM CP","","",""
        "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
        "01/01/2023","3574.40272981","R $ 1,40170440","R $ 5.000,00","R $ 5.010,26","R $ 2,30","R $ 0,00","R $ 5.007,96"
        "","","","","","","",""
        "","","","","","","",""
        "TABLE 3","","","","","","",""
        "","","","","","","",""
        "","","","ANON ACCESS","TRIGONOMETRY BS FIC","FIM","",""
        "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
        "03/12/2022","1599.12639086","R $ 1,26813128","R $ 2.000,00","R $ 2.027,90","R $ 6,27","R $ 0,00","R $ 2.021,63"
        "","","","","","","",""
        "","","","","","","",""
        "TABLE 4","","","","","","",""
        "","","","","","","",""
        "","","","CALIFORNIAN WHATEVER","US INDEX 500 FIM","","",""
        "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
        "03/12/2022","1093.6281063","R $ 4,77489460","R $ 5.387,99","R $ 5.221,96","R $ 0,00","R $ 0,00","R $ 5.221,96"
        "","","","","","","",""
        "","","","","","","",""
        "TABLE 5","","","","","","",""
        "","","","","","","",""
        "","","","ANON RENDA","AMAZING FIRF","LP","",""
        "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
        "03/12/2022","15.73414415","R $ 3,63290045","R $ 57,02","R $ 57,16","R $ 0,00","R $ 0,11","R $ 57,05"
        "","","","","","","",""
        "","","","","","","",""
        "TABLE 6","","","","","","",""
        "","","","","","","",""
        "","","","CUTE HAMTARO","STH FIC FIM","","",""
        "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
        "03/12/2022","14.35224537","R $ 361,41645460","R $ 4.949,86","R $ 5.187,14","R $ 0,00","R $ 0,00","R $ 5.187,14"
        "","","","","","","",""
        "","","","","","","",""
        "TABLE 7","","","","","","",""
        "","","","","","","",""
        "","","","ANON","RENDA FIRF CP","","",""
        "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
        "03/12/2022","774.37288715","R $ 1,96464388","R $ 1.500,00","R $ 1.521,37","R $ 4,80","R $ 0,00","R $ 1.516,57"
        "","","","","","","",""
        "","","","","","","",""
        "TABLE 8","","","","","","",""
        "","","","","","","",""
        "","","","ANON","RARE FIRF CP","","",""
        "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
        "03/12/2022","7988.18764326","R $ 1,26025674","R $ 10.000,00","R $ 10.067,17","R $ 9,67","R $ 24,18","R $ 10.033,32"
        "","","","","","","",""
        "","","","","","","",""
        "TABLE 9","","","","","","",""
        "","","","","","","",""
        "","","","ANON SELECTION","MULTIESTRATEGIA","FIC FIM","",""
        "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
        "21/02/2022","582.76385774","R $ 1,16695240","R $ 699,90","R $ 680,06","R $ 0,00","R $ 0,00","R $ 680,06"
        "","","","","","","",""
        "","","","","","","",""
        "TABLE 10","","","","","","",""
        "","","","","","","",""
        "","","","ALPHA OMEGA","GLOBAL FIC FIM","","",""
        "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
        "08/11/2022","21994.01998227","R $ 1,66128320","R $ 35.000,00","R $ 36.538,29","R $ 329,28","R $ 74,81","R $ 36.134,20"
        """

        attrs = %{
          content: content,
          title: "Fundos",
          type: :fundos
        }

        build(:csv, attrs)
      end

      def tesouro_direto_csv_factory do
        content = """
        Produto,Instituição,Código ISIN,Indexador,Vencimento,Quantidade,Quantidade Disponível,Quantidade Indisponível,Motivo,Valor Aplicado,Valor bruto,Valor líquido,Valor Atualizado
        Tesouro Selic 2025,ANON DISTRIBUIDORA DE TITULOS E VALORES MOBILIARIOS LTDA,BRSTNCLF1RC4,SELIC,01/03/2025,"2,1","2,1",0,-," R$24.430,23 "," R$27.358,72 "," R$26.765,04 "," R$27.358,72 "
        Tesouro Prefixado 2029,ANON DISTRIBUIDORA DE TITULOS E VALORES MOBILIARIOS LTDA,BRSTNCLF1RC5,Prefixado,01/12/2029,"3,2","3,2",0,-," R$31.234,56 "," R$35.987,21 "," R$34.905,43 "," R$35.987,21 "
        Tesouro IPCA+ Com Juros Semestrais 2032,ANON DISTRIBUIDORA DE TITULOS E VALORES MOBILIARIOS LTDA,BRSTNCLF1RC5,IPCA+ Com Juros,15/08/2032,"4,5","4,5",0,-," R$55.432,12 "," R$62.876,45 "," R$61.234,56 "," R$62.876,45 "
        ,,,,,,,,,,,,
        ,,,,,,,,,,,,Total
        ,,,,,,,,,,,," R$122.905,03 "
        """

        attrs = %{
          content: content,
          title: "Tesouro Direto",
          type: :tesouro_direto
        }

        build(:csv, attrs)
      end

      def renda_variavel_csv_factory do
        content = """
        "","","","","","",""
        "TABLE 1","","","","","",""
        "","","","","","",""
        "","","","ANON01","","",""
        "Quantidade","Preço Médio","Custo Médio","Preço Mercado","Valor Mercado","% Retorno","Retorno"
        "6","R $ 105,50","R $ 633,00","R $ 100,75","R $ 604,50","-4.500","-R $ 28,50"
        "","","","","","",""
        "","","","","","",""
        "TABLE 2","","","","","",""
        "","","","","","",""
        "","","","ANON02","","",""
        "Quantidade","Preço Médio","Custo Médio","Preço Mercado","Valor Mercado","% Retorno","Retorno"
        "4","R $ 130,00","R $ 520,00","R $ 110,00","R $ 440,00","-15.000","-R $ 80,00"
        "","","","","","",""
        "","","","","","",""
        "TABLE 3","","","","","",""
        "","","","","","",""
        "","","","ANON03","","",""
        "Quantidade","Preço Médio","Custo Médio","Preço Mercado","Valor Mercado","% Retorno","Retorno"
        "8","R $ 78,00","R $ 624,00","R $ 70,00","R $ 560,00","-10.000","-R $ 64,00"
        "","","","","","",""
        "","","","","","",""
        "TABLE 4","","","","","",""
        "","","","","","",""
        "","","","ANON04","","",""
        "Quantidade","Preço Médio","Custo Médio","Preço Mercado","Valor Mercado","% Retorno","Retorno"
        "7","R $ 81,00","R $ 567,00","R $ 70,50","R $ 493,50","-13.000","-R $ 73,50"
        "","","","","","",""
        "","","","","","",""
        "TABLE 5","","","","","",""
        "","","","","","",""
        "","","","ANON05","","",""
        "Quantidade","Preço Médio","Custo Médio","Preço Mercado","Valor Mercado","% Retorno","Retorno"
        "7","R $ 85,00","R $ 595,00","R $ 84,00","R $ 588,00","-1.000","-R $ 7,00"
        "","","","","","",""
        "","","","","","",""
        "TABLE 6","","","","","",""
        "","","","","","",""
        "","","","ANON06","","",""
        "Quantidade","Preço Médio","Custo Médio","Preço Mercado","Valor Mercado","% Retorno","Retorno"
        "6","R $ 101,00","R $ 606,00","R $ 85,00","R $ 510,00","-15.000","-R $ 96,00"
        """

        attrs = %{
          content: content,
          title: "Renda Variável",
          type: :renda_variavel
        }

        build(:csv, attrs)
      end
    end
  end
end
