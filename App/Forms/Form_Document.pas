unit Form_Document;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Buttons, uDocument;

type
  ///<summary>
  ///   Class that is responsible for managing document information
  ///</summary>
  TFrDocument = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DOCUMENT_ID: TDBEdit;
    DOCUMENT_NAME: TDBEdit;
    DOCUMENT_ADDED: TDBEdit;
    DOCUMENT_MODIFIED: TDBEdit;
    DOCUMENT_SIZE: TDBEdit;
    DOCUMENT_DESCRIPTION: TDBMemo;
    Label13: TLabel;
    DOCUMENT_TAGS: TDBEdit;
    DOCUMENT_TYPE: TDBEdit;
    Label14: TLabel;
    DOCUMENT_AUTHOR: TDBEdit;
    lbAuthor: TLabel;
    lbPublication: TLabel;
    DOCUMENT_PUBLICATION: TDBEdit;
    lbVersion: TLabel;
    DOCUMENT_VERSION: TDBEdit;
    lbEncryption: TLabel;
    DOCUMENT_ENCRYPTION: TDBEdit;
    lbSummary: TLabel;
    DOCUMENT_SUMMARY: TDBEdit;
    BTNOK: TBitBtn;
    BTNCANCEL: TBitBtn;
    DataSource1: TDataSource;
  private
    { Private declarations }
    ///<summary>
    ///  Method that prepares the work environment for the creation of the record in the document table
    ///</summary>
    Procedure SetDocument(Const pFolderID : String; Const ADoc : TDocument);
    ///<summary>
    ///  Method that prepares the work environment for the creation of the record in the document table
    ///  Method that is responsible for displaying some fields according to
    ///  the document type criteria, for example the autos field will only be available
    ///  if the document type is report or article, the publication only if the document
    ///  type is article, the version and the state of the script only for the pdf document type,
    ///  the summary is only available if it is a report type.
    ///</summary>
    Procedure SetControls(Const ADoc : TDocument);
    ///<summary>
    ///  Method that assigns the date and time to the last modification date field, Before saving, update the modified date field
    ///</summary>
    Procedure OnBeforePost(ADataset : TDataSet);
  public
    { Public declarations }
    ///<summary>
    ///  Assign the beforepost event and the query data set
    ///</summary>
    procedure AfterConstruction; override;
    ///<summary>
    ///  Frees up resources related to document capture by closing the query, clearing the SQL property, and removing the before post event.
    ///</summary>
    procedure BeforeDestruction; override;
    ///<summary>
    ///  Function that triggers the execution of the interface for capturing information related to the document.
    ///</summary>
    ///<summary>
    ///  AFolderID : String, Unique identification of the document
    ///</summary>
    ///<summary>
    ///  ADoc : TDocument, Document class prepared to be updated based on data, but assigning the fields on the screen to be managed
    ///</summary>
    class function Execute(Const AFolderID : String;  Const ADoc : TDocument): Boolean;
  end;

var
  FrDocument: TFrDocument;

implementation
{$R *.dfm}

Uses
  uDatabase,
  uPDFDocument,
  uTextDocument,
  uTable.Document,
  uReportDocument,
  uArticleDocument;

Procedure TFrDocument.OnBeforePost(ADataset : TDataSet);
Begin
  //
  TDatabaseManager.GetInstance.Query.FieldByName('DOCUMENT_MODIFIED').AsString := TDatabaseManager.GetInstance.GetDatetime(Now);
End;

procedure TFrDocument.AfterConstruction;
begin
  inherited;
  //
  TDatabaseManager.GetInstance.Query.BeforePost := OnBeforePost;
  DataSource1.DataSet := TDatabaseManager.GetInstance.Query;
end;

procedure TFrDocument.BeforeDestruction;
begin
  //
  TDatabaseManager.GetInstance.Query.Active := False;
  TDatabaseManager.GetInstance.Query.SQL.Clear;
  TDatabaseManager.GetInstance.Query.BeforePost := Nil;
  inherited;
end;

Procedure TFrDocument.SetDocument(Const pFolderID : String; Const ADoc : TDocument);
Begin
  Try
    TDatabaseManager.GetInstance.Query.Active := False;
    TDatabaseManager.GetInstance.Query.SQL.Clear;
    TDatabaseManager.GetInstance.Query.SQL.Add(' SELECT * FROM ' + TTable_Document.Name);
    TDatabaseManager.GetInstance.Query.SQL.Add(' WHERE TRIM(FOLDER_ID) = ' + pFolderID.Trim.QuotedString);
    TDatabaseManager.GetInstance.Query.SQL.Add(' AND TRIM(DOCUMENT_ID) = ' + ADoc.ID.QuotedString);
    TDatabaseManager.GetInstance.Query.Active := True;
    If TDatabaseManager.GetInstance.Query.RecordCount <= 0 Then
    Begin
      //If the record does not exist, prepare a new record with the main data
      TDatabaseManager.GetInstance.Query.Append;
      TDatabaseManager.GetInstance.Query.FieldByName('FOLDER_ID').AsString := pFolderID;
      TDatabaseManager.GetInstance.Query.FieldByName('DOCUMENT_ID').AsString := ADoc.ID;
      TDatabaseManager.GetInstance.Query.FieldByName('DOCUMENT_NAME').AsString := ADoc.Name;
      TDatabaseManager.GetInstance.Query.FieldByName('DOCUMENT_TYPE').AsString := ADoc.DocType;
      TDatabaseManager.GetInstance.Query.FieldByName('DOCUMENT_TAGS').AsString := ADoc.DocType;
      TDatabaseManager.GetInstance.Query.FieldByName('DOCUMENT_ADDED').AsString := ADoc.DateAdded;
      TDatabaseManager.GetInstance.Query.FieldByName('DOCUMENT_MODIFIED').AsString := ADoc.DateModified;
    End
    Else
    Begin
      TDatabaseManager.GetInstance.Query.Edit;
    End;
  Except
    On E: Exception Do
      ShowMessage(E.Message);
  End;
End;

Procedure TFrDocument.SetControls(Const ADoc : TDocument);
Begin
  //If the record does not exist, prepare a new record with the main data
  lbAuthor.Visible             := (ADoc Is TReportDocument) Or (ADoc Is TArticleDocument);
  DOCUMENT_AUTHOR.Visible      := (ADoc Is TReportDocument) Or (ADoc Is TArticleDocument);
  lbPublication.Visible        := ADoc Is TArticleDocument;
  DOCUMENT_PUBLICATION.Visible := ADoc Is TArticleDocument;
  lbVersion.Visible            := ADoc Is TPDFDocument;
  DOCUMENT_VERSION.Visible     := ADoc Is TPDFDocument;
  lbEncryption.Visible         := ADoc Is TPDFDocument;
  DOCUMENT_ENCRYPTION.Visible  := ADoc Is TPDFDocument;
  lbSummary.Visible            := ADoc Is TReportDocument;
  DOCUMENT_SUMMARY.Visible     := ADoc Is TReportDocument;
End;

class function TFrDocument.Execute(Const AFolderID : String; Const ADoc : TDocument): Boolean;
Var
  lF : TFrDocument;
begin
  Result := False;
  lF := TFrDocument.Create(Application);
  lF.SetDocument(AFolderID, ADoc);
  lF.SetControls(ADoc);
  If TDatabaseManager.GetInstance.Query.Active Then
  Begin
    Result := lF.ShowModal = mrOk;
    If Result Then
      TDatabaseManager.GetInstance.Query.Post
    Else
      TDatabaseManager.GetInstance.Query.Cancel;
  End;
  FreeAndNil(lF);
end;

end.
