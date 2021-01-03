/// <summary>
/// Table TKA Service Field Value (ID 81005).
/// </summary>
table 81005 "TKA Service Field Value"
{
    Caption = 'Service Field Value';
    LookupPageId = "TKA Service Field Values";
    DrillDownPageId = "TKA Service Field Values";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "TKA Type"; Enum "TKA Service Field Value Type")
        {
            Caption = 'Type';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; "TKA Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(3; "TKA Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(10; "TKA Service External ID"; Text[50])
        {
            Caption = 'Service External ID';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "TKA Type", "TKA Code")
        {
            Clustered = true;
        }
    }
}