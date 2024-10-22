unit uCreate.Base;

interface

Uses
  uTable.Base,
  System.Classes,
  System.Generics.Collections;

Type
  ///<summary>
  ///Class responsible for managing the creation of the database
  ///</summary>
  TCreate_Base = Class(TObject)
    Private
      ///<summary>
      ///List of tables to be processed
      ///</summary>
      FTables : TTables_Base;
      ///<summary>
      /////Function that is responsible for creating the tables
      ///</summary>
      Function CreateTable : Boolean;
    Public
      ///<summary>
      ///function that is responsible for triggering the execution of the database creation
      ///</summary>
      Class Function Execute : Boolean;
      ///<summary>
      ///method that is responsible of preparing the tables available to be created and used in the application
      ///</summary>
      procedure AfterConstruction; override;
      ///<summary>
      ///method that is responsible for release of the list of tables
      ///</summary>
      procedure BeforeDestruction; override;
  End;

implementation
Uses
  uDatabase,
  uTable.Folder,
  System.SysUtils,
  uTable.Document;

procedure TCreate_Base.AfterConstruction;
begin
  inherited;

  FTables := TTables_Base.Create;
  FTables.Add(TTable_Folder.Create);
  FTables.Add(TTable_Document.Create);
end;

procedure TCreate_Base.BeforeDestruction;
begin
  If Assigned(FTables) Then
  Begin
    FTables.Clear;
    FTables := Nil;
  End;
  inherited;
end;

Function TCreate_Base.CreateTable : Boolean;
Var
  lI : Integer;
Begin
  lI := 0;
  Result := True;
  Try
    While (lI < FTables.Count) And Result Do //Iterates through all the tables defined in the program
    Begin
      If TDatabaseManager.GetInstance.LoadTablenames.IndexOf(FTables[lI].Name) <= -1 Then //Check if the table exists
      Begin
        FTables[lI].GetSQL(TDatabaseManager.GetInstance.Query.SQL);  //Loads the statement of the table structure to be created
        TDatabaseManager.GetInstance.Query.ExecSQL; //Execute the sql statement
      End;
      Inc(lI);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
    End;
  End;
End;

Class Function TCreate_Base.Execute : Boolean;
Var
  lCB : TCreate_Base;
Begin
  lCB := TCreate_Base.Create;
  Result := lCB.CreateTable;
  FreeAndNil(lCB);
End;





end.
