/// <summary>
/// TableExtension TKA SWEM Resource (ID 81001) extends Record Resource.
/// </summary>
tableextension 81001 "TKA SWEM Resource" extends Resource
{
    fields
    {
        field(81001; "TKA SWEM Project Mandatory"; Boolean)
        {
            Caption = 'Project Mandatory';
            DataClassification = CustomerContent;
        }
        field(81002; "TKA SWEM E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateEmail();
            end;
        }
    }

    local procedure ValidateEmail()
    var
        MailManagement: Codeunit "Mail Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        "TKA OnBeforeValidateEmail"(Rec, IsHandled);
        if IsHandled then
            exit;

        if "TKA SWEM E-Mail" = '' then
            exit;
        MailManagement.CheckValidEmailAddress("TKA SWEM E-Mail");
    end;

    /// <summary>
    /// TKA OnBeforeValidateEmail. Integration Event that is called before the resource email is validated. Allow to skip default validation.
    /// </summary>
    /// <param name="Resource">Record Resource.</param>
    /// <param name="IsHandled">VAR Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure "TKA OnBeforeValidateEmail"(Resource: Record Resource; var IsHandled: Boolean)
    begin
    end;
}