unit uDatabase;

interface

uses
  Data.DB,
  FireDAC.DApt,
  FireDAC.Phys,
  System.Classes,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client,
  FireDAC.Phys.SQLite;

type
  ///<summary>
  ///Class that is responsible for managing the connection to the database
  ///</summary>
  TDatabaseManager = Class(TObject)
  private
    ///<summary>
    ///Definition of singleton
    ///</summary>
    Class Var FInstance: TDatabaseManager; //Definition of singleton
  private
    ///<summary>
    ///Support counter to generate a unique identifier in the program
    ///</summary>
    FCount : Integer;
    ///<summary>
    ///Definition of TFDQuery to use it dynamically in the program and worry about releasing the resource only until the end of the application execution
    ///</summary>
    FQuery : TFDQuery;
    ///<summary>
    ///Definition of TFDConnection to use it dynamically in the program and worry about releasing the resource only until the end of the application execution
    ///</summary>
    FConnection : TFDConnection;
    ///<summary>
    ///Private constructor to avoid multiple instances
    ///</summary>
    constructor Create; //
  public
    ///<summary>
    ///Method that is responsible for releasing the TFDQuery and the database connection
    ///</summary>
    destructor Destroy; override;
    ///<summary>
    ///Private Function that is responsible for establishing the connection to the database
    ///</summary>
    Function Connect : Boolean;
    ///<summary>
    ///Method that is responsible for establishing the disconnection to the database
    ///</summary>
    procedure Disconnect;
    ///<summary>
    ///Function that is responsible for loading the existing tables in the database
    ///</summary>
    Function LoadTablenames: TStringList;
    ///<summary>
    ///Query control is created and exposed for flexibility in its use.
    ///</summary>
    property Query : TFDQuery Read FQuery write FQuery ;
    ///<summary>
    ///Database Connection Component
    ///</summary>
    property Connection: TFDConnection read FConnection write FConnection;
    ///<summary>
    ///Function that returns the singleton instance
    ///</summary>
    Class Function GetInstance : TDatabaseManager;
    ///<summary>
    ///Function defines the unique identification of a record, the table id
    ///</summary>
    Class Function GetId : String;
    ///<summary>
    ///defines the format in string so that the field management can be standardized in any database
    ///</summary>
    ///<summary>
    ///ADatetime : TDateTime, Datetime type parameter to be formatted
    ///</summary>
    class function GetDatetime(Const ADatetime : TDateTime): String; //

  end;

implementation

Uses
  System.SysUtils,
  FireDAC.Phys.Intf;

class function TDatabaseManager.GetId: String;
begin
  Try
    Inc(GetInstance.FCount);
  Except
    GetInstance.FCount := 1;
  End;
  Result := FormatDateTime('YYYY-MM-DD_HH:NN:SS.ZZZ', Now) + '_' + GetInstance.FCount.ToString;
end;

class function TDatabaseManager.GetDatetime(Const ADatetime : TDateTime): String;
begin
  Result := FormatDateTime('YYYY-MM-DD_HH:NN:SS.ZZZ', ADatetime);
end;

Class Function TDatabaseManager.GetInstance: TDatabaseManager;
Begin
  If FInstance = Nil Then
    FInstance := TDatabaseManager.Create; // Create the instance if it does not already exist
  Result := FInstance;
End;

constructor TDatabaseManager.Create;
begin
  inherited Create;
  FCount := 0;
  FConnection := TFDConnection.Create(nil);
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConnection;
end;

destructor TDatabaseManager.Destroy;
begin
  FQuery.Free;
  FConnection.Free;
  inherited;
end;

Function TDatabaseManager.LoadTablenames: TStringList;
begin
  //Loads the name of existing tables for the purposes of creating them
  FConnection.Connected := False;
  Result := TStringList.Create;
  Self.Connection.GetTableNames('', '', '', Result,  [osMy], [tkTable]);
  FConnection.Connected := True;
end;

Function TDatabaseManager.Connect : Boolean;
Var
  lDatabase : String;
begin
  Result := False;
  Try
    lDatabase := ChangeFileExt(GetModuleName(HInstance), '.DB'); //defines the database name according to the application name
    FConnection.DriverName := 'SQLite'; //
    FConnection.Params.Database := lDatabase;
    FConnection.Connected := True;
    Result := FConnection.Connected;
  Except
    On E: Exception Do
    Begin

    End;
  End;
end;

procedure TDatabaseManager.Disconnect;
begin
  if FConnection.Connected then
    FConnection.Connected := False;
end;


Initialization

Finalization
  TDatabaseManager.FInstance.Free; // Release the singleton instance when the application terminates

end.

