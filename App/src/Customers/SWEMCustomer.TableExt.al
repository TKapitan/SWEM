/// <summary>
/// TableExtension TKA SWEM Customer (ID 81000) extends Record Customer.
/// </summary>
tableextension 81000 "TKA SWEM Customer" extends Customer
{
    fields
    {
        field(81000; "TKA SWEM Project API No."; Text[50])
        {
            Caption = 'Project API No.';
            DataClassification = OrganizationIdentifiableInformation;
        }
    }
}