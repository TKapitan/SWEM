/// <summary>
/// TableExtension TKA SWEM Sales Invoice Line (ID 81008) extends Record Sales Invoice Line.
/// </summary>
tableextension 81008 "TKA SWEM Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        field(81003; "TKA SWEM Service Order"; Boolean)
        {
            Caption = 'Service Order';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."TKA SWEM Service Order" where("No." = field("Document No.")));
        }
        field(81009; "TKA Project No."; Code[20])
        {
            Caption = 'Project No.';
            TableRelation = "TKA Project"."TKA No.";
            DataClassification = CustomerContent;
        }
        field(81010; "TKA Project Task No."; Code[20])
        {
            Caption = 'Project Task No.';
            TableRelation = "TKA Project Task"."TKA Task No." where("TKA Project No." = field("TKA Project No."));
            DataClassification = CustomerContent;
        }
    }
}
