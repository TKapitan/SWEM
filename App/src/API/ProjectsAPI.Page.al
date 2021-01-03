/// <summary>
/// Page TKA Projects API (ID 81004).
/// API page for listing Projects
/// </summary>
page 81004 "TKA Projects API"
{
    Caption = 'projectsAPI', Locked = true;
    PageType = API;
    APIPublisher = 'keptyCZ';
    APIGroup = 'swProjectEMaster';
    APIVersion = 'v1.0';
    EntityName = 'project';
    EntitySetName = 'projects';

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = true;

    SourceTable = "TKA Project";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(projectNo; Rec."TKA No.") { }
                field(customerProjectAPINo; Rec."TKA Customer Project API No.") { }
                field(description; Rec."TKA Description") { }
                field(quantityPlanned; Rec."TKA Quantity Planned") { }
                field(quantityRemToConsume; Rec."TKA Quantity Rem. To Consume") { }
                field(quantityConsumed; Rec."TKA Quantity Consumed") { }
                field(internalQuantityRemToConsume; Rec."TKA Int. Qty. Rem. To Consume") { }
                field(internalQuantityConsumed; Rec."TKA Internal Quantity Consumed") { }
                field(invoicingWorkTypeCode; Rec."TKA Invoicing Work Type Code") { }
                field(calcWorkTypeCode; Rec."TKA Calc. Work Type Code") { }
                field(allowAPICreateTasks; Rec."TKA Allow API Create Tasks") { }
            }
        }
    }
}