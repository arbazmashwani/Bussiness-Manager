// To parse this JSON data, do
//
//     final adminModel = adminModelFromJson(jsonString);

import 'dart:convert';

List<AdminModel> adminModelFromJson(String str) =>
    List<AdminModel>.from(json.decode(str).map((x) => AdminModel.fromJson(x)));

String adminModelToJson(List<AdminModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminModel {
  AdminModel({
    this.userName,
    this.password,
    this.pBookV,
    this.pBookE,
    this.pBookD,
    this.pBookI,
    this.sBookV,
    this.sBookE,
    this.sBookD,
    this.sBookI,
    this.rBookV,
    this.rBookE,
    this.rBookD,
    this.rBookI,
    this.payBookV,
    this.payBookE,
    this.payBookD,
    this.payBookI,
    this.jBookV,
    this.jBookE,
    this.jBookD,
    this.jBookI,
    this.assets,
    this.liabilities,
    this.capital,
    this.expenses,
    this.revenue,
    this.stock,
    this.accBookV,
    this.accBookE,
    this.accBookD,
    this.accBookI,
    this.stkBookV,
    this.stkBookE,
    this.stkBookD,
    this.stkBookI,
    this.trialBalance,
    this.incomeStatement,
    this.balanceSheet,
    this.adjTrialBalance,
    this.addRemoveUsers,
    this.dataRestore,
    this.dataBackup,
    this.chartBookV,
    this.chartBookE,
    this.chartBookD,
    this.chartBookI,
    this.tBookV,
    this.tBookE,
    this.tBookI,
    this.tBookD,
    this.userRate,
  });

  String? userName;
  String? password;
  bool? pBookV;
  bool? pBookE;
  bool? pBookD;
  bool? pBookI;
  bool? sBookV;
  bool? sBookE;
  bool? sBookD;
  bool? sBookI;
  bool? rBookV;
  bool? rBookE;
  bool? rBookD;
  bool? rBookI;
  bool? payBookV;
  bool? payBookE;
  bool? payBookD;
  bool? payBookI;
  bool? jBookV;
  bool? jBookE;
  bool? jBookD;
  bool? jBookI;
  bool? assets;
  bool? liabilities;
  bool? capital;
  bool? expenses;
  bool? revenue;
  bool? stock;
  bool? accBookV;
  bool? accBookE;
  bool? accBookD;
  bool? accBookI;
  bool? stkBookV;
  bool? stkBookE;
  bool? stkBookD;
  bool? stkBookI;
  bool? trialBalance;
  bool? incomeStatement;
  bool? balanceSheet;
  bool? adjTrialBalance;
  bool? addRemoveUsers;
  bool? dataRestore;
  bool? dataBackup;
  bool? chartBookV;
  bool? chartBookE;
  bool? chartBookD;
  bool? chartBookI;
  bool? tBookV;
  bool? tBookE;
  bool? tBookI;
  bool? tBookD;
  bool? userRate;

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        userName: json["UserName"],
        password: json["Password"],
        pBookV: json["PBook_V"] ?? false,
        pBookE: json["PBook_E"] ?? false,
        pBookD: json["PBook_D"] ?? false,
        pBookI: json["PBook_I"] ?? false,
        sBookV: json["SBook_V"] ?? false,
        sBookE: json["SBook_E"] ?? false,
        sBookD: json["SBook_D"] ?? false,
        sBookI: json["SBook_I"] ?? false,
        rBookV: json["RBook_V"] ?? false,
        rBookE: json["RBook_E"] ?? false,
        rBookD: json["RBook_D"] ?? false,
        rBookI: json["RBook_I"] ?? false,
        payBookV: json["PayBook_V"] ?? false,
        payBookE: json["PayBook_E"] ?? false,
        payBookD: json["PayBook_D"] ?? false,
        payBookI: json["PayBook_I"] ?? false,
        jBookV: json["JBook_V"] ?? false,
        jBookE: json["JBook_E"] ?? false,
        jBookD: json["JBook_D"] ?? false,
        jBookI: json["JBook_I"] ?? false,
        assets: json["Assets"] ?? false,
        liabilities: json["Liabilities"] ?? false,
        capital: json["Capital"] ?? false,
        expenses: json["Expenses"] ?? false,
        revenue: json["Revenue"] ?? false,
        stock: json["Stock"] ?? false,
        accBookV: json["AccBook_V"] ?? false,
        accBookE: json["AccBook_E"] ?? false,
        accBookD: json["AccBook_D"] ?? false,
        accBookI: json["AccBook_I"] ?? false,
        stkBookV: json["StkBook_V"] ?? false,
        stkBookE: json["StkBook_E"] ?? false,
        stkBookD: json["StkBook_D"] ?? false,
        stkBookI: json["StkBook_I"] ?? false,
        trialBalance: json["TrialBalance"] ?? false,
        incomeStatement: json["IncomeStatement"] ?? false,
        balanceSheet: json["BalanceSheet"] ?? false,
        adjTrialBalance: json["AdjTrialBalance"] ?? false,
        addRemoveUsers: json["AddRemoveUsers"] ?? false,
        dataRestore: json["Data_Restore"] ?? false,
        dataBackup: json["Data_Backup"] ?? false,
        chartBookV: json["ChartBook_V"] ?? false,
        chartBookE: json["ChartBook_E"] ?? false,
        chartBookD: json["ChartBook_D"] ?? false,
        chartBookI: json["ChartBook_I"] ?? false,
        tBookV: json["TBook_V"] ?? false,
        tBookE: json["TBook_E"] ?? false,
        tBookI: json["TBook_I"] ?? false,
        tBookD: json["TBook_D"] ?? false,
        userRate: json["UserRate"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "UserName": userName,
        "Password": password,
        "PBook_V": pBookV,
        "PBook_E": pBookE,
        "PBook_D": pBookD,
        "PBook_I": pBookI,
        "SBook_V": sBookV,
        "SBook_E": sBookE,
        "SBook_D": sBookD,
        "SBook_I": sBookI,
        "RBook_V": rBookV,
        "RBook_E": rBookE,
        "RBook_D": rBookD,
        "RBook_I": rBookI,
        "PayBook_V": payBookV,
        "PayBook_E": payBookE,
        "PayBook_D": payBookD,
        "PayBook_I": payBookI,
        "JBook_V": jBookV,
        "JBook_E": jBookE,
        "JBook_D": jBookD,
        "JBook_I": jBookI,
        "Assets": assets,
        "Liabilities": liabilities,
        "Capital": capital,
        "Expenses": expenses,
        "Revenue": revenue,
        "Stock": stock,
        "AccBook_V": accBookV,
        "AccBook_E": accBookE,
        "AccBook_D": accBookD,
        "AccBook_I": accBookI,
        "StkBook_V": stkBookV,
        "StkBook_E": stkBookE,
        "StkBook_D": stkBookD,
        "StkBook_I": stkBookI,
        "TrialBalance": trialBalance,
        "IncomeStatement": incomeStatement,
        "BalanceSheet": balanceSheet,
        "AdjTrialBalance": adjTrialBalance,
        "AddRemoveUsers": addRemoveUsers,
        "Data_Restore": dataRestore,
        "Data_Backup": dataBackup,
        "ChartBook_V": chartBookV,
        "ChartBook_E": chartBookE,
        "ChartBook_D": chartBookD,
        "ChartBook_I": chartBookI,
        "TBook_V": tBookV,
        "TBook_E": tBookE,
        "TBook_I": tBookI,
        "TBook_D": tBookD,
        "UserRate": userRate,
      };
}
