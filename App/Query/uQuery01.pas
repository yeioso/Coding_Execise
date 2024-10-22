unit uQuery01;

interface
Uses
  System.Classes;

Type
   ///<summary>
  ///   Class that is responsible for generating the data query regarding the documents
  ///</summary>
  TQuery01 = Class(TObject)
    Private
    Public
      ///<summary>
      ///  Method that is responsible for loading the SQL statement for the query
      ///  of the documents taking into account the following conditions
      ///  allows querying based on common attributes like name, description,
      ///  and tags, as well as specific document attributes such as author and publication date
      ///</summary>
      ///<summary>
      ///  ASentence : TStrings is the container where the SQL statement is stored
      ///</summary>
      ///<summary>
      ///  AData : String, data to be evaluated in the SQL statement
      ///</summary>
      Class Procedure Document(Const ASentence : TStrings; Const AData : String);
  End;


implementation

Uses
  uDocument,
  System.SysUtils;

///<summary>
///  Method that is responsible for loading the SQL statement for the query
///  of the documents taking into account the following conditions
///  allows querying based on common attributes like name, description,
///  and tags, as well as specific document attributes such as author and publication date
///</summary>
Class Procedure TQuery01.Document(Const ASentence : TStrings; Const AData : String);
Begin
  ASentence.Clear;
  ASentence.Add('      SELECT ');
  ASentence.Add('             ' + QuotedStr('DOCUMENT') + ' AS TYPE, ');
  ASentence.Add('             FOLDER_ID, ');
  ASentence.Add('             DOCUMENT_ID, ');
  ASentence.Add('             DOCUMENT_NAME, ');
  ASentence.Add('             DOCUMENT_ADDED, ');
  ASentence.Add('             DOCUMENT_MODIFIED, ');
  ASentence.Add('             DOCUMENT_SIZE, ');
  ASentence.Add('             DOCUMENT_DESCRIPTION, ');
  ASentence.Add('             DOCUMENT_TAGS, ');
  ASentence.Add('             DOCUMENT_TYPE, ');
  ASentence.Add('             DOCUMENT_AUTHOR, ');
  ASentence.Add('             DOCUMENT_PUBLICATION, ');
  ASentence.Add('             DOCUMENT_VERSION, ');
  ASentence.Add('             DOCUMENT_ENCRYPTION, ');
  ASentence.Add('             DOCUMENT_SUMMARY ');
  ASentence.Add('             FROM T002DOCUMENT ');
  If Not AData.Trim.IsEmpty Then
  Begin
    ASentence.Add('             WHERE ');
    ASentence.Add('                 ( ');
    ASentence.Add('                     ( ');
    ASentence.Add('                       DOCUMENT_TYPE LIKE ' + QuotedStr('%' + TDocument.cReport.Trim + '%'));
    ASentence.Add('                       OR DOCUMENT_TYPE LIKE ' + QuotedStr('%' + TDocument.cArticle.Trim + '%'));
    ASentence.Add('                     ) ');
    ASentence.Add('                     AND  ');
    ASentence.Add('                     ( ');
    ASentence.Add('                       DOCUMENT_AUTHOR LIKE ' + QuotedStr('%' + AData.Trim + '%'));
    ASentence.Add('                       OR DOCUMENT_PUBLICATION LIKE ' + QuotedStr('%' + AData.Trim + '%'));
    ASentence.Add('                     ) ');
    ASentence.Add('                 ) ');
    ASentence.Add('             OR ');
    ASentence.Add('                 ( ');
    ASentence.Add('                     DOCUMENT_NAME LIKE ' + QuotedStr('%' + AData.Trim + '%'));
    ASentence.Add('                     OR DOCUMENT_ADDED LIKE ' + QuotedStr('%' + AData.Trim + '%'));
    ASentence.Add('                     OR DOCUMENT_MODIFIED LIKE ' + QuotedStr('%' + AData.Trim + '%'));
    ASentence.Add('                     OR DOCUMENT_DESCRIPTION LIKE ' + QuotedStr('%' + AData.Trim + '%'));
    ASentence.Add('                     OR DOCUMENT_TAGS LIKE ' + QuotedStr('%' + AData.Trim + '%'));
    ASentence.Add('                 ) ');
  End;
End;



end.
