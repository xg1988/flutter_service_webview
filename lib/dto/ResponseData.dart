class ResponseData {
  final List<Code> body;
  final int size;
  final String resultCode;
  final String resultMessage;
  final int code;
  final int total;

  ResponseData({
    required this.body,
    required this.size,
    required this.resultCode,
    required this.resultMessage,
    required this.code,
    required this.total,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    var bodyList = json['body'] as List;
    List<Code> body = bodyList.map((codeJson) => Code.fromJson(codeJson)).toList();

    return ResponseData(
      body: body,
      size: json['size'],
      resultCode: json['resultCode'],
      resultMessage: json['resultMessage'],
      code: json['code'],
      total: json['total'],
    );
  }
}

class Code {
  final String codeId;
  final String codeCategoryId;
  final String codeName;
  final String codeValue;
  final String codeEngName;
  final String codeDesc;
  final String useYn;
  final String codeOrder;

  Code({
    required this.codeId,
    required this.codeCategoryId,
    required this.codeName,
    required this.codeValue,
    required this.codeEngName,
    required this.codeDesc,
    required this.useYn,
    required this.codeOrder,
  });

  factory Code.fromJson(Map<String, dynamic> json) {
    return Code(
      codeId: json['codeId'],
      codeCategoryId: json['codeCategoryId'],
      codeName: json['codeName'],
      codeValue: json['codeValue'],
      codeEngName: json['codeEngName'],
      codeDesc: json['codeDesc'],
      useYn: json['useYn'],
      codeOrder: json['codeOrder'],
    );
  }
}
