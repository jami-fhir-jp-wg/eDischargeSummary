Profile:        JP_Bundle
Parent:			Bundle
Id:             JP-Bundle
Description:    "Derived Profile from JP-Core"
* ^url = "http://jpfhir.jp/fhir/Common/StructureDefinition/JP_Bundle"
* ^date = "2024-02-07"
* meta.lastUpdated 0.. MS

Profile: JP_Bundle_eDischargeSummary
Parent: Bundle
Id: JP-Bundle-eDischargeSummary
Description: "退院時サマリーのための文書 Bundleリソース"
* ^url = "http://jpfhir.jp/fhir/eDischargeSummary/StructureDefinition/JP_Bundle_eDischargeSummary"
* ^status = #active
* . ^short = "退院時サマリーのための文書 Bundleリソース"
* . ^definition = "退院時サマリーのための文書 Bundleリソース"
* meta.lastUpdated 1.. MS
* meta.profile 1.. MS
//* meta.profile = "http://jpfhir.jp/fhir/eDischargeSummary/StructureDefinition/JP_Bundle_eDischargeSummary"

* identifier 1.. MS
* identifier ^short = "この文書Bundleの固定識別番号。Bundle作成時にシステムが設定し、サーバ間で移動、コピーされても変更されないID。"
* identifier ^definition = "この文書Bundleの固定識別番号。identifierがグローバルに一意になるように生成される必要がある。"
* identifier.system 1.. MS
* identifier.system = "http://jpfhir.jp/fhir/core/IdSystem/documentInstance-identifier" (exactly)
* identifier.value 1.. MS

* type = #document (exactly)
* type ^definition = "このバンドルの目的コード。本プロファイルでは document 固定とする。\r\n（document | message | transaction | transaction_response | batch | batch_response | history | searchset | collection）"
* type MS
* timestamp 1.. MS
* timestamp ^short = "このバンドルリソースのインスタンスが作成された日時。"
* timestamp ^definition = "このリソースを生成した日時。時刻の精度はミリ秒とし、タイムゾーンを含めること。　例：\"2021-02-01T13:28:17.239+09:00\""

* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry contains
    composition 1..1 MS  // 文書構成情報
and patient 1..1 MS  //  患者情報
and practitioners 1.. MS
and organization 2.. MS // 文書作成機関1..1、文書管理責任機関1..1、入院前の所在施設0..*、退院後の所在施設0..*

and encounter 1..1 MS   // 入院詳細情報エントリ(退院時詳細情報、入院理由、入院時診断、退院時診断を含む)
and location 0..* MS    // 入院前の所在場所0..*、退院後の所在場所0..*、入院中の所在場所0..*
and condition 1..* MS   //入院期間中の診断情報エントリ（入院詳細情報エントリから参照される）1..*、入院時主訴情報エントリ0..*、現病歴情報エントリ0..*、既往歴0..*
and allergy 0..* MS //  アレルギー・不耐性反応情報エントリ
and familyHistory 0..* MS   // 入院時家族歴0..*
and observation 0..* MS // 入院時社会歴0..*、入院時身体所見0..*、退院時身体所見0..*、入院中検査結果0..*
and immunization 0..* MS    // 予防接種歴0..*
and procedure 0..* MS   // 入院中治療情報0..*

and medicationRequest 0..* MS   // 退院時処方0..*
and medicationBundle 0..* MS   // 退院時処方箋0..*
and documentReference 0..* MS   //入院中経過0..*、PDF情報エントリー0..*
and carePlan 0..* MS    //退院時方針0..*
and medicalDeviceUse 0..* MS   // 医療機器情報0..*
and medicalDevice 0..* MS
and imageStudy 0..* MS  // 入院中検査結果情報0..*
and diagReport 0..* MS  // 入院中検査結果情報0..*
and advancedDirective 0..* MS // 事前指示情報0..*

and researchSubject 0..* MS   // 臨床研究情報
and researchStudy 0..* MS   // 臨床研究参加情報
and relatedPerson 0..* MS   // 関係者情報                       

and binaryData 0..* MS  // その他の添付バイナリーデータ

