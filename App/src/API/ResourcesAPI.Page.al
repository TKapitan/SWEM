/// <summary>
/// Page TKA Resources API (ID 81006).
/// </summary>
page 81006 "TKA Resources API"
{
    Caption = 'resourcesAPI', Locked = true;
    PageType = API;
    APIPublisher = 'keptyCZ';
    APIGroup = 'swProjectEMaster';
    APIVersion = 'v1.0';
    EntityName = 'resource';
    EntitySetName = 'resources';

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = true;

    SourceTable = Resource;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(no; Rec."No.") { }
                field(type; Rec."Type") { }
                field(name; Rec."Name") { }
                field(resourceGroupNo; Rec."Resource Group No.") { }
                field(email; Rec."TKA SWEM E-Mail") { }
                field(projectMandatory; Rec."TKA SWEM Project Mandatory") { }
            }
        }
    }

}
