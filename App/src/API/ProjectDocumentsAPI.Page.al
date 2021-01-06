/// <summary>
/// Page TKA Project Documents API (ID 81015).
/// </summary>
page 81015 "TKA Project Documents API"
{
    Caption = 'projectDocumentsAPI', Locked = true;
    PageType = API;
    APIPublisher = 'keptyCZ';
    APIGroup = 'swProjectEMaster';
    APIVersion = 'v1.0';
    EntityName = 'projectDocument';
    EntitySetName = 'projectDocuments';

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = true;

    SourceTable = "TKA Project Document";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("code"; Rec."TKA Code") { }
            }
        }
    }

    /// <summary>
    /// sendProjectDocument.
    /// </summary>
    /// <param name="projectReportKey">Text[50].</param>
    /// <param name="sendToEmail">Text.</param>
    /// <returns>Return value of type Text.</returns>
    [ServiceEnabled]
    procedure sendProjectDocument(projectReportKey: Text[50]; sendToEmail: Text): Text
    var
    begin
        // TODO General function to send project document as email
    end;
}