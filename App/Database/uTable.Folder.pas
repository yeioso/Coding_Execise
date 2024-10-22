unit uTable.Folder;

interface

Uses
  uFolder,
  uTable.Base,
  System.Classes;

Type
  ///<summary>
  //  Class that is responsible for managing the business rules of the folders
  ///</summary>
  TTable_Folder = Class(TTable_Base)
  Private
  Public
    ///<summary>
    ///Unique identifier of the table
    ///</summary>
    Class Function Id : String; override;
    ///<summary>
    ///Name of table
    ///</summary>
    Class Function Name : String; override;
    ///<summary>
    ///Caption or description of the table
    ///</summary>
    Class Function Caption : String; override;
    ///<summary>
    ///Method that loads the sql statement from the folder table structure
    ///</summary>
    ///<summary>
    ///ASentence : TStrings, container that will hold the SQL statement for creating the folder table structure
    ///</summary>
    Procedure GetSQL(Const ASentence : TStrings); override;
    ///<summary>
    ///Function that is responsible for saving the folder information to the database
    ///</summary>
    ///<summary>
    ///  AParent : TFolder, Object containing the information of the parent folder
    ///</summary>
    ///<summary>
    ///  ACode : String, unique identifier of the folder
    ///</summary>
    ///<summary>
    ///  AName : String, name of the folder
    ///</summary>
    Class Function SaveBD(AParent : TFolder; const ACode, AName: String): Boolean;
  End;

implementation

Uses
  System.SysUtils;

{ TTable_Folder }

class function TTable_Folder.Id: String;
begin
  Result := '001';
end;

class function TTable_Folder.Name: String;
begin
  Result := 'T' + Id + 'FOLDER';
end;

class function TTable_Folder.Caption: String;
begin
  Result := 'Folder';
end;

Procedure TTable_Folder.GetSQL(Const ASentence : TStrings);
begin
  Inherited;
  ASentence.Clear;
  ASentence.Add(' CREATE TABLE ' + Name );
  ASentence.Add(' ( ');
  ASentence.Add('     FOLDER_ID VARCHAR (030) ');
  ASentence.Add('    ,FOLDER_NAME VARCHAR (255) ');
  ASentence.Add('    ,FOLDER_PARENT VARCHAR (030) ');
  ASentence.Add('    ,PRIMARY KEY (FOLDER_ID) ');
  ASentence.Add('    ,FOREIGN KEY(FOLDER_PARENT) REFERENCES ' + Name + '(FOLDER_ID) ON DELETE CASCADE ');
  ASentence.Add(' ) ');
end;

//Function that is responsible for saving the folder information to the database
class function TTable_Folder.SaveBD(AParent : TFolder; const ACode, AName: String): Boolean;
Var
  lT : TTable_Folder;
begin
  lT := TTable_Folder.Create;
  Try
    lT.Con.Query.Active := False;
    lT.Con.Query.SQL.Clear;
    lT.Con.Query.SQL.Add(' INSERT INTO ' + Name);
    lT.Con.Query.SQL.Add(' ( ');
    lT.Con.Query.SQL.Add('    FOLDER_ID ');
    lT.Con.Query.SQL.Add('   ,FOLDER_NAME ');
    If Assigned(AParent) Then
      lT.Con.Query.SQL.Add('   ,FOLDER_PARENT ');
    lT.Con.Query.SQL.Add(' ) ');
    lT.Con.Query.SQL.Add(' VALUES ');
    lT.Con.Query.SQL.Add(' ( ');
    lT.Con.Query.SQL.Add( '   ' + ACode.QuotedString);
    lT.Con.Query.SQL.Add( '  ,' + AName.Trim.QuotedString);
    If Assigned(AParent) Then
      lT.Con.Query.SQL.Add( '  ,' + AParent.ID.QuotedString);
    lT.Con.Query.SQL.Add(' ) ');
    lT.Con.Query.ExecSQL;
    Result := lT.Con.Query.RowsAffected > 0;
    lT.Con.Query.Active := False;
    lT.Con.Query.SQL.Clear;
  Finally
    lT.Con.Query.Active := False;
    lT.Con.Query.SQL.Clear;
    FreeAndNil(lT);
  End;
end;

end.
