/// <summary>
/// Table TKA SW Project E-Master Setup (ID 81003).
/// </summary>
table 81003 "TKA SW Project E-Master Setup"
{
    Caption = 'SW Project E-Master Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "TKA Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(20; "TKA Service Order Nos."; Code[20])
        {
            Caption = 'Service Order Nos.';
            TableRelation = "No. Series".Code;
            DataClassification = SystemMetadata;
        }
        field(21; "TKA Project Nos."; Code[20])
        {
            Caption = 'Project Nos.';
            TableRelation = "No. Series".Code;
            DataClassification = SystemMetadata;
        }
        field(100; "TKA Service Valid. - Salesper."; Enum "TKA Service API Field Valid.")
        {
            Caption = 'Service Field Validation - Salesperson';
            DataClassification = SystemMetadata;
        }
        field(101; "TKA Service Valid. - Status"; Enum "TKA Service API Field Valid.")
        {
            Caption = 'Service Field Validation - Status';
            DataClassification = SystemMetadata;
        }
        field(102; "TKA Service Valid. - Type"; Enum "TKA Service API Field Valid.")
        {
            Caption = 'Service Field Validation - Type';
            DataClassification = SystemMetadata;
        }
        field(103; "TKA Service Valid. - Depart."; Enum "TKA Service API Field Valid.")
        {
            Caption = 'Service Field Validation - Source Department';
            DataClassification = SystemMetadata;
        }
        field(150; "TKA Default Unbilled Work Type"; Code[10])
        {
            Caption = 'Default Unbilled Work Type';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "TKA Primary Key")
        {
            Clustered = true;
        }
    }
}