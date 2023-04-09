defmodule InvestmentTracker.CSVsTest do
  @moduledoc false
  use InvestmentTracker.DataCase, async: true

  import InvestmentTracker.Factory

  alias InvestmentTracker.CSVs
  alias InvestmentTracker.CSVs.CSV
  alias InvestmentTracker.Wallet.Investment
  alias InvestmentTracker.Wallet.InvestmentHistory
  alias InvestmentTracker.Wallet.Operation

  describe "csvs" do
    @invalid_attrs %{content: nil, title: nil, type: nil}

    test "list_csvs/0 returns all csvs" do
      csv = insert(:csv)
      assert CSVs.list_csvs() == [csv]
    end

    test "get_csv!/1 returns the csv with given id" do
      csv = insert(:csv)
      assert CSVs.get_csv!(csv.id) == csv
    end

    test "create_csv/1 with valid data creates a csv" do
      valid_attrs = %{content: "some content", title: "some title", type: :renda_fixa}

      assert {:ok, %CSV{} = csv} = CSVs.create_csv(valid_attrs)
      assert csv.content == "some content"
      assert csv.title == "some title"
      assert csv.type == :renda_fixa
    end

    test "create_csv/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CSVs.create_csv(@invalid_attrs)
    end

    test "update_csv/2 with valid data updates the csv" do
      csv = insert(:csv)

      update_attrs = %{
        content: "some updated content",
        title: "some updated title",
        type: :fundos
      }

      assert {:ok, %CSV{} = csv} = CSVs.update_csv(csv, update_attrs)
      assert csv.content == "some updated content"
      assert csv.title == "some updated title"
      assert csv.type == :fundos
    end

    test "update_csv/2 with invalid data returns error changeset" do
      csv = insert(:csv)
      assert {:error, %Ecto.Changeset{}} = CSVs.update_csv(csv, @invalid_attrs)
      assert csv == CSVs.get_csv!(csv.id)
    end

    test "delete_csv/1 deletes the csv" do
      csv = insert(:csv)
      assert {:ok, %CSV{}} = CSVs.delete_csv(csv)
      assert_raise Ecto.NoResultsError, fn -> CSVs.get_csv!(csv.id) end
    end

    test "change_csv/1 returns a csv changeset" do
      csv = insert(:csv)
      assert %Ecto.Changeset{} = CSVs.change_csv(csv)
    end
  end

  describe "import csv" do
    test "import_csv/1 successfully imports investments from a fundos CSV" do
      attrs = params_for(:fundos_csv)

      assert {
               :ok,
               [
                 {:ok,
                  %Investment{
                    id: id_1,
                    current_value: 689_292,
                    initial_value: 646_965,
                    name: "ANON ACCESS ABC CAPITAL FIM",
                    subtype: :multimercado,
                    type: :fundos,
                    investment_histories: [
                      %InvestmentHistory{
                        value: 689_292,
                        investment_id: id_1
                      }
                    ]
                  }},
                 {:ok,
                  %Investment{
                    id: id_2,
                    current_value: 500_796,
                    initial_value: 500_000,
                    name: "DAICHI KARAZUNO FIC FIM CP",
                    subtype: :multimercado,
                    type: :fundos,
                    investment_histories: [
                      %InvestmentHistory{
                        value: 500_796,
                        investment_id: id_2
                      }
                    ]
                  }},
                 {:ok,
                  %Investment{
                    id: id_3,
                    current_value: 202_163,
                    initial_value: 200_000,
                    name: "ANON ACCESS TRIGONOMETRY BS FIC FIM",
                    subtype: :multimercado,
                    type: :fundos,
                    investment_histories: [
                      %InvestmentHistory{
                        value: 202_163,
                        investment_id: id_3
                      }
                    ]
                  }},
                 {:ok,
                  %Investment{
                    id: id_4,
                    current_value: 522_196,
                    initial_value: 538_799,
                    name: "CALIFORNIAN WHATEVER US INDEX 500 FIM",
                    subtype: :multimercado,
                    type: :fundos,
                    investment_histories: [
                      %InvestmentHistory{
                        value: 522_196,
                        investment_id: id_4
                      }
                    ]
                  }},
                 {:ok,
                  %Investment{
                    id: id_5,
                    current_value: 5705,
                    initial_value: 5702,
                    name: "ANON RENDA AMAZING FIRF LP",
                    subtype: :renda_fixa,
                    type: :fundos,
                    investment_histories: [
                      %InvestmentHistory{
                        value: 5705,
                        investment_id: id_5
                      }
                    ]
                  }},
                 {:ok,
                  %Investment{
                    id: id_6,
                    current_value: 518_714,
                    initial_value: 494_986,
                    name: "CUTE HAMTARO STH FIC FIM",
                    subtype: :multimercado,
                    type: :fundos,
                    investment_histories: [
                      %InvestmentHistory{
                        value: 518_714,
                        investment_id: id_6
                      }
                    ]
                  }},
                 {:ok,
                  %Investment{
                    id: id_8,
                    current_value: 151_657,
                    initial_value: 150_000,
                    name: "ANON RENDA FIRF CP",
                    subtype: :renda_fixa,
                    type: :fundos,
                    investment_histories: [
                      %InvestmentHistory{
                        value: 151_657,
                        investment_id: id_8
                      }
                    ]
                  }},
                 {:ok,
                  %Investment{
                    id: id_9,
                    current_value: 1_003_332,
                    initial_value: 1_000_000,
                    name: "ANON RARE FIRF CP",
                    subtype: :renda_fixa,
                    type: :fundos,
                    investment_histories: [
                      %InvestmentHistory{
                        value: 1_003_332,
                        investment_id: id_9
                      }
                    ]
                  }},
                 {:ok,
                  %Investment{
                    id: id_10,
                    current_value: 68_006,
                    initial_value: 69_990,
                    name: "ANON SELECTION MULTIESTRATEGIA FIC FIM",
                    subtype: :multimercado,
                    type: :fundos,
                    investment_histories: [
                      %InvestmentHistory{
                        value: 68_006,
                        investment_id: id_10
                      }
                    ]
                  }},
                 {:ok,
                  %Investment{
                    id: id_11,
                    current_value: 3_613_420,
                    initial_value: 3_500_000,
                    name: "ALPHA OMEGA GLOBAL FIC FIM",
                    subtype: :multimercado,
                    type: :fundos,
                    investment_histories: [
                      %InvestmentHistory{
                        value: 3_613_420,
                        investment_id: id_11
                      }
                    ]
                  }}
               ]
             } = CSVs.import_csv(attrs)

      assert [_csv] = Repo.all(CSV)
    end

    test "import_csv/1 successfully updates investments from a fundos CSV" do
      attrs = params_for(:fundos_csv)

      # create investments

      CSVs.import_csv(attrs)

      # update investments

      content = """
      "","","","","","","",""
      "TABLE 1","","","","","","",""
      "","","","","","","",""
      "","","","ANON ACCESS","ABC CAPITAL","FIM","",""
      "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
      "01/01/2023","5108.42276296","R $ 1,36241335","R $ 6.469,65","R $ 6.959,78","R $ 66,86","R $ 0,00","R $ 6.992,92"
      "","","","","","","",""
      "","","","","","","",""
      "TABLE 2","","","","","","",""
      "","","","","","","",""
      "","","","DAICHI KARAZUNO","FIC FIM CP","","",""
      "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
      "01/01/2023","3574.40272981","R $ 1,40170440","R $ 5.000,00","R $ 5.010,26","R $ 2,30","R $ 0,00","R $ 5.002,96"
      "","","","","","","",""
      "","","","","","","",""
      "TABLE 3","","","","","","",""
      "","","","","","","",""
      "","","","ANON ACCESS","TRIGONOMETRY BS FIC","FIM","",""
      "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
      "03/12/2022","1599.12639086","R $ 1,26813128","R $ 2.000,00","R $ 2.027,90","R $ 6,27","R $ 0,00","R $ 2.421,63"
      "","","","","","","",""
      "","","","","","","",""
      "TABLE 4","","","","","","",""
      "","","","","","","",""
      "","","","CALIFORNIAN WHATEVER","US INDEX 500 FIM","","",""
      "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
      "03/12/2022","1093.6281063","R $ 4,77489460","R $ 5.387,99","R $ 5.221,96","R $ 0,00","R $ 0,00","R $ 5.211,96"
      "","","","","","","",""
      "","","","","","","",""
      "TABLE 5","","","","","","",""
      "","","","","","","",""
      "","","","ANON RENDA","AMAZING FIRF","LP","",""
      "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
      "03/12/2022","15.73414415","R $ 3,63290045","R $ 57,02","R $ 57,16","R $ 0,00","R $ 0,11","R $ 77,05"
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
      "03/12/2022","774.37288715","R $ 1,96464388","R $ 1.500,00","R $ 1.521,37","R $ 4,80","R $ 0,00","R $ 1.518,57"
      "","","","","","","",""
      "","","","","","","",""
      "TABLE 8","","","","","","",""
      "","","","","","","",""
      "","","","ANON","RARE FIRF CP","","",""
      "Data Cotação","Qtde Cota","Valor Cota","Valor Aplicado","Valor Bruto","IR Previsto","IOF Previsto","Valor Liquido"
      "03/12/2022","7988.18764326","R $ 1,26025674","R $ 10.000,00","R $ 10.067,17","R $ 9,67","R $ 24,18","R $ 12.033,32"
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
      "08/11/2022","21994.01998227","R $ 1,66128320","R $ 35.000,00","R $ 36.538,29","R $ 329,28","R $ 784,81","R $ 36.134,20"
      """

      update_attrs = %{
        content: content,
        title: "Fundos",
        type: :fundos
      }

      assert {
               :ok,
               [
                 {:ok,
                  {:updated,
                   %Investment{
                     id: id_1,
                     current_value: 699_292,
                     initial_value: 646_965,
                     name: "ANON ACCESS ABC CAPITAL FIM",
                     subtype: :multimercado,
                     type: :fundos,
                     investment_histories: [
                       %InvestmentHistory{
                         value: 689_292,
                         investment_id: id_1
                       },
                       %InvestmentHistory{
                         value: 699_292,
                         investment_id: id_1
                       }
                     ]
                   },
                   %Operation{
                     type: :update,
                     value: 10_000,
                     investment_id: id_1
                   }}},
                 {:ok,
                  {:updated,
                   %Investment{
                     id: id_2,
                     current_value: 500_296,
                     initial_value: 500_000,
                     name: "DAICHI KARAZUNO FIC FIM CP",
                     subtype: :multimercado,
                     type: :fundos,
                     investment_histories: [
                       %InvestmentHistory{
                         value: 500_796,
                         investment_id: id_2
                       },
                       %InvestmentHistory{
                         value: 500_296,
                         investment_id: id_2
                       }
                     ]
                   },
                   %Operation{
                     type: :update,
                     value: -500,
                     investment_id: id_2
                   }}},
                 ok:
                   {:updated,
                    %Investment{
                      id: id_3,
                      current_value: 242_163,
                      initial_value: 200_000,
                      name: "ANON ACCESS TRIGONOMETRY BS FIC FIM",
                      subtype: :multimercado,
                      type: :fundos,
                      investment_histories: [
                        %InvestmentHistory{
                          value: 202_163,
                          investment_id: id_3
                        },
                        %InvestmentHistory{
                          value: 242_163,
                          investment_id: id_3
                        }
                      ]
                    },
                    %Operation{
                      type: :update,
                      value: 40_000,
                      investment_id: id_3
                    }},
                 ok:
                   {:updated,
                    %Investment{
                      id: id_4,
                      current_value: 521_196,
                      initial_value: 538_799,
                      name: "CALIFORNIAN WHATEVER US INDEX 500 FIM",
                      subtype: :multimercado,
                      type: :fundos,
                      investment_histories: [
                        %InvestmentHistory{
                          value: 522_196,
                          investment_id: id_4
                        },
                        %InvestmentHistory{
                          value: 521_196,
                          investment_id: id_4
                        }
                      ]
                    },
                    %Operation{
                      type: :update,
                      value: -1000,
                      investment_id: id_4
                    }},
                 ok:
                   {:updated,
                    %Investment{
                      id: id_5,
                      current_value: 7705,
                      initial_value: 5702,
                      name: "ANON RENDA AMAZING FIRF LP",
                      subtype: :renda_fixa,
                      type: :fundos,
                      investment_histories: [
                        %InvestmentHistory{
                          value: 5705,
                          investment_id: id_5
                        },
                        %InvestmentHistory{
                          value: 7705,
                          investment_id: id_5
                        }
                      ]
                    },
                    %Operation{
                      type: :update,
                      value: 2000,
                      investment_id: id_5
                    }},
                 ok: %Investment{
                   current_value: 518_714,
                   id: _id_6,
                   initial_value: 494_986,
                   name: "CUTE HAMTARO STH FIC FIM",
                   subtype: :multimercado,
                   type: :fundos
                 },
                 ok:
                   {:updated,
                    %Investment{
                      id: id_8,
                      current_value: 151_857,
                      initial_value: 150_000,
                      name: "ANON RENDA FIRF CP",
                      subtype: :renda_fixa,
                      type: :fundos,
                      investment_histories: [
                        %InvestmentHistory{
                          value: 151_657,
                          investment_id: id_8
                        },
                        %InvestmentHistory{
                          value: 151_857,
                          investment_id: id_8
                        }
                      ]
                    },
                    %Operation{
                      type: :update,
                      value: 200,
                      investment_id: id_8
                    }},
                 ok:
                   {:updated,
                    %Investment{
                      id: id_9,
                      current_value: 1_203_332,
                      initial_value: 1_000_000,
                      name: "ANON RARE FIRF CP",
                      subtype: :renda_fixa,
                      type: :fundos,
                      investment_histories: [
                        %InvestmentHistory{
                          value: 1_003_332,
                          investment_id: id_9
                        },
                        %InvestmentHistory{
                          value: 1_203_332,
                          investment_id: id_9
                        }
                      ]
                    },
                    %Operation{
                      type: :update,
                      value: 200_000,
                      investment_id: id_9
                    }},
                 ok: %Investment{
                   current_value: 68_006,
                   id: _id_10,
                   initial_value: 69_990,
                   name: "ANON SELECTION MULTIESTRATEGIA FIC FIM",
                   subtype: :multimercado,
                   type: :fundos
                 },
                 ok: %Investment{
                   current_value: 3_613_420,
                   id: _id_11,
                   initial_value: 3_500_000,
                   name: "ALPHA OMEGA GLOBAL FIC FIM",
                   subtype: :multimercado,
                   type: :fundos
                 }
               ]
             } = CSVs.import_csv(update_attrs)

      assert [_csv1, _csv2] = Repo.all(CSV)
    end
  end
end
