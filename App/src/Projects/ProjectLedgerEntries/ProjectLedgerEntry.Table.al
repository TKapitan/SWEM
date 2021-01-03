/// <summary>
/// Table TKA Project Ledger Entry (ID 81002).
/// Specifies all entries consumed or to be consumed from project tasks.
/// </summary>
table 81002 "TKA Project Ledger Entry"
{
    Caption = 'Project Ledger Entry';
    LookupPageId = "TKA Project Ledger Entries";
    DrillDownPageId = "TKA Project Ledger Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "TKA Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }
        field(2; "TKA Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(3; "TKA Resource No."; Code[20])
        {
            Caption = 'Resoure No.';
            TableRelation = Resource."No.";
            DataClassification = CustomerContent;
        }
        field(10; "TKA Project No."; Code[20])
        {
            Caption = 'Project No.';
            TableRelation = "TKA Project"."TKA No.";
            DataClassification = CustomerContent;
        }
        field(11; "TKA Project Task No."; Code[20])
        {
            Caption = 'Project Task No.';
            TableRelation = "TKA Project Task"."TKA Task No." where("TKA Project No." = field("TKA Project No."));
            DataClassification = CustomerContent;
        }
        field(20; "TKA Quantity To Consume"; Decimal)
        {
            Caption = 'Quantity To Consume';
            DataClassification = CustomerContent;
        }
        field(21; "TKA Quantity Rem. To Consume"; Decimal)
        {
            Caption = 'Quantity Remaining To Consume';
            DataClassification = CustomerContent;
        }
        field(22; "TKA Quantity Consumed"; Decimal)
        {
            Caption = 'Quantity Consumed';
            DataClassification = CustomerContent;
        }
        field(25; "TKA Internal Qty. To Consume"; Decimal)
        {
            Caption = 'Internal Quantity To Consume';
            DataClassification = CustomerContent;
        }
        field(26; "TKA Int. Qty. Rem. To Consume"; Decimal)
        {
            Caption = 'Internal Quantity Remaining To Consume';
            DataClassification = CustomerContent;
        }
        field(27; "TKA Internal Qty. Consumed"; Decimal)
        {
            Caption = 'Internal Quantity Consumed';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "TKA Entry No.")
        {
            Clustered = true;
        }
        key(Key1; "TKA Project No.", "TKA Project Task No.")
        {
            SumIndexFields = "TKA Quantity Rem. To Consume", "TKA Quantity Consumed", "TKA Int. Qty. Rem. To Consume", "TKA Internal Qty. Consumed";
            MaintainSiftIndex = true;
        }
    }

}