unit Form_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, uTypes,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.Menus, uDatabase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrMain = class(TForm)
    TreeView1: TTreeView;
    PopupMenu1: TPopupMenu;
    Addfolder1: TMenuItem;
    Adddocument1: TMenuItem;
    Pages: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    BTNAddFolder: TSpeedButton;
    BTNDeleteFolder: TSpeedButton;
    BTNAddDocument: TSpeedButton;
    BTNDeleteDocument: TSpeedButton;
    Panel1: TPanel;
    SEARCH_01: TEdit;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Label2: TLabel;
    Deletefolder1: TMenuItem;
    Deletedocument1: TMenuItem;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    Label6: TLabel;
    Panel2: TPanel;
    Label7: TLabel;
    DELIMITER: TEdit;
    BTNEXPORT: TSpeedButton;
    ///<summary>
    ///  A new folder is added
    ///  Validates if it is a subfolder
    ///</summary>
    procedure BTNAddFolderClick(Sender: TObject);
    ///<summary>
    ///  A new document is added
    ///  Validates if it is a subfolder
    ///  Call the form to define the document type and document name
    ///</summary>
    procedure BTNAddDocumentClick(Sender: TObject);
    ///<summary>
    ///  To differentiate by color if it is a folder or document
    ///</summary>
    procedure TreeView1AdvancedCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
    ///<summary>
    ///  //Delete the document, depending on the node where it is located
    ///</summary>
    procedure BTNDeleteDocumentClick(Sender: TObject);
    ///<summary>
    ///  //Delete the folder, depending on the node where it is located
    ///</summary>
    procedure BTNDeleteFolderClick(Sender: TObject);
    ///<summary>
    ///  Loads the query statement, assigns the query to the datasource and executes the query
    ///</summary>
    procedure SEARCH_01KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    ///<summary>
    ///  Double-clicking on the grid causes it to be positioned on the node that relates to the record.
    ///</summary>
    procedure DBGrid1DblClick(Sender: TObject);
    ///<summary>
    ///  When you switch to the query tab you activate the first global search
    ///</summary>
    procedure PagesChange(Sender: TObject);
    ///<summary>
    ///  Action to generate the document report
    ///</summary>
    procedure TreeView1DblClick(Sender: TObject);
    procedure BTNEXPORTClick(Sender: TObject);
  private
    { Private declarations }
    ///<summary>
    ///  Database Connection Manager
    ///</summary>
    FCon : TDatabaseManager;
    ///<summary>
    ///  Root node to manage the Treeview
    ///</summary>
    FRootNode : TTreeNode;
    ///<summary>
    ///  Delimiter for export
    ///</summary>
    FDelimiter : String;
    ///<summary>
    ///  Function that is responsible for finding a specific node
    ///</summary>
    ///<summary>
    ///  ATree : TTreeView, Container to display the hierarchies of folders and documents
    ///</summary>
    ///<summary>
    ///  AID : String, Unique identifier of the folder and the document
    ///</summary>
    function FindNode(ATree : TTreeView; AID : String): TTreeNode;
    ///<summary>
    ///  Method that is responsible for carrying the information of the documento to the memo component
    ///</summary>
    ///<summary>
    ///  AID : String, Unique identifier of the folder
    ///</summary>
    Procedure ExportDocument(Const pID : String);
    ///<summary>
    ///  Method that is responsible for carrying the information of the folder to search for documents associated with it
    ///</summary>
    ///<summary>
    ///  AID : String, Unique identifier of the folder
    ///</summary>    ///
    Procedure ExportFolder(Const pID : String);
    ///<summary>
    ///  Method that is responsible for delete the folder selected from node
    ///</summary>
    ///<summary>
    ///  AParent : TTreeNode, Node selected to be deleted
    ///</summary>    ///
    Procedure DeleteFolder(AParent : TTreeNode);
    ///<summary>
    ///  Method that is responsible for loading the documents associated with the parent folder
    ///</summary>
    ///<summary>
    ///  AParent : TTreeNode, Node selected
    ///</summary>
    ///<summary>
    ///  AID : String, Unique identifier of the folder
    ///</summary>
    Procedure LoadDocument(AParent : TTreeNode; Const pID : String);
    ///<summary>
    ///  Method that is responsible for loading the folders
    ///</summary>
    ///<summary>
    ///  AParent : TTreeNode, Node selected
    ///</summary>
    ///<summary>
    ///  AID : String, Unique identifier of the folder
    ///</summary>
    Procedure LoadFolder(AParent : TTreeNode; Const pID : String);
    ///<summary>
    ///  AParent : TTreeNode, Node selected
    ///</summary>
    ///<summary>
    ///  AID : String, Unique identifier of the folder
    ///</summary>
    Procedure AddChilNode(AParent : TTreeNode; Const ASender : TObject);
  public
    { Public declarations }
    ///<summary>
    ///  Prepare enviroment and load data if exits
    ///</summary>
    procedure AfterConstruction; override;
    ///<summary>
    ///  Release the root node before the form is destroyed
    ///</summary>
    procedure BeforeDestruction; override;
  end;