* entry[composition] ^short = "documentタイプのBundleリソースの先頭entryはCompositionリソース。"
* entry[composition] ^definition = "compositionリソースのエントリー。"
* entry[composition].fullUrl 1.. MS
* entry[composition].fullUrl ^short = "埋め込まれているCompositionリソースを一意に識別するためのUUID"
* entry[composition].fullUrl ^definition = "埋め込まれているCompositionリソースを一意に識別するためのUUID。"
* entry[composition].resource 1.. MS
* entry[composition].resource only  JP_Composition_eDischargeSummary
* entry[composition].resource ^short = "Compositionリソースのインスタンス本体"
* entry[composition].resource ^definition = "Compositionリソースのインスタンス本体。"
* entry[composition].search ..0
* entry[composition].request ..0
* entry[composition].response ..0

* entry[patient] ^short = "Patientリソース"
* entry[patient] ^definition = "Patientリソースのエントリー。"
* entry[patient].fullUrl 1.. MS
* entry[patient].fullUrl ^short = "埋め込まれているPatientリソースを一意に識別するためのUUID"
* entry[patient].fullUrl ^definition = "埋め込まれているPatientリソースを一意に識別するためのUUID。"
* entry[patient].resource 1.. MS
* entry[patient].resource only JP_Patient_eCS  // 患者情報エントリ Composition.subject
* entry[patient].resource ^short = "Patientリソースのインスタンス本体"
* entry[patient].resource ^definition = "Patientリソースのインスタンス本体。"
* entry[patient].search ..0
* entry[patient].request ..0
* entry[patient].response ..0

* entry[practitioners] ^short = "正当な権限があって文書を作成した個人の情報"
* entry[practitioners] ^definition = "正当な権限があって文書を作成した個人を表すPractitionerリソースで記述する。\r\nauthorisedAuthorRole要素が参照するPractitionerRoleから参照される。"
* entry[practitioners].fullUrl 1.. MS
* entry[practitioners].fullUrl ^short = "埋め込まれているPractitionerリソースを一意に識別するためのUUID"
* entry[practitioners].fullUrl ^definition = "埋め込まれているPractitionerリソースを一意に識別するためのUUID。"
* entry[practitioners].resource 1.. MS
* entry[practitioners].resource only JP_Practitioner_eCS
* entry[practitioners].resource ^short = "Practitionerリソースのインスタンス本体"
* entry[practitioners].resource ^definition = "Practitionerリソースのインスタンス本体。"
* entry[practitioners].search ..0
* entry[practitioners].request ..0
* entry[practitioners].response ..0

* entry[organization].resource only JP_Organization_eCS
* entry[organization] ^short = "文書作成機関／文書管理機関"
* entry[organization] ^definition = "文書作成機関／文書管理機関"
* entry[organization].search ..0
* entry[organization].request ..0
* entry[organization].response ..0






































