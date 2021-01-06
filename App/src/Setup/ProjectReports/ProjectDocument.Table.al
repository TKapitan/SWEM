/// <summary>
/// Table TKA Project Document (ID 81004).
/// </summary>
table 81004 "TKA Project Document"
{
    Caption = 'Project Document';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "TKA Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(10; "TKA Project External ID"; Text[50])
        {
            Caption = 'Project External ID';
            DataClassification = CustomerContent;
        }
        field(50; "TKA Report Object No."; Integer)
        {
            Caption = 'Report Object No.';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
            DataClassification = SystemMetadata;
        }
        field(51; "TKA Report Attachment Name"; Text[100])
        {
            Caption = 'Report Attachment Name';
            DataClassification = CustomerContent;
        }
        field(100; "TKA Email Subject"; Text[100])
        {
            Caption = 'Email Subject';
            DataClassification = CustomerContent;
        }
        field(101; "TKA Email Body"; Text[2048])
        {
            Caption = 'Email Body';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "TKA Code")
        {
            Clustered = true;
        }
    }

}