var
  FrMain: TFrMain;

implementation
{$R *.dfm}

Uses
  uFolder,
  uQuery01,
  uDocument,
  Form_Option,
  uPDFDocument,
  uTable.Folder,
  Form_Document,
  uTextDocument,
  System.StrUtils,
  uTable.Document,
  uReportDocument,
  uArticleDocument,
  FireDAC.Comp.Client;

Const
  cRoot = 'Root';

{ TFrMain }

///<summary>
///  Function is implemented to avoid loading the same data twice
///</summary>
function TFrMain.FindNode(ATree : TTreeView; AID : String): TTreeNode;
var
  lI: integer;
  lID : String;
  Node: TTreeNode;
begin
  Result:=nil;
  For lI := 0 To ATree.Items.Count-1 do
  begin
   Node:= ATree.Items[lI];
   if Node.Data <> Nil then
   begin
     If (TObject(Node.Data) Is TFolder) Then
     Begin
       lID := (TObject(Node.Data) As TFolder).ID;
       If AID.Contains(lID) Then
         Exit(Node);
     End
     Else
        If (TObject(Node.Data) Is TDocument) And ((TObject(Node.Data) As TDocument).ID.Contains(AID)) Then
          Exit(Node)
   end;
  end;
end;

///<summary>
///  Loading document nodes
///</summary>
Procedure TFrMain.LoadDocument(AParent : TTreeNode; Const pID : String);
Var
  lQry : TFDQuery;
  lDocument : TDocument;
  lChildNode: TTreeNode;
