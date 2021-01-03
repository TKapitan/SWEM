/// <summary>
/// TableExtension TKA SWEM Salesperson/Purchaser (ID 81003) extends Record Salesperson/Purchaser.
/// </summary>
tableextension 81003 "TKA SWEM Salesperson/Purchaser" extends "Salesperson/Purchaser"
{
    fields
    {
        field(81006; "TKA SWEM Service External ID"; Text[50])
        {
            Caption = 'Service External ID';
            DataClassification = EndUserPseudonymousIdentifiers;
        }
    }
}