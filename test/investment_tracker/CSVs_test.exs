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

      update_attrs = %{content: content} = params_for(:update_fundos_csv)

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

    test "import_csv/1 successfully imports investments from a renda fixa CSV" do
      attrs = params_for(:renda_fixa_csv)

      assert {
               :ok,
               [
                 ok: %Investment{
                   current_value: 336_524,
                   id: id_1,
                   initial_value: 311_729,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_1,
                       value: 336_524
                     }
                   ],
                   name: "LCI MNO",
                   subtype: :lci_lca,
                   type: :renda_fixa,
                   expiration_date: ~D[2023-08-11]
                 },
                 ok: %Investment{
                   current_value: 329_238,
                   id: id_2,
                   initial_value: 311_214,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_2,
                       value: 329_238
                     }
                   ],
                   name: "LCA XYZ",
                   subtype: :lci_lca,
                   type: :renda_fixa,
                   expiration_date: ~D[2023-08-12]
                 },
                 ok: %Investment{
                   current_value: 573_425,
                   id: id_3,
                   initial_value: 557_361,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_3,
                       value: 573_425
                     }
                   ],
                   name: "DEBENTURE LIGHB6",
                   subtype: :debentures,
                   type: :renda_fixa,
                   expiration_date: ~D[2025-10-17]
                 },
                 ok: %Investment{
                   current_value: 203_456,
                   id: id_4,
                   initial_value: 290_034,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_4,
                       value: 203_456
                     }
                   ],
                   name: "CRI STRAIGHTS175E2",
                   subtype: :cri_cra,
                   type: :renda_fixa,
                   expiration_date: ~D[2024-11-20]
                 },
                 ok: %Investment{
                   current_value: 112_830,
                   id: id_5,
                   initial_value: 107_825,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_5,
                       value: 112_830
                     }
                   ],
                   name: "CRA GREEN130S2",
                   subtype: :cri_cra,
                   type: :renda_fixa,
                   expiration_date: ~D[2029-07-17]
                 },
                 ok: %Investment{
                   current_value: 1_231_149,
                   id: id_6,
                   initial_value: 1_200_000,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_6,
                       value: 1_231_149
                     }
                   ],
                   name: "CDB LIMIT PLUS",
                   subtype: :cdb,
                   type: :renda_fixa,
                   expiration_date: ~D[2026-01-01]
                 },
                 ok: %Investment{
                   current_value: 121_921,
                   id: id_7,
                   initial_value: 105_000,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_7,
                       value: 121_921
                     }
                   ],
                   name: "CDB YZC",
                   subtype: :cdb,
                   type: :renda_fixa,
                   expiration_date: ~D[2024-01-01]
                 }
               ]
             } = CSVs.import_csv(attrs)

      assert [_csv] = Repo.all(CSV)
    end

    test "import_csv/1 successfully imports investments from a renda variavel CSV" do
      attrs = params_for(:renda_variavel_csv)

      assert {
               :ok,
               [
                 ok: %Investment{
                   current_value: 60_450,
                   id: id_1,
                   initial_value: 63_300,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_1,
                       value: 60_450
                     }
                   ],
                   name: "ANON01",
                   subtype: :fiis,
                   type: :renda_variavel
                 },
                 ok: %Investment{
                   current_value: 44_000,
                   id: id_2,
                   initial_value: 52_000,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_2,
                       value: 44_000
                     }
                   ],
                   name: "ANON02",
                   subtype: :fiis,
                   type: :renda_variavel
                 },
                 ok: %Investment{
                   current_value: 56_000,
                   id: id_3,
                   initial_value: 62_400,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_3,
                       value: 56_000
                     }
                   ],
                   name: "ANON03",
                   subtype: :fiis,
                   type: :renda_variavel
                 },
                 ok: %Investment{
                   current_value: 49_350,
                   id: id_4,
                   initial_value: 56_700,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_4,
                       value: 49_350
                     }
                   ],
                   name: "ANON04",
                   subtype: :fiis,
                   type: :renda_variavel
                 },
                 ok: %Investment{
                   current_value: 58_800,
                   id: id_5,
                   initial_value: 59_500,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_5,
                       value: 58_800
                     }
                   ],
                   name: "ANON05",
                   subtype: :fiis,
                   type: :renda_variavel
                 },
                 ok: %Investment{
                   current_value: 51_000,
                   id: id_6,
                   initial_value: 60_600,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_6,
                       value: 51_000
                     }
                   ],
                   name: "ANON06",
                   subtype: :fiis,
                   type: :renda_variavel
                 }
               ]
             } = CSVs.import_csv(attrs)

      assert [_csv] = Repo.all(CSV)
    end

    test "import_csv/1 successfully imports investments from a tesouro direto CSV" do
      attrs = params_for(:tesouro_direto_csv)

      assert {
               :ok,
               [
                 ok: %Investment{
                   current_value: 2_676_504,
                   id: id_1,
                   initial_value: 2_443_023,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_1,
                       value: 2_676_504
                     }
                   ],
                   name: "Tesouro Selic 2025",
                   subtype: :selic,
                   type: :tesouro_direto,
                   expiration_date: ~D[2025-03-01]
                 },
                 ok: %Investment{
                   current_value: 3_490_543,
                   id: id_2,
                   initial_value: 3_123_456,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_2,
                       value: 3_490_543
                     }
                   ],
                   name: "Tesouro Prefixado 2029",
                   subtype: :prefixado,
                   type: :tesouro_direto,
                   expiration_date: ~D[2029-12-01]
                 },
                 ok: %Investment{
                   current_value: 6_123_456,
                   id: id_3,
                   initial_value: 5_543_212,
                   investment_histories: [
                     %InvestmentHistory{
                       investment_id: id_3,
                       value: 6_123_456
                     }
                   ],
                   name: "Tesouro IPCA+ Com Juros Semestrais 2032",
                   subtype: :ipca,
                   type: :tesouro_direto,
                   expiration_date: ~D[2032-08-15]
                 }
               ]
             } = CSVs.import_csv(attrs)

      assert [_csv] = Repo.all(CSV)
    end
  end
end