Begin
  lQry := TFDQuery.Create(Nil);
  lQry.Connection := FCon.Connection;
  lQry.SQL.Add(' SELECT * FROM ' + TTable_Document.Name);
  lQry.SQL.Add(' WHERE TRIM(FOLDER_ID) = ' + pID.Trim.QuotedString);
  lQry.SQL.Add(' ORDER BY DOCUMENT_ID DESC ');
  lQry.Active := True;
  lQry.First;
  While Not lQry.Eof Do
  Begin
    lDocument := Nil;
    If lQry.FieldByName('DOCUMENT_TYPE').AsString.Contains(TDocument.cPdf) Then
    Begin
      lDocument := TPDFDocument.Create(lQry.FieldByName('DOCUMENT_NAME').AsString, '', 0, '', '', '', '');
      TPDFDocument(lDocument).Version := lQry.FieldByName('DOCUMENT_VERSION').AsString;
      TPDFDocument(lDocument).EncryptionStatus := lQry.FieldByName('DOCUMENT_ENCRYPTION').AsString;
    End
    Else If lQry.FieldByName('DOCUMENT_TYPE').AsString.Contains(TDocument.cText) Then
    Begin
      lDocument := TTextDocument.Create(lQry.FieldByName('DOCUMENT_NAME').AsString, '', 0, '', '');
    End
    Else If lQry.FieldByName('DOCUMENT_TYPE').AsString.Contains(TDocument.cReport) Then
    Begin
      lDocument := TReportDocument.Create(lQry.FieldByName('DOCUMENT_NAME').AsString, '', 0, '', '', '', '');
      TReportDocument(lDocument).Author := lQry.FieldByName('DOCUMENT_AUTHOR').AsString;
      TReportDocument(lDocument).Summary := lQry.FieldByName('DOCUMENT_SUMMARY').AsString;
    End
    Else If lQry.FieldByName('DOCUMENT_TYPE').AsString.Contains(TDocument.cArticle) Then
    Begin
      lDocument := TArticleDocument.Create(lQry.FieldByName('DOCUMENT_NAME').AsString, '', 0, '', '', '', '');
      TArticleDocument(lDocument).Author := lQry.FieldByName('DOCUMENT_AUTHOR').AsString;
      TArticleDocument(lDocument).PublicationDate := lQry.FieldByName('DOCUMENT_PUBLICATION').AsString;
    End;
    If lDocument <> Nil Then
    Begin
      lDocument.ID := lQry.FieldByName('DOCUMENT_ID').AsString;
      lDocument.Name := lQry.FieldByName('DOCUMENT_NAME').AsString;
      lDocument.Size := lQry.FieldByName('DOCUMENT_SIZE').AsInteger;
      lDocument.Tags := lQry.FieldByName('DOCUMENT_TAGS').AsString;
      lDocument.DocType := lQry.FieldByName('DOCUMENT_TYPE').AsString;
      lDocument.DateAdded := lQry.FieldByName('DOCUMENT_ADDED').AsString;
      lDocument.Description := lQry.FieldByName('DOCUMENT_DESCRIPTION').AsString;
      lDocument.DateModified := lQry.FieldByName('DOCUMENT_MODIFIED').AsString;
      lChildNode := TreeView1.Items.AddChild(AParent, lDocument.Name); //Add the document to treview
      lChildNode.Data := lDocument;
    End;
    lQry.Next;
  End;
  lQry.Active := False;
  FreeAndNil(lQry);
End;

///<summary>
///  Loading Folder nodes
///</summary>
Procedure TFrMain.LoadFolder(AParent : TTreeNode; Const pID : String);
Var
  lQry : TFDQuery;
  lFolder : TFolder;
  lChildNode: TTreeNode;
Begin
  lQry := TFDQuery.Create(Nil);
  lQry.Connection := FCon.Connection;
  lQry.SQL.Add(' SELECT * FROM ' + TTable_Folder.Name);
  If Not pID.Trim.IsEmpty Then
    lQry.SQL.Add(' WHERE TRIM(FOLDER_PARENT) = ' + pID.Trim.QuotedString);
  lQry.SQL.Add(' ORDER BY FOLDER_ID ');
  lQry.Active := True;
  lQry.First;
  While Not lQry.Eof Do
  Begin
    IF FindNode(TreeView1, lQry.FieldByName('FOLDER_ID').AsString) = Nil Then
    Begin
      lFolder := TFolder.Create(lQry.FieldByName('FOLDER_NAME').AsString);
      lFolder.ID := lQry.FieldByName('FOLDER_ID').AsString;
      lChildNode := TreeView1.Items.AddChild(AParent, lFolder.Name); //Add the folder to treview
      lChildNode.Data := lFolder;
      lChildNode.Expanded := True;
      LoadFolder(lChildNode, lQry.FieldByName('FOLDER_ID').AsString);
      LoadDocument(lChildNode, lQry.FieldByName('FOLDER_ID').AsString);
    End;
    lQry.Next;
  End;
  lQry.Active := False;
  FreeAndNil(lQry);
End;

procedure TFrMain.PagesChange(Sender: TObject);
var
  lKey: Word;
begin
  If Pages.ActivePageIndex = 1 Then
    SEARCH_01KeyUp(Sender, lKey, [ssShift]);
