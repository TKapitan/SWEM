/// <summary>
/// Page TKA Project Tasks API (ID 81005).
/// </summary>
page 81005 "TKA Project Tasks API"
{
    Caption = 'projectTasksAPI', Locked = true;
    PageType = API;
    APIPublisher = 'keptyCZ';
    APIGroup = 'swProjectEMaster';
    APIVersion = 'v1.0';
    EntityName = 'projectTask';
    EntitySetName = 'projectTasks';

    InsertAllowed = true;
    ModifyAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = true;

    SourceTable = "TKA Project Task";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec."TKA Project No." + '#' + Rec."TKA Task No.")
                {
                    Editable = false;
                }
                field(projectNo; Rec."TKA Project No.") { }
                field(taskNo; Rec."TKA Task No.") { }
                field(description; Rec."TKA Description") { }
                field(calcWorkTypeCode; Rec."TKA Calc. Work Type Code") { }
                field(invoicingWorkTypeCode; Rec."TKA Invoicing Work Type Code") { }
                field(quantityPlanned; Rec."TKA Quantity Planned") { }
                field(quantityRemToConsume; Rec."TKA Quantity Rem. To Consume")
                {
                    Editable = false;
                }
                field(quantityConsumed; Rec."TKA Quantity Consumed")
                {
                    Editable = false;
                }
                field(internalQuantityRemToConsume; Rec."TKA Int. Qty. Rem. To Consume")
                {
                    Editable = false;
                }
                field(internalQuantityConsumed; Rec."TKA Internal Quantity Consumed")
                {
                    Editable = false;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        TKAProject: Record "TKA Project";
    begin
        Rec.TestField("TKA Project No.");
        Rec.TestField("TKA Task No.");
        TKAProject.Get(Rec."TKA Project No.");
        TKAProject.TestField("TKA Allow API Create Tasks");

        if Rec."TKA Calc. Work Type Code" = '' then
            Rec.Validate("TKA Calc. Work Type Code", TKAProject."TKA Calc. Work Type Code");
        if Rec."TKA Invoicing Work Type Code" = '' then
            Rec.Validate("TKA Invoicing Work Type Code", TKAProject."TKA Invoicing Work Type Code");
    end;
}