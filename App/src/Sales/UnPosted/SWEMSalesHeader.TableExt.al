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


        // field(; "TKA ART CU Serv. Order Batch Code"; Code[10])
        // {
        //     Caption = 'Číslo dávky servisní objednávky';
        //     Editable = false;
        //     TableRelation = "ART CU Service Order Batch"."ART CU Batch Code";
        //     DataClassification = SystemMetadata;
        // }
        //     field(50013; "TKA ART CU Order Time"; Time)
        //     {
        //         Caption = 'Čas zakázky';
        //         Editable = false;
        //         NotBlank = true;
        //         DataClassification = ToBeClassified;
        //         trigger OnValidate()
        //         var
        //             Text007Err: Label '%1 nesmí být větší než %2 v tabulce %3.';
        //         begin
        //             IF "ART CU Order Time" <> xRec."ART CU Order Time" THEN BEGIN
        //                 IF ("ART CU Order Time" > "ART CU Starting Time") AND
        //                    ("ART CU Starting Time" <> 0T) AND
        //                    ("Order Date" = "ART CU Starting Date")
        //                 THEN
        //                     Error(Text007Err, FIELDCAPTION("ART CU Order Time"), FIELDCAPTION("ART CU Starting Time"), TABLECAPTION());
        //                 IF "ART CU Starting Time" <> 0T THEN
        //                     VALIDATE("ART CU Starting Time");
        //             END;
        //         end;

        //     }
        //     field(50015; "TKA ART CU Service Contact Name"; Text[30])
        //     {
        //         Caption = 'Jméno kontaktu';
        //         Editable = false;
        //         DataClassification = ToBeClassified;

        //     }
        //     field(50016; "TKA ART CU Ship-to E-Mail"; Text[80])
        //     {
        //         Caption = 'E-mail příjemce';
        //         Editable = false;
        //         DataClassification = ToBeClassified;

        //     }
        //     field(50017; "TKA ART CU Response Date"; Date)
        //     {
        //         Caption = 'Datum odezvy';
        //         Editable = false;
        //         DataClassification = ToBeClassified;

        //     }
        //     field(50018; "TKA ART CU Response Time"; Time)
        //     {
        //         Caption = 'Čas odezvy';
        //         Editable = false;
        //         DataClassification = ToBeClassified;

        //     }
        //     field(50019; "TKA ART CU Starting Date"; Date)
        //     {
        //         Caption = 'Počáteční datum';
        //         Editable = false;
        //         DataClassification = ToBeClassified;
        //         trigger OnValidate()
        //         var
        //             Text026Err: Label '%1 nemůže být dříve než %2';
        //             Text007Err: Label '%1 nesmí být větší než %2';
        //         begin
        //             IF ("ART CU Starting Date" <> 0D) THEN BEGIN
        //                 IF ("ART CU Starting Date" < "Order Date") THEN
        //                     Error(Text026Err, FIELDCAPTION("ART CU Starting Date"), FIELDCAPTION("Order Date"));

        //                 IF ("ART CU Starting Date" > "ART CU Finishing Date") AND
        //                    ("ART CU Finishing Date" <> 0D)
        //                 THEN
        //                     Error(Text007Err, FIELDCAPTION("ART CU Starting Date"), FIELDCAPTION("ART CU Finishing Time"));

        //                 IF TIME() < "ART CU Order Time" THEN
        //                     VALIDATE("ART CU Starting Time", "ART CU Order Time")
        //                 ELSE
        //                     VALIDATE("ART CU Starting Time", TIME());
        //             END ELSE BEGIN
        //                 "ART CU Starting Time" := 0T;
        //                 "ART CU Finishing Date" := 0D;
        //                 "ART CU Finishing Time" := 0T;
        //             END;
        //         end;

        //     }
        //     field(50020; "TKA ART CU Starting Time"; Time)
        //     {
        //         Caption = 'Počáteční čas';
        //         Editable = false;
        //         DataClassification = ToBeClassified;
        //         trigger OnValidate()
        //         var
        //             Text007Err: Label '%1 nesmí být větší než %2';
        //             Text026Err: Label '%1 nemůže být dříve než %2';

        //         begin
        //             TESTFIELD("ART CU Starting Date");

        //             IF ("ART CU Starting Date" = "ART CU Finishing Date") AND ("ART CU Starting Time" > "ART CU Finishing Time") THEN
        //                 Error(Text007Err, FIELDCAPTION("ART CU Starting Time"), FIELDCAPTION("ART CU Finishing Time"));

        //             IF ("ART CU Starting Date" = "Order Date") AND ("ART CU Starting Time" < "ART CU Order Time") THEN
        //                 Error(Text026Err, FIELDCAPTION("ART CU Starting Time"), FIELDCAPTION("ART CU Order Time"));

        //             IF ("ART CU Starting Time" = 0T) AND (xRec."ART CU Starting Time" <> 0T) THEN BEGIN
        //                 "ART CU Finishing Time" := 0T;
        //                 "ART CU Finishing Date" := 0D;
        //             END;

        //             IF "ART CU Finishing Time" <> 0T THEN
        //                 VALIDATE("ART CU Finishing Time");
        //         end;
        //     }
        //     field(50021; "TKA ART CU Finishing Date"; Date)
        //     {
        //         Caption = 'Datum dokončení';
        //         Editable = false;
        //         DataClassification = ToBeClassified;
        //         trigger OnValidate()
        //         var
        //             Text026Err: Label '%1 nemůže být dříve než %2';
        //         begin
        //             IF ("ART CU Finishing Date" <> 0D) THEN BEGIN
        //                 IF ("ART CU Finishing Date" < "ART CU Starting Date") THEN
        //                     Error(Text026Err, FIELDCAPTION("ART CU Finishing Date"), FIELDCAPTION("ART CU Starting Date"));

        //                 IF "ART CU Finishing Date" < "Order Date" THEN
        //                     Error(Text026Err, FIELDCAPTION("ART CU Finishing Date"), FIELDCAPTION("Order Date"));

        //                 IF "ART CU Starting Date" = 0D THEN BEGIN
        //                     "ART CU Starting Date" := "ART CU Finishing Date";
        //                     "ART CU Starting Time" := TIME();
        //                 END;

        //                 IF "ART CU Finishing Date" <> xRec."ART CU Finishing Date" THEN BEGIN
        //                     IF TIME() < "ART CU Starting Time" THEN
        //                         "ART CU Finishing Time" := "ART CU Starting Time"
        //                     ELSE
        //                         "ART CU Finishing Time" := TIME();
        //                     VALIDATE("ART CU Finishing Time");
        //                 END;
        //             END ELSE
        //                 "ART CU Finishing Time" := 0T;
        //         end;
        //     }
        //     field(50022; "TKA ART CU Finishing Time"; Time)
        //     {
        //         Caption = 'Čas dokončení';
        //         Editable = false;
        //         DataClassification = ToBeClassified;
        //         trigger OnValidate()
        //         var
        //             Text026Err: Label '%1 nemůže být dříve než %2';
        //         begin
        //             TESTFIELD("ART CU Finishing Date");
        //             IF "ART CU Finishing Time" <> 0T THEN BEGIN
        //                 IF ("ART CU Starting Date" = "ART CU Finishing Date") AND ("ART CU Finishing Time" < "ART CU Starting Time") THEN
        //                     Error(Text026Err, FIELDCAPTION("ART CU Finishing Time"), FIELDCAPTION("ART CU Starting Time"));

        //                 IF ("ART CU Finishing Date" = "Order Date") AND ("ART CU Finishing Time" < "ART CU Order Time") THEN
        //                     Error(Text026Err, FIELDCAPTION("ART CU Finishing Time"), FIELDCAPTION("ART CU Order Time"));
        //             END;
        //         end;
        //     }
        //     field(50023; "TKA ART CU Qty. to Ship"; Decimal)
        //     {
        //         Caption = 'K dodání';
        //         CalcFormula = Sum("Sales Line"."Qty. to Ship" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
        //         FieldClass = FlowField;
        //         Editable = false;

        //     }
        //     field(50024; "TKA ART CU Quantity Shipped"; Decimal)
        //     {
        //         Caption = 'Dodané množství';
        //         FieldClass = FlowField;
        //         CalcFormula = Sum("Sales Line"."Quantity Shipped" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
        //         Editable = false;

        //     }
        //     field(50025; "TKA ART CU Quantity Invoiced"; Decimal)
        //     {
        //         Caption = 'Fakturované množství';
        //         FieldClass = FlowField;
        //         CalcFormula = Sum("Sales Line"."Quantity Invoiced" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
        //         Editable = false;

        //     }
        //     field(50042; "TKA ART CU Has Blanket Order Auto."; Boolean)
        //     {
        //         Caption = 'Obsahuje automatické řádky';
        //         FieldClass = FlowField;
        //         CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "ART CU Blanket Order Automatic" = CONST(true)));
        //         Editable = false;

        //     }
        //     field(50101; "TKA ART CU Last Currency Factor"; Decimal)
        //     {
        //         Caption = 'Poslední použitý faktor měny';
        //         Editable = false;
        //         DataClassification = ToBeClassified;
        //         trigger OnValidate()

        //         begin
        //             VALIDATE("ART CU Last Curre. Fact. Chng.", CREATEDATETIME(TODAY(), TIME()));
        //             VALIDATE("ART CU Last Curre. Fact. UsID", USERID());
        //         end;

        //     }
        //     field(50102; "TKA ART CU Last Curre. Fact. Chng."; DateTime)
        //     {
        //         Caption = 'Datum poslední změny faktoru měny';
        //         Editable = false;
        //         DataClassification = ToBeClassified;

        //     }
        //     // field(50103; "TKA ART CU Last Curre. Fact. UsID"; Code[50])
        //     // {
        //     //     Caption = 'Uživatel poslední změny faktoru měny';
        //     //     Editable = false;
        //     //     DataClassification = ToBeClassified;

        //     // }
        //     // field(50104; "TKA ART CU Last Curre. Exch. Rate"; Decimal)
        //     // {
        //     //     Caption = 'Poslední použitý kurz';
        //     //     DataClassification = ToBeClassified;

        //     // }
        //     // field(50105; "TKA ART CU Shipment No."; Integer)
        //     // {
        //     //     DataClassification = ToBeClassified;

        //     // }
        //     // field(50106; "TKA Shipment Line No."; Integer)
        //     // {
        //     //     DataClassification = ToBeClassified;
        //     // }
        //     // field(50170; "TKA ART CU Bla. Ord. Ten. Name"; Text[100])
        //     // {
        //     //     Caption = 'Tenant';
        //     //     DataClassification = ToBeClassified;

        //     // }
        //     field(50235; "TKA ART CU Serv. Ord. Requester ID"; BigInteger)
        //     {
        //         Caption = 'ID žadatele';
        //         DataClassification = ToBeClassified;

        //     }
        //     field(50236; "TKA ART CU Service Order Tic. Type"; Option)
        //     {
        //         Caption = 'Typ';
        //         DataClassification = ToBeClassified;
        //         OptionMembers = " ",Question,Support,Customization,Reclamation;
        //         OptionCaption = ' ,Dotaz,Podpora,Úprava,Reklamace';
        //     }
        //     field(50237; "TKA ART CU Serv. Ord. Tic. Prior."; Option)
        //     {
        //         Caption = 'Priorita';
        //         DataClassification = ToBeClassified;
        //         OptionMembers = " ",Low,Middle,High,Urgent;
        //         OptionCaption = ' ,Nízká,Střední,Vysoká,Urgentní';
        //     }
        //     field(50238; "TKA ART CU Serv. Ord. Tic. Depar."; Option)
        //     {
        //         Caption = 'Oddělení';
        //         DataClassification = ToBeClassified;
        //         OptionMembers = " ",Finance,Sales,Purchase,Warehouse,Service,Production,ProductDepartment,IT,Management,Other,Marketing;
        //         OptionCaption = ' ,Finance,Prodej,Nákup,Sklad,Servis,Výroba,Produktové oddělení,IT,Management,Ostatní,Marketing';

        //     }
        //     field(50239; "TKA ART CU Serv. Ord. Planned Qty."; Decimal)
        //     {
        //         Caption = 'Odhad';
        //         DataClassification = ToBeClassified;

        //     }
        //     field(50255; "TKA ART CU Quantity Changed"; Boolean)
        //     {
        //         Caption = 'Množství změněno';
        //         DataClassification = ToBeClassified;

        //     }
        //     field(90020; "TKA ART CU FreshDesk Order"; Boolean)
        //     {
        //         Caption = 'Objednávka FreshDesk';
        //         DataClassification = ToBeClassified;

        //     }
        //     field(90021; "TKA ART CU Linked to Line No."; Integer)
        //     {
        //         Caption = 'Spojeno s řádkem č.';
        //         DataClassification = ToBeClassified;
        //     }
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
                                TKAServiceFieldValue.SetRange("TKA Type", TKAServiceFieldValue."TKA Type"::"TKA Service Type");
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