unit uReportDocument;

interface

Uses
  uDocument,
  System.Classes;

Type
  ///<summary>
  ///   Class that defines the report document class of the base document base class
  ///</summary>
  TReportDocument = class(TDocument)
  private
    ///<summary>
    ///   Property that stores the author's information
    ///</summary>
    FAuthor: string;
    ///<summary>
    ///   Property that stores the summary's information
    ///</summary>
    FSummary: string;
  public
    ///<summary>
    ///  Method that is responsible for creating the instance of the class
    ///</summary>
    ///<summary>
    ///  AID : String, Unique identification of the document
    ///</summary>
    ///<summary>
    ///  AName : String, name of the document
    ///</summary>
    ///<summary>
    ///  ASize: Integer, size of the document
    ///</summary>
    ///<summary>
    ///  ADescription: String, description of the document
    ///</summary>
    ///<summary>
    ///  ATags: String, Tags associated with the document, are a fundamental part of the search
    ///</summary>
    ///<summary>
    ///   AAuthor: string, Author of the document
    ///</summary>
    ///<summary>
    ///   ASummary: string, Author of the document
    ///</summary>
    constructor Create(AID, AName: string; ASize: Integer; ADescription: string; ATags: string; AAuthor: string; ASummary: string);
    ///<summary>
    ///   Property that stores the author's information
    ///</summary>
    property Author: string read FAuthor write FAuthor; //Property that stores the author's information
    ///<summary>
    ///   Property that stores the summary's information
    ///</summary>
    property Summary: string read FSummary write FSummary; //Property that stores the summary's information
  end;


implementation

Uses
  System.SysUtils;

{ TReportDocument }

constructor TReportDocument.Create(AID, AName: string; ASize: Integer; ADescription: string; ATags: string; AAuthor: string; ASummary: string);//method that is responsible for creating the instance of the class
begin
  inherited Create(AID, AName, ASize, ADescription, ATags, cReport);
  FAuthor := AAuthor;
  FSummary := ASummary;
end;

end.

