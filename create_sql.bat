@if(0)==(0) echo off
rem -*- coding: sjis -*-

chcp 932

cscript.exe //nologo //E:JScript "%~f0" "%~dp0"

echo �I�����܂���
@pause

GOTO :EOF
@end

var fso =  new ActiveXObject("Scripting.FileSystemObject");
var batchPath = WScript.Arguments.Unnamed(0);
var path = "\\21_�݌v\\03_�f�[�^�x�[�X�݌v";
var excel = new ActiveXObject("Excel.Application");

var xlUp = -4162;

var cellInfo = [];
var fileNum = 0;

WScript.Echo("�������|�W�g�����w�肵�Ă�������");
cyoPath = WScript.StdIn.ReadLine();
path = cyoPath + path;

var files =  fso.GetFolder(path).Files;
var enume = new Enumerator(files);

WScript.Echo("�쐬����t�@�C���ʒu���w�肵�Ă�������");
WScript.Echo("1:�o�b�`�t�@�C���Ɠ��� 2:�f�[�^�x�[�X�d�l���Ɠ���");
location = WScript.StdIn.ReadLine();

var filePath = batchPath;

switch(location){
    case '1':
        filePath = batchPath;
    break;
    case '2':
        filePath = cyoPath + path + "\\SQL\\�f�[�^��`\\";
    break;
    default:
        filePath = batchPath;
    break;
}


var createFiles = [];
for(; !enume.atEnd(); enume.moveNext()){
    var fileLists =  enume.item();
    var fileName = fileLists.Name;
    if(fileName.search(/\.xls$/) == -1 || fileName == "�f�[�^�x�[�X�d�l��-���`.xls"){
        continue;
    }
    createFiles.push(fileName);
}

WScript.Echo("SQL���쐬����t�@�C�����w�肵�Ă�������");
WScript.Echo("0:�S��");
for(var x = 0; x < createFiles.length; x++){
    WScript.Echo((x+1)+":"+createFiles[x]);
}

var createFileNo = 0;
createFileNo = WScript.StdIn.ReadLine();

var createFile = '';
if(createFileNo > 0){
    createFileNo -= 1;
    createFile = createFiles[createFileNo];
}

enume = new Enumerator(files)