* entry[condition].resource only  JP_Condition_eCS
* entry[condition] ^short = "患者状態(入院時、退院時など）診断病名、主訴など。"
* entry[condition] ^definition = "必須。"患者状態(入院時、退院時など）診断病名、主訴などを記述する。1つにつき1つのConditionで記述されたものを参照する。"

* entry[allergy].resource only  JP_AllergyIntolerance_eCS
* entry[allergy] ^short = "アレルギー・不耐性反応情報を記述したAllergyIntoleranceリソースを参照"
* entry[allergy] ^definition = "アレルギー・不耐性反応情報を記述して参照する。"

* entry[familyHistory].resource only  JP_FamilyMemberHistory
* entry[familyHistory] ^short = "家族歴情報を記述したFamilyMemberHistoryリソースを参照"
* entry[familyHistory] ^definition = "家族歴情報情報を記述して参照する。"

* entry[observation].resource only  JP_Observation_Common_eCS
* entry[observation] ^short = "身体所見／感染症情報／社会歴・生活習慣情報／検査結果を記述したObservationリソースを参照"
* entry[observation] ^definition = "身体所見／感染症情報／社会歴・生活習慣情報／検査結果を記述して参照する。"

* entry[immunization].resource only  JP_Immunization_eCS
* entry[immunization] ^short = "予防接種歴情報を記述したImmunizationリソースを参照"
* entry[immunization] ^definition = "予防接種歴情報を記述して参照する。"

* entry[procedure].resource only  JP_Procedure_eCS
* entry[procedure] ^short = "手術処置/輸血歴情報/処置等を記述したProcedureリソースを参照"
* entry[procedure] ^definition = "手術処置/輸血歴情報/処置等を記述して参照する。"

* entry[medicationRequest].resource only  JP_MedicationRequest
* entry[medicationRequest] ^short = "処方情報を記述したMedicationRequestリソースを参照"
* entry[medicationRequest] ^definition = "処方情報を記述して参照する。"

* entry[documentReference].resource only  JP_DocumentReference_eCS
* entry[documentReference] ^short = "DocumentReferenceリソースを参照"
* entry[documentReference] ^definition = "臨床経過を記述して参照する。"

* entry[carePlan].resource only  JP_CarePlan_eCS
* entry[carePlan] ^short = "診療方針指示を記述したCarePlanリソースを参照"
* entry[carePlan] ^definition = "診療方針指示を記述して参照する。"

* entry[medicalDeviceUse].resource only  JP_DeviceUseStatement
* entry[medicalDeviceUse] ^short = "医療機器の使用状況を記述したDeviceUseStatementリソースを参照"
* entry[medicalDeviceUse] ^definition = "医療機器の使用状況を記述したDeviceUseStatementリソースを参照する。"

* entry[medicalDevice].resource only  JP_Device
* entry[medicalDevice] ^short = "医療機器情報を記述したDeviceリソースを参照"
* entry[medicalDevice] ^definition = "医療機器情報を記述したDeviceリソースを参照する。"

* entry[imageStudy].resource only  JP_ImagingStudy_Radiology
* entry[imageStudy] ^short = "画像検査情報を記述したImagingStudyリソースを参照"
* entry[imageStudy] ^definition = "画像検査医療機器情報を記述したImagingStudyリソースを参照する。"

* entry[diagReport].resource only  JP_DiagnosticReport_Common
* entry[diagReport] ^short = "診断レポート情報を記述したDiagnosticReportリソースを参照"
* entry[diagReport] ^definition = "診断レポート情報を記述したDiagnosticReportリソースを参照する。"


* entry[advancedDirective].resource only  JP_Consent
* entry[advancedDirective] ^short = "事前指示を記述したConcentリソースを参照"
* entry[advancedDirective] ^definition = "事前指示を記述して参照する。"

* entry[researchSubject].resource only  JP_ResearchSubject
* entry[researchSubject] ^short = "臨床研究参加情報者を記述したResearchSubject_リソースを参照"
* entry[researchSubject] ^definition = "臨床研究参加者情報を記述して参照する。"

* entry[researchStudy].resource only  JP_ResearchStudy
* entry[researchStudy] ^short = "臨床研究情報を記述したResearchStudyリソースを参照"
* entry[researchStudy] ^definition = "臨床研究情報を記述して参照する。"

* entry[relatedPerson].resource only  JP_RelatedPerson
* entry[relatedPerson] ^short = "親族情報を記述したRelatedPersonリソースを参照"
* entry[relatedPerson] ^definition = "親族情報を記述して参照する。"

* entry[binaryData].resource only  JP_Binary
* entry[binaryData] ^short = "各種備考参照情報を記述したBinaryリソースを参照"
* entry[binaryData] ^definition = "各種備考参照情報をBinaryリソースで記述して参照する。"

* entry[medicationBundle].resource only  JP_MedicationRequest
* entry[medicationBundle] ^short = "処方箋のBudle文書"
* entry[medicationBundle] ^definition = "処方箋のBudle文書を参照する。"

* entry[encounter].resource only JP_Encounter_eCS
* entry[encounter] ^short = "入院期間中や退院時の詳細情報のEncounterリソースを参照"
* entry[encounter] ^definition = "入院期間中や退院時の詳細情報のEncounterリソースを参照。"

* entry[location].resource only  JP_Location

