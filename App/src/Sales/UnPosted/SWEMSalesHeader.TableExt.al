/// <summary>
/// TableExtension TKA SWEM Sales Header (ID 81002) extends Record Sales Header.
/// </summary>
tableextension 81002 "TKA SWEM Sales Header" extends "Sales Header"
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
        field(81018; "TKA Service Batch Code Filter"; Code[20])
        {
            Caption = 'Service Batch Code';
            FieldClass = FlowFilter;
            TableRelation = "TKA Service Batch"."TKA Code";
        }
        field(81019; "TKA Service Priority"; Code[20])
        {
            Caption = 'Service Source Department';
            TableRelation = "TKA Service Field Value"."TKA Code" where("TKA Type" = const("TKA Service Priority"));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key("TKA SWEM 1"; "TKA SWEM Service Order") { }
    }

    var
        TKASWProjectEMasterSetup: Record "TKA SW Project E-Master Setup";
        FieldDoesNotExistsErr: Label 'Field with number %1 does not exists or does not have setup specified in %2.', Comment = '%1 - Number of the field, %2 - caption of the table';

    local procedure GetServiceFieldSetup(FieldNo: Integer; var FieldSetup: Enum "TKA Service API Field Valid.")
    begin
        FieldSetup := FieldSetup::"TKA Field Disabled";
        case FieldNo of
            // Add new option for adding getters of additional field 
            Rec.FieldNo("Salesperson Code"):
                FieldSetup := TKASWProjectEMasterSetup."TKA Service Valid. - Salesper.";
            Rec.FieldNo("TKA Service Status"):
                FieldSetup := TKASWProjectEMasterSetup."TKA Service Valid. - Status";
            Rec.FieldNo("TKA Service Priority"):
                FieldSetup := TKASWProjectEMasterSetup."TKA Service Valid. - Priority";
            Rec.FieldNo("TKA Service Type"):
                FieldSetup := TKASWProjectEMasterSetup."TKA Service Valid. - Type";
            Rec.FieldNo("TKA Service Source Department"):
                FieldSetup := TKASWProjectEMasterSetup."TKA Service Valid. - Depart.";
            else
                Error(FieldDoesNotExistsErr, FieldNo, Rec.TableCaption());
        end;
    end;

    internal procedure GetAPIValue(FieldNo: Integer): Text[50]
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        TKAServiceFieldValue: Record "TKA Service Field Value";

        ValRecordRef: RecordRef;
        ValFieldRef: FieldRef;
        IsHandled: Boolean;
        TempValue: Text[50];

        FieldSetup: Enum "TKA Service API Field Valid.";

    begin
        ValRecordRef.SetTable(Rec);
        if not ValRecordRef.FieldExist(FieldNo) then
            Error(FieldDoesNotExistsErr, FieldNo, Rec.TableCaption());

        ValFieldRef := ValRecordRef.Field(FieldNo);

        "TKA OnBeforeGetAPIValue"(ValRecordRef, ValFieldRef, TempValue, IsHandled);
        if IsHandled then
            exit(TempValue);
        Clear(TempValue);

        if Format(ValFieldRef.Value) = '' then
            exit('');

        TKASWProjectEMasterSetup.FindFirst();
        GetServiceFieldSetup(FieldNo, FieldSetup);
        case FieldSetup of
            FieldSetup::"TKA External ID/No/Key":
                case FieldNo of
                    // Add new option for validation of additional field 
                    Rec.FieldNo("Salesperson Code"):
                        begin
                            SalespersonPurchaser.Get(ValFieldRef.Value());
                            exit(SalespersonPurchaser."TKA SWEM Service External ID");
                        end;
                    Rec.FieldNo("TKA Service Status"):
                        begin
                            TKAServiceFieldValue.Get(TKAServiceFieldValue."TKA Type"::"TKA Service Status", ValFieldRef.Value());
                            exit(TKAServiceFieldValue."TKA Service External ID");
                        end;
                    Rec.FieldNo("TKA Service Priority"):
                        begin
                            TKAServiceFieldValue.Get(TKAServiceFieldValue."TKA Type"::"TKA Service Priority", ValFieldRef.Value());
                            exit(TKAServiceFieldValue."TKA Service External ID");
                        end;
                    Rec.FieldNo("TKA Service Type"):
                        begin
                            TKAServiceFieldValue.Get(TKAServiceFieldValue."TKA Type"::"TKA Service Type", ValFieldRef.Value());
                            exit(TKAServiceFieldValue."TKA Service External ID");
                        end;
                    Rec.FieldNo("TKA Service Source Department"):
                        begin
                            TKAServiceFieldValue.Get(TKAServiceFieldValue."TKA Type"::"TKA Service Source Department", ValFieldRef.Value());
                            exit(TKAServiceFieldValue."TKA Service External ID");
                        end;
                    else
                        Error(FieldDoesNotExistsErr, FieldNo, Rec.TableCaption());
                end;
            FieldSetup::"TKA Standard ID/No/Key":
                exit(ValFieldRef.Value());
            FieldSetup::"TKA Field Disabled":
                Rec.FieldError("Salesperson Code");
            else
                Error(FieldDoesNotExistsErr, FieldNo, Rec.TableCaption());
        end;
    end;

    internal procedure ValidateAPIValue(FieldNo: Integer; NewValue: Text[50])
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        TKAServiceFieldValue: Record "TKA Service Field Value";

        ValRecordRef: RecordRef;
        ValFieldRef: FieldRef;
        IsHandled: Boolean;

        FieldSetup: Enum "TKA Service API Field Valid.";
    begin
        ValRecordRef.SetTable(Rec);
        if not ValRecordRef.FieldExist(FieldNo) then
            Error(FieldDoesNotExistsErr, FieldNo, Rec.TableCaption());

        ValFieldRef := ValRecordRef.Field(FieldNo);

        "TKA OnBeforeValidateAPIValue"(ValRecordRef, ValFieldRef, NewValue, IsHandled);
        if IsHandled then
            exit;

        if NewValue = '' then begin
            ValFieldRef.Validate('');
            ValRecordRef.Modify(true);
            exit;
        end;

        TKASWProjectEMasterSetup.FindFirst();
        GetServiceFieldSetup(FieldNo, FieldSetup);
        case FieldSetup of
            FieldSetup::"TKA External ID/No/Key":
                begin
                    case FieldNo of
                        // Add new option for validation of additional field 
                        Rec.FieldNo("Salesperson Code"):
                            begin
                                SalespersonPurchaser.SetRange("TKA SWEM Service External ID", NewValue);
                                SalespersonPurchaser.FindFirst();
                                NewValue := SalespersonPurchaser.Code;
                            end;
                        Rec.FieldNo("TKA Service Status"):
                            begin
                                TKAServiceFieldValue.SetRange("TKA Type", TKAServiceFieldValue."TKA Type"::"TKA Service Status");
                                TKAServiceFieldValue.SetRange("TKA Service External ID", NewValue);
                                TKAServiceFieldValue.FindFirst();
                                NewValue := TKAServiceFieldValue."TKA Code";
                            end;
                        Rec.FieldNo("TKA Service Priority"):
                            begin
                                TKAServiceFieldValue.SetRange("TKA Type", TKAServiceFieldValue."TKA Type"::"TKA Service Priority");
                                TKAServiceFieldValue.SetRange("TKA Service External ID", NewValue);
                                TKAServiceFieldValue.FindFirst();
                                NewValue := TKAServiceFieldValue."TKA Code";
                            end;
                        Rec.FieldNo("TKA Service Type"):
                            begin
                                TKAServiceFieldValue.SetRange("TKA Type", TKAServiceFieldValue."TKA Type"::"TKA Service Type");
                                TKAServiceFieldValue.SetRange("TKA Service External ID", NewValue);
                                TKAServiceFieldValue.FindFirst();
                                NewValue := TKAServiceFieldValue."TKA Code";
                            end;
                        Rec.FieldNo("TKA Service Source Department"):
                            begin
                                TKAServiceFieldValue.SetRange("TKA Type", TKAServiceFieldValue."TKA Type"::"TKA Service Source Department");
                                TKAServiceFieldValue.SetRange("TKA Service External ID", NewValue);
                                TKAServiceFieldValue.FindFirst();
                                NewValue := TKAServiceFieldValue."TKA Code";
                            end;
                        else
                            Error(FieldDoesNotExistsErr, FieldNo, Rec.TableCaption());
                    end;
                    ValFieldRef.Validate(NewValue);
                    ValRecordRef.Modify(true);
                end;
            FieldSetup::"TKA Standard ID/No/Key":
                begin
                    ValFieldRef.Validate(NewValue);
                    ValRecordRef.Modify(true);
                end;
            FieldSetup::"TKA Field Disabled":
                Rec.FieldError("Salesperson Code");
            else
                Error(FieldDoesNotExistsErr, FieldNo, Rec.TableCaption());
        end;
    end;

    internal procedure CreateDistinctBatchCodesBuffer(var SalesHeader: Record "Sales Header"; var TempTKAServiceBatch: Record "TKA Service Batch" temporary);
    var
        SalesLine: Record "Sales Line";
        FunctionShouldBeCalledWithTemporaryRecErr: Label 'The function should be called with temporary record as a parameter. This is programming issue.';
    begin
        if not TempTKAServiceBatch.IsTemporary() then
            Error(FunctionShouldBeCalledWithTemporaryRecErr);
        TempTKAServiceBatch.DeleteAll();

        if SalesHeader.FindSet() then
            repeat
                SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetFilter(Quantity, '<>0');
                if SalesLine.FindSet() then
                    repeat
                        TempTKAServiceBatch.SetRange("TKA Code", SalesLine."TKA Service Batch Code");
                        if TempTKAServiceBatch.IsEmpty() then begin
                            TempTKAServiceBatch.Init();
                            TempTKAServiceBatch."TKA Code" := SalesLine."TKA Service Batch Code";
                            TempTKAServiceBatch.Insert(false);
                        end;
                    until SalesLine.Next() = 0;
            until SalesHeader.Next() = 0;
        Clear(TempTKAServiceBatch);
    end;

    /// <summary>
    /// TKA OnBeforeGetAPIValue.
    /// </summary>
    /// <param name="SalesHeaderRecordRef">RecordRef.</param>
    /// <param name="ToEditFieldRef">FieldRef.</param>
    /// <param name="ReturnValue">VAR Text[50].</param>
    /// <param name="IsHandled">VAR Boolean.</param>
    /// <returns>Return value of type Text[50].</returns>
    [IntegrationEvent(false, false)]
    procedure "TKA OnBeforeGetAPIValue"(SalesHeaderRecordRef: RecordRef; ToEditFieldRef: FieldRef; var ReturnValue: Text[50]; var IsHandled: Boolean)
    begin
    end;

    /// <summary>
    /// Integration Event "TKA OnBeforeValidateAPIValue".
    /// </summary>
    /// <param name="SalesHeaderRecordRef">VAR RecordRef.</param>
    /// <param name="ToEditFieldRef">VAR FieldRef.</param>
    /// <param name="NewValue">Text[50].</param>
    /// <param name="IsHandled">VAR Boolean.</param>
    [IntegrationEvent(false, false)]
    procedure "TKA OnBeforeValidateAPIValue"(var SalesHeaderRecordRef: RecordRef; var ToEditFieldRef: FieldRef; NewValue: Text[50]; var IsHandled: Boolean)
    begin
    end;
}