end;

procedure TFrMain.SEARCH_01KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FCon.Query.Active := False;
  FCon.Query.SQL.Clear;
  TQuery01.Document(FCon.Query.SQL, Trim(SEARCH_01.Text));
  DataSource1.DataSet := FCon.Query;
  FCon.Query.Active := True;
end;

procedure TFrMain.DBGrid1DblClick(Sender: TObject);
Var
  lN : TTreeNode;
begin
  If FCon.Query.Active And (FCon.Query.RecordCount > 0) Then
  Begin
    lN := Nil;
    If FCon.Query.FieldByName('TYPE').AsString.Contains('FOLDER') Then
      lN := FindNode(TreeView1, FCon.Query.FieldByName('FOLDER_ID').AsString)
    Else
      If FCon.Query.FieldByName('TYPE').AsString.Contains('DOCUMENT') Then
        lN := FindNode(TreeView1, FCon.Query.FieldByName('DOCUMENT_ID').AsString);
    If Assigned(lN) Then
    Begin
      lN.Expand(True);
      lN.Selected := True;
    End;
  End;
end;

///<summary>
///  Delete the folder, depending on the node where it is located
///</summary>
Procedure TFrMain.DeleteFolder(AParent : TTreeNode);
Var
  lQry : TFDQuery;
  lFolder : TFolder;
Begin
  If (AParent <> Nil) And  (AParent.Data <> Nil) And (TObject(AParent.Data) Is TFolder) Then  //Check if it is a node or a folder parent
  Begin
    lFolder := (TObject(AParent.Data) As TFolder);
    lQry := TFDQuery.Create(Nil);
    lQry.Connection := FCon.Connection;
    lQry.SQL.Add(' DELETE FROM ' + TTable_Folder.Name);
    lQry.SQL.Add(' WHERE TRIM(FOLDER_ID) = ' + lFolder.ID.Trim.QuotedString);
    lQry.ExecSQL;
    If lQry.RowsAffected > 0 Then
    Begin
      lFolder.Free;
      AParent.Free;
    End;
    lQry.Active := False;
    FreeAndNil(lQry);
  End;
End;

///<summary>
///  Add a new node , depending on the node where it is located
///</summary>
Procedure TFrMain.AddChilNode(AParent : TTreeNode; Const ASender : TObject);
Var
  lParent : TFolder;
  lChildNode: TTreeNode;
Begin
  lParent := Nil;
  lChildNode := Nil;
  If (AParent.Data <> Nil) And (TObject(AParent.Data) Is TFolder) Then  //Check if it is a node or a folder parent
    lParent := TObject(AParent.Data) As TFolder;
  If (ASender Is TFolder) Then
  Begin
    If TTable_Folder.SaveBD(lParent, (ASender As TFolder).ID, (ASender As TFolder).Name) Then //Save the folder to the database
      lChildNode := TreeView1.Items.AddChild(AParent, (ASender As TFolder).Name); //Add the folder to treview
  End
  Else
    If Assigned(lParent) And (ASender Is TDocument) Then //Validates if it is a document
    Begin
      lChildNode := TreeView1.Items.AddChild(AParent, (ASender As TDocument).Name);
    End;
  If lChildNode <> Nil Then
    lChildNode.Data := ASender;
End;

///<summary>
///  Prepare enviroment and load data if exits
///</summary>
procedure TFrMain.AfterConstruction;
begin
  inherited;
  Memo1.Lines.Clear;
  FCon := TDatabaseManager.GetInstance;
  FRootNode := TreeView1.Items.Add(Nil, cRoot); //Create the root node
  FRootNode.Expanded := True;
  LoadFolder(FRootNode, '');
  FRootNode.Expand(True);
end;


///<summary>
///  Release Root Node
///</summary>
procedure TFrMain.BeforeDestruction;
begin
  FreeAndNil(FRootNode);
  inherited;
end;

