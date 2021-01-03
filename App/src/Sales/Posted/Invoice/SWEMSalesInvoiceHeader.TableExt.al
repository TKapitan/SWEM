/// <summary>
/// TableExtension TKA SWEM Sales Invoice Header (ID 81007) extends Record Sales Invoice Header.
/// </summary>
tableextension 81007 "TKA SWEM Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(81003; "TKA SWEM Service Order"; Boolean)
        {
            Caption = 'Service Order';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(81004; "TKA SWEM Service Ord. from API"; Boolean)
        {
            Caption = 'Service Order from API';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(81005; "TKA Service Order Description"; Text[100])
        {
            Caption = 'Service Order Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(81007; "TKA Service Status"; Code[20])
        {
            Caption = 'Service Status';
            TableRelation = "TKA Service Field Value"."TKA Code" where("TKA Type" = const("TKA Service Status"));
            DataClassification = CustomerContent;
        }
        field(81008; "TKA Service Type"; Code[20])
        {
            Caption = 'Service Type';
            TableRelation = "TKA Service Field Value"."TKA Code" where("TKA Type" = const("TKA Service Type"));
            DataClassification = CustomerContent;
        }
        field(81015; "TKA Service Source Department"; Code[20])
        {
            Caption = 'Service Source Department';
            TableRelation = "TKA Service Field Value"."TKA Code" where("TKA Type" = const("TKA Service Source Department"));
            DataClassification = CustomerContent;
        }
        field(81016; "TKA Service Planned Qty."; Decimal)
        {
            Caption = 'Service Planned Qty.';
            DataClassification = CustomerContent;
        }
    }
}