for(; !enume.atEnd(); enume.moveNext()){
    fileLists =  enume.item();
    fileName = fileLists.Name;

    if(fileName.search(/\.xls$/) == -1 || fileName == "�f�[�^�x�[�X�d�l��-���`.xls"){
        continue;
    }

    if(createFile != '' && fileName != createFile){
        continue;
    }

    WScript.Echo(fileName + " ������...");

    var book = excel.Workbooks.Open(path + "\\" + fileName, true, true);

    cellInfo[fileNum] = {};

    for(var i = 0; i < book.Worksheets.Count; i++){
        var sheetName = book.Worksheets.Item(i + 1).Name;
        if(sheetName != "�\��" && sheetName != "��������" && sheetName != "TableList" && sheetName != "�X�N���v�g�o�͂ɂ���"){

            var sheet = book.Worksheets(i + 1);

            if(sheet.Range("G2").Value.search(/_v2?_/) != -1){
                WScript.Echo("�V�[�g "+sheetName+" �̓X�L�b�v���܂�...");
                continue;
            }

            WScript.Echo("�V�[�g "+sheetName+" ��������...");
            cellInfo[fileNum][sheetName] = {};
            cellInfo[fileNum][sheetName]['tableName'] = sheet.Range("C2").Value;
            cellInfo[fileNum][sheetName]['tablePName'] = sheet.Range("G2").Value;

            cellInfo[fileNum][sheetName]['fields'] = [];

            var fieldNum = 0;
            var lastRow = sheet.Cells(sheet.Rows.Count, 2).End(xlUp).Row;

            for(var nowRow = 4; nowRow <= lastRow; nowRow++){
                cellInfo[fileNum][sheetName]['fields'][fieldNum] = {};
                cellInfo[fileNum][sheetName]['fields'][fieldNum]['field'] = sheet.Range('B'+nowRow).Value;
                cellInfo[fileNum][sheetName]['fields'][fieldNum]['fieldName'] = sheet.Range('C'+nowRow).Value;
                cellInfo[fileNum][sheetName]['fields'][fieldNum]['type'] = sheet.Range('D'+nowRow).Value;
                cellInfo[fileNum][sheetName]['fields'][fieldNum]['size'] = sheet.Range('E'+nowRow).Value;
                cellInfo[fileNum][sheetName]['fields'][fieldNum]['primaryKey'] = sheet.Range('F'+nowRow).Value;
                cellInfo[fileNum][sheetName]['fields'][fieldNum]['unieqKey'] = sheet.Range('G'+nowRow).Value;
                cellInfo[fileNum][sheetName]['fields'][fieldNum]['forerignKeyTable'] = sheet.Range('H'+nowRow).Value;
                cellInfo[fileNum][sheetName]['fields'][fieldNum]['forerignKeyField'] = sheet.Range('I'+nowRow).Value;
                cellInfo[fileNum][sheetName]['fields'][fieldNum]['require'] = sheet.Range('J'+nowRow).Value;
                cellInfo[fileNum][sheetName]['fields'][fieldNum]['default'] = sheet.Range('K'+nowRow).Value;
                cellInfo[fileNum][sheetName]['fields'][fieldNum]['memo'] = sheet.Range('L'+nowRow).Value;

                fieldNum += 1;
            }

            var idxNum = 0;
            cellInfo[fileNum][sheetName]['index'] = [];
            for(var idx = 14; ; idx++){
                if(sheet.Cells(3, idx).Value == undefined){
                    break;
                }
                var flag = false;
                for(var nowRow = 4; nowRow <= lastRow; nowRow++){
                    if(sheet.Cells(nowRow, idx).Value != undefined){
                        flag = true;
                    }
                }
                if(flag == true){
                    cellInfo[fileNum][sheetName]['index'][idxNum] = [];
                    for(var nowRow = 4; nowRow <= lastRow; nowRow++){
                        if(sheet.Cells(nowRow, idx).Value != undefined){
                            cellInfo[fileNum][sheetName]['index'][idxNum].push(sheet.Cells(nowRow, 3).Value);
                        }
                    }
                    idxNum += 1;
                }
            }

            WScript.Echo("�V�[�g "+sheetName+" ��������");
        }
    }

    WScript.Echo(fileName + " ��������");

    book.Close(false);

    fileNum += 1;
}