procedure TFrMain.BTNAddDocumentClick(Sender: TObject);
Var
  lName : String;
  lType : TType_Doc;
  lParent : TFolder;
  lDocument : TDocument;
begin
  //A new document is added
  If TreeView1.Selected <> Nil Then
  Begin
    //Validates if it is a subfolder
    If ((TreeView1.Selected.Data <> nil) and (TObject(TreeView1.Selected.Data) Is TFolder)) Then
    Begin
      lParent := TObject(TreeView1.Selected.Data) As TFolder;
      If TFrOption.Execute(lType, lName)  Then //Call the form to define the document type and document name
      Begin
        lDocument := Nil;
        Case lType Of
          TTD_Text    : lDocument := TTextDocument.Create(TDatabaseManager.GetId, lName, 0, '', '');
          TTD_Report  : lDocument := TReportDocument.Create(TDatabaseManager.GetId, lName, 0, '', '', '', '');
          TTD_Article : lDocument := TArticleDocument.Create(TDatabaseManager.GetId, lName, 0, '', '', '', '');
          TTD_PDF     : lDocument := TPDFDocument.Create(TDatabaseManager.GetId, lName, 0, '', '', '', '');
        End;

        If Assigned(lDocument) And TFrDocument.Execute(lParent.ID, lDocument) Then  //Call the form to fill out the information
        Begin
          AddChilNode(TreeView1.Selected, lDocument);
         End;
      End;
    End
    Else
    begin
      If (TreeView1.Selected.Data = nil) Then
        ShowMessage('The document must not be in the root folder')
      Else
        If (TObject(TreeView1.Selected.Data) Is TDocument) Then
          ShowMessage('You must choose a folder');
    end;
  End;
end;

procedure TFrMain.BTNAddFolderClick(Sender: TObject);
Var
  lName : String;
  lFolder : TFolder;
begin
  //A new folder is added
  If TreeView1.Selected <> Nil Then
  Begin
    //Validates if it is a folder or if it is a root folder to create a new subfolder
    If ((TreeView1.Selected.Data <> nil) and (TObject(TreeView1.Selected.Data) Is TFolder)) Or (TreeView1.Selected.Text.Contains(cRoot)) Then
    Begin
      If InputQuery('Input folder name', 'Name', lName) Then
      Begin
        lFolder := TFolder.Create(lName);
        AddChilNode(TreeView1.Selected, lFolder);
      End;
    End
    Else
    Begin
      ShowMessage('You must select a folder');
    End;
  End;
end;

procedure TFrMain.BTNDeleteDocumentClick(Sender: TObject);
begin

  If ((TreeView1.Selected.Data <> nil) and (TObject(TreeView1.Selected.Data) Is TDocument)) Then
  Begin
    If TTable_Document.Delete((TObject(TreeView1.Selected.Data) As TDocument).ID) Then
    Begin
      (TObject(TreeView1.Selected.Data) As TDocument).Free;
      TreeView1.Selected.Free;
    End;
  End;
end;

procedure TFrMain.BTNDeleteFolderClick(Sender: TObject);
begin
  DeleteFolder(TreeView1.Selected);
end;

procedure TFrMain.BTNEXPORTClick(Sender: TObject);
Var
  lSD : TSaveDialog;
begin
  If Memo1.Lines.Count <= -1 Then
  Begin
    ShowMessage('There must be at least one line in the visual report');
    Exit;
  End;
  lSD := TSaveDialog.Create(Nil);
  lSD.Filter := 'File text (*.txt)|*.txt|File csv (*.csv)|*.csv';
  If lSD.Execute Then
    Memo1.Lines.SaveToFile(lSD.FileName);
  FreeAndNil(lSD)
end;

