unit uTable.Document;

interface

Uses
  uTable.Base,
  System.Classes;

Type
  ///<summary>
  ///Class that is responsible for managing the business rules of the documents
  ///</summary>
  TTable_Document = Class(TTable_Base)
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
    Procedure GetSQL(Const ASentence : TStrings); override; //Method that loads the sql statement from the folder table structure
    ///<summary>
    ///Function that is responsible for deleting a document
    ///</summary>
    Class Function Delete(Const pID : String) : Boolean;
  End;

implementation

Uses
  uDatabase,
  uTable.Folder,
  System.SysUtils;

{ TTable_Document }

class function TTable_Document.Id: String;
begin
  Result := '002';
end;

class function TTable_Document.Name: String;
begin
  Result := 'T' + Id + 'DOCUMENT';
end;

class function TTable_Document.Caption: String;
begin
  Result := 'Document';
end;

//Method that loads the sql statement from the folder table structure
Procedure TTable_Document.GetSQL(Const ASentence : TStrings);
begin
  Inherited;
  ASentence.Clear;
  ASentence.Add(' CREATE TABLE ' + Name );
  ASentence.Add(' ( ');
  ASentence.Add('     FOLDER_ID VARCHAR (030) ');
  ASentence.Add('    ,DOCUMENT_ID VARCHAR (030) ');
  ASentence.Add('    ,DOCUMENT_NAME VARCHAR (100) ');
  ASentence.Add('    ,DOCUMENT_ADDED VARCHAR (030) ');
  ASentence.Add('    ,DOCUMENT_MODIFIED VARCHAR (030) ');
  ASentence.Add('    ,DOCUMENT_SIZE INT ');
  ASentence.Add('    ,DOCUMENT_DESCRIPTION VARCHAR (100) ');
  ASentence.Add('    ,DOCUMENT_TAGS VARCHAR (100) ');
  ASentence.Add('    ,DOCUMENT_TYPE VARCHAR (050) ');
  ASentence.Add('    ,DOCUMENT_AUTHOR VARCHAR (255) ');
  ASentence.Add('    ,DOCUMENT_PUBLICATION VARCHAR (030) ');
  ASentence.Add('    ,DOCUMENT_VERSION VARCHAR (030) ');
  ASentence.Add('    ,DOCUMENT_ENCRYPTION VARCHAR (030) ');
  ASentence.Add('    ,DOCUMENT_SUMMARY VARCHAR (030) ');
  ASentence.Add('    ,FOREIGN KEY(FOLDER_ID) REFERENCES ' + TTable_Folder.Name + '(FOLDER_ID) ON DELETE CASCADE ');
  ASentence.Add(' ) ');
end;

//Function that is responsible for deleting a document
Class Function TTable_Document.Delete(Const pID : String) : Boolean;
Begin
  //Delete a specific document
  Try
    TDatabaseManager.GetInstance.Query.Active := False;
    TDatabaseManager.GetInstance.Query.SQL.Clear;
    TDatabaseManager.GetInstance.Query.SQL.Add(' DELETE FROM ' + Name);
    TDatabaseManager.GetInstance.Query.SQL.Add(' WHERE TRIM(DOCUMENT_ID) = ' + pID.Trim.QuotedString);
    TDatabaseManager.GetInstance.Query.ExecSQL;
    Result := TDatabaseManager.GetInstance.Query.RowsAffected > 0;
  Finally
    TDatabaseManager.GetInstance.Query.Active := False;
    TDatabaseManager.GetInstance.Query.SQL.Clear;
  End;
End;

end.
