/// <summary>
/// TableExtension TKA SWEM Sales Line (ID 81006) extends Record Sales Line.
/// </summary>
tableextension 81004 "TKA SWEM Sales Line" extends "Sales Line"
{
    fields
    {
        field(81003; "TKA SWEM Service Order"; Boolean)
        {
            Caption = 'Service Order';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."TKA SWEM Service Order" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
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
        field(81011; "TKA Linked To Line No."; Integer)
        {
            Caption = 'Linked to Line No.';
            DataClassification = SystemMetadata;
        }
        field(81012; "TKA Time From"; Time)
        {
            Caption = 'Time From';
            DataClassification = CustomerContent;
        }
        field(81013; "TKA Time To"; Time)
        {
            Caption = 'Time To';
            DataClassification = CustomerContent;
        }
        field(81018; "TKA Service Batch Code"; Code[20])
        {
            Caption = 'Service Batch Code';
            TableRelation = "TKA Service Batch"."TKA Code";
            DataClassification = CustomerContent;
        }

    }
}