procedure TFrMain.TreeView1AdvancedCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
begin
  //
  If ((Node.Data <> nil) and (TObject(Node.Data) Is TFolder)) Then
  Begin
     Sender.Canvas.Font.Color := clNavy;
  End
  Else
  Begin
    If ((Node.Data <> nil) and (TObject(Node.Data) Is TDocument)) Then
    Begin
      Sender.Canvas.Font.Color := clGreen;
    End;
  End;
  If Node.Selected Then //When the search is done and the node is found, it changes to red.
    Sender.Canvas.Font.Color := clRed;
end;

//Prints to memo, according to the id of the selected folder
Procedure TFrMain.ExportDocument(Const pID : String);
Var
  lQry : TFDQuery;
  lLine : String;
Begin
  lQry := TFDQuery.Create(Nil);
  lQry.Connection := FCon.Connection;
  lQry.SQL.Add(' SELECT * FROM ' + TTable_Document.Name);
  lQry.SQL.Add(' WHERE TRIM(FOLDER_ID) = ' + pID.Trim.QuotedString);
  lQry.SQL.Add(' ORDER BY DOCUMENT_ID DESC ');
  lQry.Active := True;
  lQry.First;
  While Not lQry.Eof Do
  Begin
    lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_TYPE').AsString;
    lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_NAME').AsString;
    If lQry.FieldByName('DOCUMENT_TYPE').AsString.Contains(TDocument.cPdf) Then
    Begin
      lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_VERSION').AsString;
      lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_ENCRYPTION').AsString;
    End
    Else If lQry.FieldByName('DOCUMENT_TYPE').AsString.Contains(TDocument.cText) Then
    Begin
    End
    Else If lQry.FieldByName('DOCUMENT_TYPE').AsString.Contains(TDocument.cReport) Then
    Begin
      lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_AUTHOR').AsString;
      lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_SUMMARY').AsString;
    End
    Else If lQry.FieldByName('DOCUMENT_TYPE').AsString.Contains(TDocument.cArticle) Then
    Begin
      lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_AUTHOR').AsString;
      lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_PUBLICATION').AsString;
    End;
    lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_ID').AsString;
    lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_NAME').AsString;
    lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_SIZE').AsInteger.ToString;
    lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_TAGS').AsString;
    lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_TYPE').AsString;
    lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_ADDED').AsString;
    lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_DESCRIPTION').AsString;
    lLine := lLine + IfThen(Not lLine.IsEmpty, FDelimiter) + lQry.FieldByName('DOCUMENT_MODIFIED').AsString;
    Memo1.Lines.Add(lLine);
    lQry.Next;
  End;
  lQry.Active := False;
  FreeAndNil(lQry);
End;


//Search documento, according to the id of the selected folder
Procedure TFrMain.ExportFolder(Const pID : String);
Var
  lQry : TFDQuery;
Begin
  ExportDocument(pID);
  lQry := TFDQuery.Create(Nil);
  lQry.Connection := FCon.Connection;
  lQry.SQL.Add(' SELECT * FROM ' + TTable_Folder.Name);
  If Not pID.Trim.IsEmpty Then
    lQry.SQL.Add(' WHERE TRIM(FOLDER_PARENT) = ' + pID.Trim.QuotedString);
  lQry.SQL.Add(' ORDER BY FOLDER_ID ');
  lQry.Active := True;
  lQry.First;
  While Not lQry.Eof Do
  Begin
    ExportFolder(lQry.FieldByName('FOLDER_ID').AsString);
    lQry.Next;
  End;
  lQry.Active := False;
  FreeAndNil(lQry);
End;

procedure TFrMain.TreeView1DblClick(Sender: TObject);
Var
  lFolder : TFolder;
begin
  If (TreeView1.Selected <> Nil) And ((TreeView1.Selected.Data <> nil) and (TObject(TreeView1.Selected.Data) Is TFolder)) Then
  Begin
    FDelimiter := IfThen(Trim(DELIMITER.Text).IsEmpty, ';', Trim(DELIMITER.Text));
    Memo1.Lines.Clear;
    lFolder := (TObject(TreeView1.Selected.Data) As TFolder);
    ExportFolder(lFolder.ID);
  End;
end;

end.
