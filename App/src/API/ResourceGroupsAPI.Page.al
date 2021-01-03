/// <summary>
/// Page TKA Resource Groups API (ID 81007).
/// </summary>
page 81007 "TKA Resource Groups API"
{
    Caption = 'resourceGroupsAPI', Locked = true;
    PageType = API;
    APIPublisher = 'keptyCZ';
    APIGroup = 'swProjectEMaster';
    APIVersion = 'v1.0';
    EntityName = 'resourceGroup';
    EntitySetName = 'resourceGroups';

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = true;

    SourceTable = "Resource Group";
    SourceTableView = where("No. of Resources Assigned" = filter(<> 0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(no; Rec."No.") { }
                field(name; Rec."Name") { }
            }
        }
    }

}