for(var i = 0; i < cellInfo.length; i++){
    for(var sheet in cellInfo[i]){

        if(fso.FileExists(filePath + cellInfo[i][sheet]['tablePName'] + '.sql')){
            fso.DeleteFile(filePath + cellInfo[i][sheet]['tablePName'] + '.sql', true);
        }

        WScript.Echo(cellInfo[i][sheet]['tablePName'] + '.sql ���쐬��...');

        var file = fso.OpenTextFile(filePath + cellInfo[i][sheet]['tablePName'] + '.sql', 8, true, 0);
        file.Write("--DROP TABLE "+cellInfo[i][sheet]['tablePName']+";\n");
        file.Write("CREATE TABLE "+cellInfo[i][sheet]['tablePName']+"(\n");

        var pKey = [];
        var uKey = [];
        var fKey = [];

        for(var fi = 0; fi < cellInfo[i][sheet]['fields'].length; fi++){
            file.Write(cellInfo[i][sheet]['fields'][fi]['fieldName']);
            file.Write(' '+cellInfo[i][sheet]['fields'][fi]['type']);
            if(cellInfo[i][sheet]['fields'][fi]['size'] != undefined){
                file.Write(' ('+cellInfo[i][sheet]['fields'][fi]['size']+')');
            }
            if(cellInfo[i][sheet]['fields'][fi]['type'] != 'serial' && cellInfo[i][sheet]['fields'][fi]['require'] != undefined){
                file.Write(' not null');
            }
            if(cellInfo[i][sheet]['fields'][fi]['default'] != undefined){
                file.Write(' default('+cellInfo[i][sheet]['fields'][fi]['default']+')');
            }
            file.Write(",\n");

            if(cellInfo[i][sheet]['fields'][fi]['primaryKey'] != undefined){
                pKey.push(cellInfo[i][sheet]['fields'][fi]['fieldName']);
            }

            if(cellInfo[i][sheet]['fields'][fi]['unieqKey'] != undefined){
                uKey.push(cellInfo[i][sheet]['fields'][fi]['fieldName']);
            }

            if(cellInfo[i][sheet]['fields'][fi]['forerignKeyField'] != undefined){
                fKey.push('('+cellInfo[i][sheet]['fields'][fi]['fieldName']+') REFERENCES '+cellInfo[i][sheet]['fields'][fi]['forerignKeyTable'] + '(' + cellInfo[i][sheet]['fields'][fi]['fieldName'] + ')');
            }
        }

        file.Write("PRIMARY KEY(");
        for(var x = 0; x < pKey.length; x++){
            file.Write(pKey[x]);
            if(x < pKey.length - 1){
                file.Write(',');
            }
        }
        file.Write(")\n");
        file.Write(");\n");

        // ���j�[�N�L�[�ݒ�
        if(uKey.length > 0){
            file.Write("ALTER TABLE "+cellInfo[i][sheet]['tablePName']+" ADD CONSTRAINT "+cellInfo[i][sheet]['tablePName']+"_uniquekey UNIQUE(");
            for(var x = 0; x < uKey.length; x++){
                file.Write(uKey[x]);
                if(x < uKey.length - 1){
                    file.Write(',');
                }
            }
            file.Write(");\n");
        }

        // �C���f�b�N�X
        for(var id = 0; id < cellInfo[i][sheet]['index'].length; id++){
            file.Write("CREATE INDEX "+cellInfo[i][sheet]['tablePName']+"_0"+(id+1)+" ON "+cellInfo[i][sheet]['tablePName']+"(");
            for(var x = 0; x < cellInfo[i][sheet]['index'][id].length; x++){
                file.Write(cellInfo[i][sheet]['index'][id][x]);
                if(x < cellInfo[i][sheet]['index'][id].length - 1){
                    file.Write(',');
                }
            }
            file.Write(");\n");
        }

        // �O���L�[�ݒ�
        for(var x = 0; x < fKey.length; x++){
            file.Write("--ALTER TABLE "+cellInfo[i][sheet]['tablePName']+" ADD CONSTRAINT fp_"+cellInfo[i][sheet]['tablePName']+"_0"+(x+1)+" FOREIGN KEY ");
            file.Write(fKey[x]);
            file.Write(";\n");
        }

        // �V�[�P���X
        file.Write("CREATE SEQUENCE "+cellInfo[i][sheet]['tablePName']+"_seq;\n");
        file.Write("\n");

        // �R�����g
        file.Write("comment on table");
        file.Write(" "+cellInfo[i][sheet]['tablePName']);
        file.Write(" is");
        file.Write(" '"+cellInfo[i][sheet]['tableName']+"';\n");
        for(var fi = 0; fi < cellInfo[i][sheet]['fields'].length; fi++){
            file.Write("comment on column");
            file.Write(" "+cellInfo[i][sheet]['tablePName']+"."+cellInfo[i][sheet]['fields'][fi]['fieldName']);
            file.Write(" is");
            file.Write(" '"+cellInfo[i][sheet]['fields'][fi]['field']+"';\n");
        }

        file.Close();

        WScript.Echo(cellInfo[i][sheet]['tablePName'] + '.sql �쐬���܂���');
    }
}

WScript.Quit();
