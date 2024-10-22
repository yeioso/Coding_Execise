unit uTextDocument;

interface

Uses
  uDocument,
  System.Classes;

Type
   ///<summary>
  ///   Class that defines the text document class of the base document base class
  ///</summary>
  TTextDocument = class(TDocument)
  private
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
    constructor Create(AID, AName: string; ASize: Integer; ADescription: string; ATags: string);
  end;


implementation

Uses
  System.SysUtils,
  FireDAC.Stan.Param;

{ TTextDocument }

constructor TTextDocument.Create(AID, AName: string; ASize: Integer; ADescription: string; ATags: string);
begin
  inherited Create(AID, AName, ASize, ADescription, ATags, cText);
end;


end.
