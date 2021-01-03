/// <summary>
/// TableExtension TKA SWEM Sales Shipment Line (ID 81006) extends Record Sales Shipment Line.
/// </summary>
tableextension 81006 "TKA SWEM Sales Shipment Line" extends "Sales Shipment Line"
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
