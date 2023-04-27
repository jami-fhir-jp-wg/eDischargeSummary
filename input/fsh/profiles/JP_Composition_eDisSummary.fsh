// 
Invariant: checkExist-CDASection-or-structuredSection
Description: "【セクション構成はCDAセクションと構造情報セクションのどちらか一方だけ存在している必要がある。】"
Severity: #error
Expression: "((section.code.coding.where(code = '200')).exists()) xor ((section.code.coding.where(code = '300')).exists())"

Profile: JP_Composition_eDischargeSummary
Parent: Composition
Id: JP-Composition-eDischargeSummary
Description:  "処方情報のリソース構成情報と文書日付に関するCompositionの派生プロファイル"
// * obeys checkValidCategoryTitle
// * obeys checkValidCategory
// * obeys checkValidSections
* obeys checkExist-CDASection-or-structuredSection
* ^url = "http://jpfhir.jp/fhir/eDischargeSummary/StructureDefinition/JP_Composition_eDischargeSummary"
* ^status = #active
* extension ^slicing.discriminator.type = #value
* extension ^slicing.discriminator.path = "url"
* extension ^slicing.rules = #open
* extension contains $composition-clinicaldocument-versionNumber named version 1..1
* extension[version] ^short = "文書バージョンを表す拡張"
* extension[version] ^min = 0
* extension[version] 1..1 MS
* extension[version].url 1..1 MS
* extension[version].value[x] ^short = "文書のバージョン番号を表す文字列。"
* extension[version].value[x] ^definition = "文書のバージョン番号を表す文字列。\r\n例 : 第１版は  \"1\" とする。"
* extension[version].value[x] 1..1 MS

* identifier 1.. MS
* identifier.system 1.. MS
* identifier.system = "http://jpfhir.jp/fhir/core/IdSystem/resourceInstance-identifier" (exactly)
* identifier.system ^short = "文書リソースIDの名前空間を表すURI。固定値。"
* identifier.system ^definition = "文書リソースIDの名前空間を表すURI。固定値。"
* identifier.value 1.. MS
* identifier.value ^short = "文書リソースID"
* identifier.value ^definition = "その医療機関が発行した退院時サマリーをその医療機関内において一意に識別するID（退院時サマリー番号）を設定する。\r\n施設固有のID設定方式を用いて構わないが、Identifier型のvalue要素に、保険医療機関番号（10桁）、発行年（4桁）、施設内において発行年内で一意となる番号（8桁）をハイフン(“-“：U+002D)で連結した文字列を指定する方法を本仕様では具体的として採用している。\r\n例：”1311234567-2020-00123456”
"
* status = #final (exactly)
* status ^short = "この文書のステータス。"
* status ^definition = "この文書のステータス。\r\n仕様上は、preliminary | final | amended | entered_in_error　のいずれかを設定できるが、医療機関から登録される段階では、\"final\" でなければならない。"

* type ^short = "文書区分コード"
* type ^definition = "documentタイプのうち文書種別"
* type MS
* type.coding 1..1 MS
* type from http://jpfhir.jp/fhir/Common/ValueSet/doc-typecodes (required)
* type.coding.system = "http://jpfhir.jp/fhir/Common/CodeSystem/doc-typecodes" (exactly)
* type.coding.system ^definition = "文書区分コードのコード体系を識別するURI。固定値"
* type.coding.system MS
* type.coding.version
* type.coding.code 1.. MS
* type.coding.code = #18842-5 (exactly)
* type.coding.code ^definition = "退院時サマリー\"18842-5\"を指定。固定値。"
* type.coding.display = "退院時サマリー" (exactly)
* type.coding.display ^short = "文書区分コードの表示名。"
* type.coding.display ^definition = "文書区分コードの表示名。"
* type.coding.display MS

* category 1..1 MS
* category ^short = "文書カテゴリーコード"
* category ^definition = "文書カテゴリーコード。　退院時サマリーではtype.coding.codeに記述される文書区分コードと同一。"
* category.coding 1..1 MS
* category from http://jpfhir.jp/fhir/Common/ValueSet/doc-typecodes (required)
* category.coding.system 1.. MS
* category.coding.system = "http://jpfhir.jp/fhir/Common/CodeSystem/doc-typecodes" (exactly)
* category.coding.system ^short = "文書カテゴリコードのコード体系"
* category.coding.system ^definition = "文書カテゴリコードのコード体系を識別するURI。固定値。"
* category.coding.code 1.. MS
* category.coding.code = #18842-5 (exactly)
* category.coding.code ^short = "文書カテゴリコード"
* category.coding.code ^definition = "文書カテゴリコード"
* category.coding.display ^short = "文書カテゴリコードの表示名"
* category.coding.display ^definition = "文書カテゴリ"
* category.coding.display MS

* subject 1.. MS
* subject ^short = "患者情報を表すPatientリソースへの参照。"
* subject ^definition = "患者情報を表すPatientリソースへの参照。"
* subject.reference 1..1 MS
* subject.reference ^short = "PatientリソースのfullUrl要素に指定されるUUIDを指定。"
* subject.reference ^definition = "Bundleリソースに記述されるPatientリソースのfullUrl要素に指定されるUUIDを指定。\r\n例：\"urn:uuid:11f0a9a6_a91d_3aef_fc4e_069995b89c4f\""

* encounter ^short = "この文書が作成された受診時状況情報を表すEncounterリソースへの参照"
* encounter ^definition = "この文書が作成された受診時状況情報を表すEncounterリソースへの参照"
* encounter 0..1 MS
* encounter.reference ^short = "EncounterリソースのfullUrl要素に指定されるUUIDを指定。"
* encounter.reference ^definition = "Bundleリソースに記述されるEncounterリソースのfullUrl要素に指定されるUUIDを指定。\r\n例：\"urn:uuid:12f0a9a6_a91d_8aef_d14e_069795b89c9f\""
* encounter.reference 1..1 MS

* date ^definition = "このリソースを作成または最後に編集した日時。ISO8601に準拠し、秒の精度まで記録し、タイムゾーンも付記する。\r\n午前0時を\"24:00\"と記録することはできないため\"00:00\"と記録すること。　\r\n例：\"2020_08_21T12:28:21+09:00\""
* date 1..1 MS

* author ^slicing.discriminator.type = #profile
* author ^slicing.discriminator.path = "resolve()"
* author ^slicing.rules = #open

* author ^short = "文書作成責任者と文書作成機関とへの参照。"
* author ^definition = "文書作成責任者を表すPractitionerリソースへの参照、および,文書作成機関か、または文書作成機関の診療科と文書作成機関を表すOrganizationリソースへの参照の2つのReferenceを繰り返す。"
* author contains
    authorPractitioner 1..1 MS 
and authorOrganization 1..1 MS
and authorDepartment 0..1 MS
* author[authorPractitioner] only  Reference(JP_Practitioner_eClinicalSummary)
* author[authorOrganization] only  Reference(JP_Organization_eClinicalSummary)
* author[authorDepartment] only  Reference(JP_Organization_eClinicalSummary_department)

* title 1..1 MS
* title = "退院時サマリー" (exactly)

* custodian 1..1 MS
* custodian ^short = "文書の作成・修正を行い、文書の管理責任を持つ医療機関（Organizationリソース）への参照"
* custodian ^definition = "文書作成機関と同一の組織の場合、custodian要素からは文書作成機関を表すOrganizationリソースへの参照となる。文書作成機関とは異なる組織である場合は、文書作成機関とは別のOrganizationリソースで表現し、custodian要素からはそのOrganizationリソースを参照する。"
* custodian only Reference(JP_Organization_eClinicalSummary)
* custodian.reference 1..1
* custodian.reference ^short = "custodianに対応するOrganizationリソースのfullUrl要素に指定されるUUIDを指定。"
* custodian.reference ^definition = "custodianに対応するOrganizationリソースのfullUrl要素に指定されるUUIDを指定。\r\n例：\"urn:uuid:179f9f7f_e546_04c2_6888_a9e0b24e5720\""

/* 退院時サマリーでは診療情報提供書と異なり、この文書が対象とした入院日と退院日を格納する。入院中に作成している場合には退院日は空欄となることもある　*/
* event 1..1 MS 
* event ^short = "退院時サマリーの発行イベントの情報"
* event ^definition = "退院時サマリーの発行イベントの情報　診療情報提供書と違いこの要素はなくてもよい"
* event.code ..0 
* event.period 1..  MS 
* event.period ^short = "退院時サマリーの対象となる入院期間"
* event.period ^definition = "退院時サマリーの対象となる入院期間。ISO8601に準拠yyyy-mm-dd形式で記述する。"
* event.period.start 1..  MS 
* event.period.start ^short = "退院時サマリーの対象となる入院期間の入院日"
* event.period.start ^definition = "退院時サマリーの対象となる入院期間の入院日。ISO8601に準拠yyyy-mm-dd形式で記述する。"
* event.period.end 1..  MS 
* event.period.end ^short = "退院時サマリーの対象となる入院期間の退院日"
* event.period.end ^definition = "退院時サマリーの対象となる入院期間の退院日。ISO8601に準拠yyyy-mm-dd形式で記述する。"

* section ^slicing.discriminator.type = #value
* section ^slicing.discriminator.path = "code.coding.code"
* section ^slicing.rules = #open
* section contains
    cdaSection   0..1 MS // CDA参照セクション    cdaSection
    and structuredSection     0..1 MS // 構造情報セクション   structuredSection
	and attachmentSection    0..*    MS  //  添付情報セクション	attachmentSection
    and pdfSection    0..*    MS  //  PDFセクション	pdfSection
// CDA参照セクションと構造情報セクションは、どちらか一方だけが出現する。制約条件の記述が必要。
//
//
* section[cdaSection] ^short = "CDA参照セクション"
* section[cdaSection] ^definition = "CDA参照セクション"
* section[cdaSection].title 1.. MS
* section[cdaSection].title = "CDA参照" (exactly)
* section[cdaSection].title ^short = "セクションタイトル"
* section[cdaSection].title ^definition = "セクションタイトル。固定値。"
* section[cdaSection].code 1.. MS
* section[cdaSection].code ^short = "セクション区分コード"
* section[cdaSection].code ^definition = "セクション区分コード"
* section[cdaSection].code.coding 1..1 MS
* section[cdaSection].code.coding.system 1.. MS
* section[cdaSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[cdaSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[cdaSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[cdaSection].code.coding.code 1.. MS
* section[cdaSection].code.coding.code = #200 (exactly)
* section[cdaSection].code.coding.code ^short = "セクション区分のコード値"
* section[cdaSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[cdaSection].code.coding.display = "CDA参照セクション" (exactly)
* section[cdaSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[cdaSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[cdaSection].code.coding.display MS
* section[cdaSection].code.coding.userSelected ..0
* section[cdaSection].code.text ..0
* section[cdaSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[cdaSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[cdaSection].text MS
* section[cdaSection].text.status MS
* section[cdaSection].text.status = #additional (exactly)
* section[cdaSection].text.status ^short = "セクションの内容作成状態コード"
* section[cdaSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[cdaSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[cdaSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[cdaSection].mode ..0
* section[cdaSection].orderedBy ..0
* section[cdaSection].entry 1..1
* section[cdaSection].entry only Reference(DocumentReference)
* section[cdaSection].entry ^short = "CDA規約文書ファイルへの参照"
* section[cdaSection].entry ^definition = "CDA規約文書ファイルへの参照"
* section[cdaSection].emptyReason ..1
* section[cdaSection].section ..0
//
//
//	and attachmentSection    0..*    MS  //  添付情報セクション	attachmentSection
//    and remarksCommunication    0..*    MS  //  備考・連絡情報セクション	remarksCommunicationSection
* section[attachmentSection] ^short = "添付情報セクション"
* section[attachmentSection] ^definition = "添付情報セクション"
* section[attachmentSection].title 1.. MS
* section[attachmentSection].title = "添付情報" (exactly)
* section[attachmentSection].title ^short = "セクションタイトル"
* section[attachmentSection].title ^definition = "セクションタイトル。固定値。"
* section[attachmentSection].code 1.. MS
* section[attachmentSection].code ^short = "セクション区分コード"
* section[attachmentSection].code ^definition = "セクション区分コード"
* section[attachmentSection].code.coding 1..1 MS
* section[attachmentSection].code.coding.system 1.. MS
* section[attachmentSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[attachmentSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[attachmentSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[attachmentSection].code.coding.code 1.. MS
* section[attachmentSection].code.coding.code = #210 (exactly)
* section[attachmentSection].code.coding.code ^short = "セクション区分のコード値"
* section[attachmentSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[attachmentSection].code.coding.display = "添付情報セクション" (exactly)
* section[attachmentSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[attachmentSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[attachmentSection].code.coding.display MS
* section[attachmentSection].code.coding.userSelected ..0
* section[attachmentSection].code.text ..0
* section[attachmentSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[attachmentSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[attachmentSection].text MS
* section[attachmentSection].text.status MS
* section[attachmentSection].text.status = #additional (exactly)
* section[attachmentSection].text.status ^short = "セクションの内容作成状態コード"
* section[attachmentSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[attachmentSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[attachmentSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[attachmentSection].mode ..0
* section[attachmentSection].orderedBy ..0
* section[attachmentSection].entry 1..*
* section[attachmentSection].entry only Reference(DocumentReference or Binary)  // あえてJP_を外している
* section[attachmentSection].entry ^short = "添付情報ファイルへの参照"
* section[attachmentSection].entry ^definition = "添付情報ファイルへの参照"
* section[attachmentSection].emptyReason ..1
* section[attachmentSection].section ..0
//
//
* section[structuredSection] ^short = "構造情報セクション"
* section[structuredSection] ^definition = "構造情報セクション"
* section[structuredSection].title 1.. MS
* section[structuredSection].title = "構造情報" (exactly)
* section[structuredSection].title ^short = "セクションタイトル"
* section[structuredSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].code 1.. MS
* section[structuredSection].code ^short = "セクション区分コード"
* section[structuredSection].code ^definition = "セクション区分コード"
* section[structuredSection].code.coding 1..1 MS
* section[structuredSection].code.coding.system 1.. MS
* section[structuredSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].code.coding.code 1.. MS
* section[structuredSection].code.coding.code = #300 (exactly)
* section[structuredSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].code.coding.display = "構造情報セクション" (exactly)
* section[structuredSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].code.coding.display MS
* section[structuredSection].code.coding.userSelected ..0
* section[structuredSection].code.text ..0
* section[structuredSection].text ..0 
* section[structuredSection].mode ..0
* section[structuredSection].orderedBy ..0
* section[structuredSection].emptyReason ..1  MS
//* section[structuredSection].emptyReason.coding    1..1    MS
//* section[structuredSection].emptyReason.coding.system = "http://terminology.hl7.org/CodeSystem/list-empty-reason"
//* section[structuredSection].emptyReason.coding.code = #unavilable (exactly)
//
* section[structuredSection].section ^slicing.discriminator.type = #value
* section[structuredSection].section ^slicing.discriminator.path = "code.coding.code"
* section[structuredSection].section ^slicing.rules = #open

* section[structuredSection].section   contains 
        detailsOnAdmissionSection	  1..1    MS  // 入院時詳細セクション
    and diagnosesOnAdmissionSection    1..1    MS  // 入院時診断セクション
    and allergyIntoleranceSection     0..1    MS  // アレルギー・不耐性反応セクション
    and chiefComplaintsSection    1..1    MS  // 主訴セクション
    and reasonForAdmissionSection      1..1    MS  // 入院理由セクション
    and presentIllnessSection     1..1    MS  // 現病歴セクション
    and pastIllnessSection    0..1    MS  // 既往歴セクション
    and medicationsOnAdmissionSection   0..1    MS  //  入院時服薬セクション
    and socialHistorySection      0..1    MS  //  入院時社会歴セクション
	and physicalStatusOnAdmissionSection   0..1    MS  //  入院時身体所見セクション
	and familiyHistorySection      0..1    MS  //  家族歴セクション
	and hospitalCourseSection     1..1    MS  //  入院中経過セクション
	and detailsOnDischargeSection     1..1    MS  //  退院時詳細セクション
	and diagnosesOnDischargeSection     1..1    MS  //  退院時診断セクション
	and medicationOnDischargeSection     1..1    MS  //  退院時投薬指示セクション 
	and instructionOnDischargeSection     1..1    MS  //  退院時方針指示セクション
	and physicalStatusOnDischargeSection    0..1    MS  //  退院時身体所見セクション
	and hospitalProcedureSection 0..1 MS // 入院中治療セクション
    and hospitalStudySection   0..1 MS // 入院中検査結果セクション
    and medicalDeviceSection      0..1    MS  //  医療機器セクション
    and immunizationSection      0..1    MS  // 予防接種歴セクション
	and advanceDirectiveSection   0..1    MS  //  事前指示セクション
	and researchParticipationSection      0..1    MS  //  臨床研究参加セクション
//
* section[structuredSection].section[detailsOnAdmissionSection] ^short = "入院時詳細セクション"
* section[structuredSection].section[detailsOnAdmissionSection] ^definition = "入院時詳細セクション"
* section[structuredSection].section[detailsOnAdmissionSection].title 1.. MS
* section[structuredSection].section[detailsOnAdmissionSection].title = "入院時詳細"
* section[structuredSection].section[detailsOnAdmissionSection].title ^short = "セクションタイトル"
* section[structuredSection].section[detailsOnAdmissionSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[detailsOnAdmissionSection].code 1.. MS
* section[structuredSection].section[detailsOnAdmissionSection].code ^short = "セクション区分コード"
* section[structuredSection].section[detailsOnAdmissionSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[detailsOnAdmissionSection].code.coding 1..1 MS
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.system 1.. MS
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.code 1.. MS
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.code = #322 (exactly)
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.display = "入院時詳細セクション" (exactly)
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.display MS
* section[structuredSection].section[detailsOnAdmissionSection].code.coding.userSelected ..0
* section[structuredSection].section[detailsOnAdmissionSection].code.text ..0
* section[structuredSection].section[detailsOnAdmissionSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[detailsOnAdmissionSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[detailsOnAdmissionSection].text MS
* section[structuredSection].section[detailsOnAdmissionSection].text.status MS
* section[structuredSection].section[detailsOnAdmissionSection].text.status = #additional (exactly)
* section[structuredSection].section[detailsOnAdmissionSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[detailsOnAdmissionSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[detailsOnAdmissionSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[detailsOnAdmissionSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[detailsOnAdmissionSection].mode ..0
* section[structuredSection].section[detailsOnAdmissionSection].orderedBy ..0
* section[structuredSection].section[detailsOnAdmissionSection].entry 1..1 MS
* section[structuredSection].section[detailsOnAdmissionSection].entry only Reference(JP_Encounter)
* section[structuredSection].section[detailsOnAdmissionSection].entry ^short = "Encounterリソースを参照"
* section[structuredSection].section[detailsOnAdmissionSection].entry ^definition = "Encounterリソースを参照"
* section[structuredSection].section[detailsOnAdmissionSection].emptyReason ..1 MS
* section[structuredSection].section[detailsOnAdmissionSection].section ..0
//
//
* section[structuredSection].section[diagnosesOnAdmissionSection] ^short = "入院時診断セクション"
* section[structuredSection].section[diagnosesOnAdmissionSection] ^definition = "入院時診断セクション"
* section[structuredSection].section[diagnosesOnAdmissionSection].title 1.. MS
* section[structuredSection].section[diagnosesOnAdmissionSection].title = "入院時診断"
* section[structuredSection].section[diagnosesOnAdmissionSection].title ^short = "セクションタイトル"
* section[structuredSection].section[diagnosesOnAdmissionSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[diagnosesOnAdmissionSection].code 1.. MS
* section[structuredSection].section[diagnosesOnAdmissionSection].code ^short = "セクション区分コード"
* section[structuredSection].section[diagnosesOnAdmissionSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding 1..1 MS
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.system 1.. MS
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.code 1.. MS
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.code = #342 (exactly)
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.display = "入院時診断セクション" (exactly)
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.display MS
* section[structuredSection].section[diagnosesOnAdmissionSection].code.coding.userSelected ..0
* section[structuredSection].section[diagnosesOnAdmissionSection].code.text ..0
* section[structuredSection].section[diagnosesOnAdmissionSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[diagnosesOnAdmissionSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[diagnosesOnAdmissionSection].text MS
* section[structuredSection].section[diagnosesOnAdmissionSection].text.status MS
* section[structuredSection].section[diagnosesOnAdmissionSection].text.status = #additional (exactly)
* section[structuredSection].section[diagnosesOnAdmissionSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[diagnosesOnAdmissionSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[diagnosesOnAdmissionSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[diagnosesOnAdmissionSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[diagnosesOnAdmissionSection].mode ..0
* section[structuredSection].section[diagnosesOnAdmissionSection].orderedBy ..0
* section[structuredSection].section[diagnosesOnAdmissionSection].entry 0..* MS
* section[structuredSection].section[diagnosesOnAdmissionSection].entry only Reference(JP_Condition)
* section[structuredSection].section[diagnosesOnAdmissionSection].entry ^short = "必須。（入院時の）傷病名・主訴を１個以上必ず記述する。"
* section[structuredSection].section[diagnosesOnAdmissionSection].entry ^definition = "（入院時の）傷病名"
* section[structuredSection].section[diagnosesOnAdmissionSection].emptyReason ..1 MS
* section[structuredSection].section[diagnosesOnAdmissionSection].section ..0
//
//
* section[structuredSection].section[allergyIntoleranceSection] ^short = "アレルギー・不耐性反応セクション"
* section[structuredSection].section[allergyIntoleranceSection] ^definition = "アレルギー・不耐性反応セクション"
* section[structuredSection].section[allergyIntoleranceSection].title 1.. MS
* section[structuredSection].section[allergyIntoleranceSection].title = "アレルギー・不耐性反応"
* section[structuredSection].section[allergyIntoleranceSection].title ^short = "セクションタイトル"
* section[structuredSection].section[allergyIntoleranceSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[allergyIntoleranceSection].code 1.. MS
* section[structuredSection].section[allergyIntoleranceSection].code ^short = "セクション区分コード"
* section[structuredSection].section[allergyIntoleranceSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[allergyIntoleranceSection].code.coding 1..1 MS
* section[structuredSection].section[allergyIntoleranceSection].code.coding.system 1.. MS
* section[structuredSection].section[allergyIntoleranceSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[allergyIntoleranceSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[allergyIntoleranceSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[allergyIntoleranceSection].code.coding.code 1.. MS
* section[structuredSection].section[allergyIntoleranceSection].code.coding.code = #510 (exactly)
* section[structuredSection].section[allergyIntoleranceSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[allergyIntoleranceSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[allergyIntoleranceSection].code.coding.display = "アレルギー・不耐性反応セクション" (exactly)
* section[structuredSection].section[allergyIntoleranceSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[allergyIntoleranceSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[allergyIntoleranceSection].code.coding.display MS
* section[structuredSection].section[allergyIntoleranceSection].code.coding.userSelected ..0
* section[structuredSection].section[allergyIntoleranceSection].code.text ..0
* section[structuredSection].section[allergyIntoleranceSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[allergyIntoleranceSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[allergyIntoleranceSection].text MS
* section[structuredSection].section[allergyIntoleranceSection].text.status MS
* section[structuredSection].section[allergyIntoleranceSection].text.status = #additional (exactly)
* section[structuredSection].section[allergyIntoleranceSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[allergyIntoleranceSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[allergyIntoleranceSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[allergyIntoleranceSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[allergyIntoleranceSection].mode ..0
* section[structuredSection].section[allergyIntoleranceSection].orderedBy ..0
* section[structuredSection].section[allergyIntoleranceSection].entry 0..* MS
* section[structuredSection].section[allergyIntoleranceSection].entry only Reference(JP_AllergyIntolerance)
* section[structuredSection].section[allergyIntoleranceSection].entry ^short = "アレルギー・不耐性反応情報を記述したAllergyIntoleranceリソースを参照"
* section[structuredSection].section[allergyIntoleranceSection].entry ^definition = """アレルギー・不耐性反応情報を記述して参照する。
                                                                1つのアレルギーにつき1つのAllergyIntoleranceリソースで記述されたものを参照する。
                                                                記述すべきアレルギー・不耐性反応情報が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                アレルギー・不耐性反応情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。                                                                
                                                                """
* section[structuredSection].section[allergyIntoleranceSection].emptyReason ..1
* section[structuredSection].section[allergyIntoleranceSection].section ..0
//
////
* section[structuredSection].section[chiefComplaintsSection] ^short = "主訴セクション"
* section[structuredSection].section[chiefComplaintsSection] ^definition = "主訴セクション"
* section[structuredSection].section[chiefComplaintsSection].title 1.. MS
* section[structuredSection].section[chiefComplaintsSection].title = "主訴"
* section[structuredSection].section[chiefComplaintsSection].title ^short = "セクションタイトル"
* section[structuredSection].section[chiefComplaintsSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[chiefComplaintsSection].code 1.. MS
* section[structuredSection].section[chiefComplaintsSection].code ^short = "セクション区分コード"
* section[structuredSection].section[chiefComplaintsSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[chiefComplaintsSection].code.coding 1..1 MS
* section[structuredSection].section[chiefComplaintsSection].code.coding.system 1.. MS
* section[structuredSection].section[chiefComplaintsSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[chiefComplaintsSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[chiefComplaintsSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[chiefComplaintsSection].code.coding.code 1.. MS
* section[structuredSection].section[chiefComplaintsSection].code.coding.code = #352 (exactly)
* section[structuredSection].section[chiefComplaintsSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[chiefComplaintsSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[chiefComplaintsSection].code.coding.display = "主訴セクション" (exactly)
* section[structuredSection].section[chiefComplaintsSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[chiefComplaintsSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[chiefComplaintsSection].code.coding.display MS
* section[structuredSection].section[chiefComplaintsSection].code.coding.userSelected ..0
* section[structuredSection].section[chiefComplaintsSection].code.text ..0
* section[structuredSection].section[chiefComplaintsSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[chiefComplaintsSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[chiefComplaintsSection].text MS
* section[structuredSection].section[chiefComplaintsSection].text.status MS
* section[structuredSection].section[chiefComplaintsSection].text.status = #additional (exactly)
* section[structuredSection].section[chiefComplaintsSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[chiefComplaintsSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[chiefComplaintsSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[chiefComplaintsSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[chiefComplaintsSection].mode ..0
* section[structuredSection].section[chiefComplaintsSection].orderedBy ..0
* section[structuredSection].section[chiefComplaintsSection].entry 0..* MS
* section[structuredSection].section[chiefComplaintsSection].entry only Reference(JP_Condition)
* section[structuredSection].section[chiefComplaintsSection].entry ^short = "主訴に対応するConditionリソースを参照"
* section[structuredSection].section[chiefComplaintsSection].entry ^definition = "主訴に対応するConditionリソースを参照"
* section[structuredSection].section[chiefComplaintsSection].emptyReason ..1
* section[structuredSection].section[chiefComplaintsSection].section ..0
//
* section[structuredSection].section[reasonForAdmissionSection] ^short = "入院理由セクション"
* section[structuredSection].section[reasonForAdmissionSection] ^definition = "入院理由セクション"
* section[structuredSection].section[reasonForAdmissionSection].title 1.. MS
* section[structuredSection].section[reasonForAdmissionSection].title = "入院理由"
* section[structuredSection].section[reasonForAdmissionSection].title ^short = "セクションタイトル"
* section[structuredSection].section[reasonForAdmissionSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[reasonForAdmissionSection].code 1.. MS
* section[structuredSection].section[reasonForAdmissionSection].code ^short = "セクション区分コード"
* section[structuredSection].section[reasonForAdmissionSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[reasonForAdmissionSection].code.coding 1..1 MS
* section[structuredSection].section[reasonForAdmissionSection].code.coding.system 1.. MS
* section[structuredSection].section[reasonForAdmissionSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[reasonForAdmissionSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[reasonForAdmissionSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[reasonForAdmissionSection].code.coding.code 1.. MS
* section[structuredSection].section[reasonForAdmissionSection].code.coding.code = #312 (exactly)
* section[structuredSection].section[reasonForAdmissionSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[reasonForAdmissionSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[reasonForAdmissionSection].code.coding.display = "入院理由セクションｓ" (exactly)
* section[structuredSection].section[reasonForAdmissionSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[reasonForAdmissionSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[reasonForAdmissionSection].code.coding.display MS
* section[structuredSection].section[reasonForAdmissionSection].code.coding.userSelected ..0
* section[structuredSection].section[reasonForAdmissionSection].code.text ..0
* section[structuredSection].section[reasonForAdmissionSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[reasonForAdmissionSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[reasonForAdmissionSection].text MS
* section[structuredSection].section[reasonForAdmissionSection].text.status MS
* section[structuredSection].section[reasonForAdmissionSection].text.status = #additional (exactly)
* section[structuredSection].section[reasonForAdmissionSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[reasonForAdmissionSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[reasonForAdmissionSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[reasonForAdmissionSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[reasonForAdmissionSection].mode ..0
* section[structuredSection].section[reasonForAdmissionSection].orderedBy ..0
* section[structuredSection].section[reasonForAdmissionSection].entry 0..1 MS
* section[structuredSection].section[reasonForAdmissionSection].entry only Reference(JP_Encounter)
* section[structuredSection].section[reasonForAdmissionSection].entry ^short = "入院理由をEncounter.reasonCodeに記述する"
* section[structuredSection].section[reasonForAdmissionSection].entry ^definition = "CodeableConceptであるEncounter.reasonCodeに病名あるいはtextで記述できる"
* section[structuredSection].section[reasonForAdmissionSection].emptyReason ..1
* section[structuredSection].section[reasonForAdmissionSection].section ..0
////
//
* section[structuredSection].section[presentIllnessSection] ^short = "現病歴セクション"
* section[structuredSection].section[presentIllnessSection] ^definition = "現病歴セクション"
* section[structuredSection].section[presentIllnessSection].title 1.. MS
* section[structuredSection].section[presentIllnessSection].title = "現病歴"
* section[structuredSection].section[presentIllnessSection].title ^short = "セクションタイトル"
* section[structuredSection].section[presentIllnessSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[presentIllnessSection].code 1.. MS
* section[structuredSection].section[presentIllnessSection].code ^short = "セクション区分コード"
* section[structuredSection].section[presentIllnessSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[presentIllnessSection].code.coding 1..1 MS
* section[structuredSection].section[presentIllnessSection].code.coding.system 1.. MS
* section[structuredSection].section[presentIllnessSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[presentIllnessSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[presentIllnessSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[presentIllnessSection].code.coding.code 1.. MS
* section[structuredSection].section[presentIllnessSection].code.coding.code = #362 (exactly)
* section[structuredSection].section[presentIllnessSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[presentIllnessSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[presentIllnessSection].code.coding.display = "現病歴セクション" (exactly)
* section[structuredSection].section[presentIllnessSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[presentIllnessSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[presentIllnessSection].code.coding.display MS
* section[structuredSection].section[presentIllnessSection].code.coding.userSelected ..0
* section[structuredSection].section[presentIllnessSection].code.text ..0
* section[structuredSection].section[presentIllnessSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[presentIllnessSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[presentIllnessSection].text MS
* section[structuredSection].section[presentIllnessSection].text.status MS
* section[structuredSection].section[presentIllnessSection].text.status = #additional (exactly)
* section[structuredSection].section[presentIllnessSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[presentIllnessSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[presentIllnessSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[presentIllnessSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[presentIllnessSection].mode ..0
* section[structuredSection].section[presentIllnessSection].orderedBy ..0
* section[structuredSection].section[presentIllnessSection].entry 0..* MS
* section[structuredSection].section[presentIllnessSection].entry only Reference(JP_Condition)
* section[structuredSection].section[presentIllnessSection].entry ^short = "必須。現病歴として記述すべき疾患に関する現在にいたる経過歴を１個以上必ず記述したConditionリソースを参照する。"
* section[structuredSection].section[presentIllnessSection].entry ^definition = """フリーテキストでしか記述できない場合には、それをCondition.code.text 
                                                                            およびCodition.noteに記述したConditionリソースを参照する。
                                                                            疾患ごとに分けて現病歴を記述できる場合には、それぞれをひとつのConditionリソースで記述して参照する。
                                                                            """
* section[structuredSection].section[presentIllnessSection].emptyReason ..1
* section[structuredSection].section[presentIllnessSection].section ..0
////
* section[structuredSection].section[pastIllnessSection] ^short = "既往歴セクション"
* section[structuredSection].section[pastIllnessSection] ^definition = "既往歴セクション"
* section[structuredSection].section[pastIllnessSection].title 1.. MS
* section[structuredSection].section[pastIllnessSection].title = "既往歴"
* section[structuredSection].section[pastIllnessSection].title ^short = "セクションタイトル"
* section[structuredSection].section[pastIllnessSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[pastIllnessSection].code 1.. MS
* section[structuredSection].section[pastIllnessSection].code ^short = "セクション区分コード"
* section[structuredSection].section[pastIllnessSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[pastIllnessSection].code.coding 1..1 MS
* section[structuredSection].section[pastIllnessSection].code.coding.system 1.. MS
* section[structuredSection].section[pastIllnessSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[pastIllnessSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[pastIllnessSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[pastIllnessSection].code.coding.code 1.. MS
* section[structuredSection].section[pastIllnessSection].code.coding.code = #372 (exactly)
* section[structuredSection].section[pastIllnessSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[pastIllnessSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[pastIllnessSection].code.coding.display = "既往歴セクション" (exactly)
* section[structuredSection].section[pastIllnessSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[pastIllnessSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[pastIllnessSection].code.coding.display MS
* section[structuredSection].section[pastIllnessSection].code.coding.userSelected ..0
* section[structuredSection].section[pastIllnessSection].code.text ..0
* section[structuredSection].section[pastIllnessSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[pastIllnessSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[pastIllnessSection].text MS
* section[structuredSection].section[pastIllnessSection].text.status MS
* section[structuredSection].section[pastIllnessSection].text.status = #additional (exactly)
* section[structuredSection].section[pastIllnessSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[pastIllnessSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[pastIllnessSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[pastIllnessSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[pastIllnessSection].mode ..0
* section[structuredSection].section[pastIllnessSection].orderedBy ..0
* section[structuredSection].section[pastIllnessSection].entry 0..* MS
* section[structuredSection].section[pastIllnessSection].entry only Reference(JP_Condition)
* section[structuredSection].section[pastIllnessSection].entry ^short = "既往歴をConditionリソースに記述して参照する。"
* section[structuredSection].section[pastIllnessSection].entry ^definition = """既往歴をConditionリソースに記述して参照する。
                                                                1つの既往疾患につき1つのConditionリソースで記述されたものを参照する。
                                                                記述すべき既往疾患が存在しないことを明示的に記述する（「既往特になし」など）場合にはentry要素は出現せず、emptyReasonにnilknownを記述する。
                                                                既往疾患情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                """
* section[structuredSection].section[pastIllnessSection].emptyReason ..1
* section[structuredSection].section[pastIllnessSection].section ..0
////

* section[structuredSection].section[medicationsOnAdmissionSection] ^short = "入院時服薬セクション"
* section[structuredSection].section[medicationsOnAdmissionSection] ^definition = "入院時服薬セクション"
* section[structuredSection].section[medicationsOnAdmissionSection].title 1.. MS
* section[structuredSection].section[medicationsOnAdmissionSection].title = "入院時服薬"
* section[structuredSection].section[medicationsOnAdmissionSection].title ^short = "セクションタイトル"
* section[structuredSection].section[medicationsOnAdmissionSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[medicationsOnAdmissionSection].code 1.. MS
* section[structuredSection].section[medicationsOnAdmissionSection].code ^short = "セクション区分コード"
* section[structuredSection].section[medicationsOnAdmissionSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding 1..1 MS
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.system 1.. MS
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.code 1.. MS
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.code = #432 (exactly)
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.display = "入院時服薬セクション" (exactly)
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.display MS
* section[structuredSection].section[medicationsOnAdmissionSection].code.coding.userSelected ..0
* section[structuredSection].section[medicationsOnAdmissionSection].code.text ..0
* section[structuredSection].section[medicationsOnAdmissionSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[medicationsOnAdmissionSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[medicationsOnAdmissionSection].text MS
* section[structuredSection].section[medicationsOnAdmissionSection].text.status MS
* section[structuredSection].section[medicationsOnAdmissionSection].text.status = #additional (exactly)
* section[structuredSection].section[medicationsOnAdmissionSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[medicationsOnAdmissionSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[medicationsOnAdmissionSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[medicationsOnAdmissionSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[medicationsOnAdmissionSection].mode ..0
* section[structuredSection].section[medicationsOnAdmissionSection].orderedBy ..0
* section[structuredSection].section[medicationsOnAdmissionSection].entry 0..* MS
* section[structuredSection].section[medicationsOnAdmissionSection].entry only Reference(JP_MedicationStatement)
* section[structuredSection].section[medicationsOnAdmissionSection].entry ^short = "投薬情報を記述したMedicationStatementを参照"
* section[structuredSection].section[medicationsOnAdmissionSection].entry ^definition = """入院時の服薬情報（正確には入院直前までの服薬情報）は、1医薬品ごとに1つのMedicationStatementリソースを使用して記述する。
    MedicationStatementでは、1医薬品ごとに用法を記述することができ、
    それが必要な場合で情報が入手できる場合には、MedicationStatement.dosage要素に記述する"""
* section[structuredSection].section[medicationsOnAdmissionSection].emptyReason ..1
* section[structuredSection].section[medicationsOnAdmissionSection].section ..0
////
////
* section[structuredSection].section[socialHistorySection] ^short = 社会歴・生活習慣セクション"
* section[structuredSection].section[socialHistorySection] ^definition = "社会歴・生活習慣セクション"
* section[structuredSection].section[socialHistorySection].title 1.. MS
* section[structuredSection].section[socialHistorySection].title = "社会歴・生活習慣"
* section[structuredSection].section[socialHistorySection].title ^short = "セクションタイトル"
* section[structuredSection].section[socialHistorySection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[socialHistorySection].code 1.. MS
* section[structuredSection].section[socialHistorySection].code ^short = "セクション区分コード"
* section[structuredSection].section[socialHistorySection].code ^definition = "セクション区分コード"
* section[structuredSection].section[socialHistorySection].code.coding 1..1 MS
* section[structuredSection].section[socialHistorySection].code.coding.system 1.. MS
* section[structuredSection].section[socialHistorySection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[socialHistorySection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[socialHistorySection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[socialHistorySection].code.coding.code 1.. MS
* section[structuredSection].section[socialHistorySection].code.coding.code = #642 (exactly)
* section[structuredSection].section[socialHistorySection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[socialHistorySection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[socialHistorySection].code.coding.display = "社会歴・生活習慣セクション" (exactly)
* section[structuredSection].section[socialHistorySection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[socialHistorySection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[socialHistorySection].code.coding.display MS
* section[structuredSection].section[socialHistorySection].code.coding.userSelected ..0
* section[structuredSection].section[socialHistorySection].code.text ..0
* section[structuredSection].section[socialHistorySection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[socialHistorySection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[socialHistorySection].text MS
* section[structuredSection].section[socialHistorySection].text.status MS
* section[structuredSection].section[socialHistorySection].text.status = #additional (exactly)
* section[structuredSection].section[socialHistorySection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[socialHistorySection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[socialHistorySection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[socialHistorySection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[socialHistorySection].mode ..0
* section[structuredSection].section[socialHistorySection].orderedBy ..0
* section[structuredSection].section[socialHistorySection].entry 0..* MS
* section[structuredSection].section[socialHistorySection].entry only Reference(JP_Observation_SocialHistory)
* section[structuredSection].section[socialHistorySection].entry ^short = "社会歴・生活習慣情報を記述したObservationリソースを参照"
* section[structuredSection].section[socialHistorySection].entry ^definition = """社会歴・生活習慣情報を記述して参照する。
                                                                1つの社会歴・生活習慣につき1つのObservationリソースで記述されたものを参照する。
                                                                記述すべき社会歴・生活習慣情報が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                社会歴・生活習慣情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[structuredSection].section[socialHistorySection].emptyReason ..1
* section[structuredSection].section[socialHistorySection].section ..0
//
//
* section[structuredSection].section[physicalStatusOnAdmissionSection] ^short = "入院時身体所見セクション"
* section[structuredSection].section[physicalStatusOnAdmissionSection] ^definition = "入院時身体所見セクション"
* section[structuredSection].section[physicalStatusOnAdmissionSection].title 1.. MS
* section[structuredSection].section[physicalStatusOnAdmissionSection].title = "入院時身体所見"
* section[structuredSection].section[physicalStatusOnAdmissionSection].title ^short = "セクションタイトル"
* section[structuredSection].section[physicalStatusOnAdmissionSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[physicalStatusOnAdmissionSection].code 1.. MS
* section[structuredSection].section[physicalStatusOnAdmissionSection].code ^short = "セクション区分コード"
* section[structuredSection].section[physicalStatusOnAdmissionSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding 1..1 MS
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.system 1.. MS
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.code 1.. MS
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.code = #612 (exactly)
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.display = "入院時身体所見セクション" (exactly)
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.display MS
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.coding.userSelected ..0
* section[structuredSection].section[physicalStatusOnAdmissionSection].code.text ..0
* section[structuredSection].section[physicalStatusOnAdmissionSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[physicalStatusOnAdmissionSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[physicalStatusOnAdmissionSection].text MS
* section[structuredSection].section[physicalStatusOnAdmissionSection].text.status MS
* section[structuredSection].section[physicalStatusOnAdmissionSection].text.status = #additional (exactly)
* section[structuredSection].section[physicalStatusOnAdmissionSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[physicalStatusOnAdmissionSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[physicalStatusOnAdmissionSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[physicalStatusOnAdmissionSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[physicalStatusOnAdmissionSection].mode ..0
* section[structuredSection].section[physicalStatusOnAdmissionSection].orderedBy ..0
* section[structuredSection].section[physicalStatusOnAdmissionSection].entry 0..* MS
* section[structuredSection].section[physicalStatusOnAdmissionSection].entry only Reference(JP_Observation_Common)
* section[structuredSection].section[physicalStatusOnAdmissionSection].entry ^short = "入院時の身体所見を記述したObservationリソースを参照"
* section[structuredSection].section[physicalStatusOnAdmissionSection].entry ^definition = """入院時の身体所見を記述して参照する。
                                                                1つの身体所見につき1つのObservationリソースで記述されたものを参照する。
                                                                記述すべき身体所見が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                身体所見を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                """
* section[structuredSection].section[physicalStatusOnAdmissionSection].emptyReason ..1
* section[structuredSection].section[physicalStatusOnAdmissionSection].section ..0
////
* section[structuredSection].section[familiyHistorySection] ^short = "家族歴セクション"
* section[structuredSection].section[familiyHistorySection] ^definition = "家族歴セクション"
* section[structuredSection].section[familiyHistorySection].title 1.. MS
* section[structuredSection].section[familiyHistorySection].title = "家族歴"
* section[structuredSection].section[familiyHistorySection].title ^short = "セクションタイトル"
* section[structuredSection].section[familiyHistorySection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[familiyHistorySection].code 1.. MS
* section[structuredSection].section[familiyHistorySection].code ^short = "セクション区分コード"
* section[structuredSection].section[familiyHistorySection].code ^definition = "セクション区分コード"
* section[structuredSection].section[familiyHistorySection].code.coding 1..1 MS
* section[structuredSection].section[familiyHistorySection].code.coding.system 1.. MS
* section[structuredSection].section[familiyHistorySection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[familiyHistorySection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[familiyHistorySection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[familiyHistorySection].code.coding.code 1.. MS
* section[structuredSection].section[familiyHistorySection].code.coding.code = #552 (exactly)
* section[structuredSection].section[familiyHistorySection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[familiyHistorySection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[familiyHistorySection].code.coding.display = "家族歴セクション" (exactly)
* section[structuredSection].section[familiyHistorySection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[familiyHistorySection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[familiyHistorySection].code.coding.display MS
* section[structuredSection].section[familiyHistorySection].code.coding.userSelected ..0
* section[structuredSection].section[familiyHistorySection].code.text ..0
* section[structuredSection].section[familiyHistorySection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[familiyHistorySection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[familiyHistorySection].text MS
* section[structuredSection].section[familiyHistorySection].text.status MS
* section[structuredSection].section[familiyHistorySection].text.status = #additional (exactly)
* section[structuredSection].section[familiyHistorySection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[familiyHistorySection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[familiyHistorySection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[familiyHistorySection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[familiyHistorySection].mode ..0
* section[structuredSection].section[familiyHistorySection].orderedBy ..0
* section[structuredSection].section[familiyHistorySection].entry 0..* MS
* section[structuredSection].section[familiyHistorySection].entry only Reference(JP_FamilyMemberHistory)
* section[structuredSection].section[familiyHistorySection].entry ^short = "入院時に取得した家族歴情報を記述したFamilyMemberHistoryリソースを参照"
* section[structuredSection].section[familiyHistorySection].entry ^definition = """入院時に取得した家族歴情報情報を記述して参照する。
                                                                1つの家族歴につき1つのFamilyMemberHistoryリソースで記述されたものを参照する。
                                                                記述すべき家族歴情報が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                家族歴情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                """
* section[structuredSection].section[familiyHistorySection].emptyReason ..1
* section[structuredSection].section[familiyHistorySection].section ..0
//
//

* section[structuredSection].section[hospitalCourseSection] ^short = "入院中経過セクション"
* section[structuredSection].section[hospitalCourseSection] ^definition = "入院中経過セクション"
* section[structuredSection].section[hospitalCourseSection].title 1.. MS
* section[structuredSection].section[hospitalCourseSection].title = "入院中経過"
* section[structuredSection].section[hospitalCourseSection].title ^short = "セクションタイトル"
* section[structuredSection].section[hospitalCourseSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[hospitalCourseSection].code 1.. MS
* section[structuredSection].section[hospitalCourseSection].code ^short = "セクション区分コード"
* section[structuredSection].section[hospitalCourseSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[hospitalCourseSection].code.coding 1..1 MS
* section[structuredSection].section[hospitalCourseSection].code.coding.system 1.. MS
* section[structuredSection].section[hospitalCourseSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[hospitalCourseSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[hospitalCourseSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[hospitalCourseSection].code.coding.code 1.. MS
* section[structuredSection].section[hospitalCourseSection].code.coding.code = #333 (exactly)
* section[structuredSection].section[hospitalCourseSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[hospitalCourseSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[hospitalCourseSection].code.coding.display = "入院中経過セクション" (exactly)
* section[structuredSection].section[hospitalCourseSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[hospitalCourseSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[hospitalCourseSection].code.coding.display MS
* section[structuredSection].section[hospitalCourseSection].code.coding.userSelected ..0
* section[structuredSection].section[hospitalCourseSection].code.text ..0
* section[structuredSection].section[hospitalCourseSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[hospitalCourseSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[hospitalCourseSection].text MS
* section[structuredSection].section[hospitalCourseSection].text.status MS
* section[structuredSection].section[hospitalCourseSection].text.status = #additional (exactly)
* section[structuredSection].section[hospitalCourseSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[hospitalCourseSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[hospitalCourseSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[hospitalCourseSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[hospitalCourseSection].mode ..0
* section[structuredSection].section[hospitalCourseSection].orderedBy ..0
* section[structuredSection].section[hospitalCourseSection].entry 1..* MS
* section[structuredSection].section[hospitalCourseSection].entry only Reference(JP_DocumentReference)
* section[structuredSection].section[hospitalCourseSection].entry ^short = "臨床経過を記述したDocumentReferenceリソースを参照"
* section[structuredSection].section[hospitalCourseSection].entry ^definition = """臨床経過を記述して参照する。
                                                                1つ以上のDocumentReferenceリソースで記述されたものを参照する。
                                                                診療情報提供書では臨床経過の記述は常に必要である。
                                                                """
* section[structuredSection].section[hospitalCourseSection].emptyReason ..1
* section[structuredSection].section[hospitalCourseSection].section ..0
////
////
* section[structuredSection].section[detailsOnDischargeSection] ^short = "退院時詳細セクション"
* section[structuredSection].section[detailsOnDischargeSection] ^definition = "退院時詳細セクション"
* section[structuredSection].section[detailsOnDischargeSection].title 1.. MS
* section[structuredSection].section[detailsOnDischargeSection].title = "退院時詳細"
* section[structuredSection].section[detailsOnDischargeSection].title ^short = "セクションタイトル"
* section[structuredSection].section[detailsOnDischargeSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[detailsOnDischargeSection].code 1.. MS
* section[structuredSection].section[detailsOnDischargeSection].code ^short = "セクション区分コード"
* section[structuredSection].section[detailsOnDischargeSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[detailsOnDischargeSection].code.coding 1..1 MS
* section[structuredSection].section[detailsOnDischargeSection].code.coding.system 1.. MS
* section[structuredSection].section[detailsOnDischargeSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[detailsOnDischargeSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[detailsOnDischargeSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[detailsOnDischargeSection].code.coding.code 1.. MS
* section[structuredSection].section[detailsOnDischargeSection].code.coding.code = #324 (exactly)
* section[structuredSection].section[detailsOnDischargeSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[detailsOnDischargeSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[detailsOnDischargeSection].code.coding.display = "退院時詳細セクション" (exactly)
* section[structuredSection].section[detailsOnDischargeSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[detailsOnDischargeSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[detailsOnDischargeSection].code.coding.display MS
* section[structuredSection].section[detailsOnDischargeSection].code.coding.userSelected ..0
* section[structuredSection].section[detailsOnDischargeSection].code.text ..0
* section[structuredSection].section[detailsOnDischargeSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[detailsOnDischargeSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[detailsOnDischargeSection].text MS
* section[structuredSection].section[detailsOnDischargeSection].text.status MS
* section[structuredSection].section[detailsOnDischargeSection].text.status = #additional (exactly)
* section[structuredSection].section[detailsOnDischargeSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[detailsOnDischargeSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[detailsOnDischargeSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[detailsOnDischargeSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[detailsOnDischargeSection].mode ..0
* section[structuredSection].section[detailsOnDischargeSection].orderedBy ..0
* section[structuredSection].section[detailsOnDischargeSection].entry 1..1 MS
* section[structuredSection].section[detailsOnDischargeSection].entry only Reference(JP_Encounter)
* section[structuredSection].section[detailsOnDischargeSection].entry ^short = "Encounterへの参照"
* section[structuredSection].section[detailsOnDischargeSection].entry ^definition = "Encounterへの参照"
* section[structuredSection].section[detailsOnDischargeSection].emptyReason ..1
* section[structuredSection].section[detailsOnDischargeSection].section ..0
//
//
* section[structuredSection].section[diagnosesOnDischargeSection] ^short = "退院時診断セクション"
* section[structuredSection].section[diagnosesOnDischargeSection] ^definition = "退院時診断セクション"
* section[structuredSection].section[diagnosesOnDischargeSection].title 1.. MS
* section[structuredSection].section[diagnosesOnDischargeSection].title = "退院時診断"
* section[structuredSection].section[diagnosesOnDischargeSection].title ^short = "セクションタイトル"
* section[structuredSection].section[diagnosesOnDischargeSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[diagnosesOnDischargeSection].code 1.. MS
* section[structuredSection].section[diagnosesOnDischargeSection].code ^short = "セクション区分コード"
* section[structuredSection].section[diagnosesOnDischargeSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding 1..1 MS
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.system 1.. MS
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.code 1.. MS
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.code = #344 (exactly)
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.display = "退院時診断セクション" (exactly)
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.display MS
* section[structuredSection].section[diagnosesOnDischargeSection].code.coding.userSelected ..0
* section[structuredSection].section[diagnosesOnDischargeSection].code.text ..0
* section[structuredSection].section[diagnosesOnDischargeSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[diagnosesOnDischargeSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[diagnosesOnDischargeSection].text MS
* section[structuredSection].section[diagnosesOnDischargeSection].text.status MS
* section[structuredSection].section[diagnosesOnDischargeSection].text.status = #additional (exactly)
* section[structuredSection].section[diagnosesOnDischargeSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[diagnosesOnDischargeSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[diagnosesOnDischargeSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[diagnosesOnDischargeSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[diagnosesOnDischargeSection].mode ..0
* section[structuredSection].section[diagnosesOnDischargeSection].orderedBy ..0
* section[structuredSection].section[diagnosesOnDischargeSection].entry 1..* MS
* section[structuredSection].section[diagnosesOnDischargeSection].entry only Reference(JP_Condition)
* section[structuredSection].section[diagnosesOnDischargeSection].entry ^short = "必須。傷病名・主訴を１個以上必ず記述する。"
* section[structuredSection].section[diagnosesOnDischargeSection].entry ^definition = """傷病名・主訴を１個以上必ず記述する。1つにつき1つのConditionで記述されたものを参照する。
    フリーテキストでしか記述できない場合には、Condition.code.text に記述する。
    """
* section[structuredSection].section[diagnosesOnDischargeSection].emptyReason ..1 MS
* section[structuredSection].section[diagnosesOnDischargeSection].section ..0
////
//

* section[structuredSection].section[medicationOnDischargeSection] ^short = "退院時投薬指示セクション"
* section[structuredSection].section[medicationOnDischargeSection] ^definition = "退院時投薬指示セクション"
* section[structuredSection].section[medicationOnDischargeSection].title 1.. MS
* section[structuredSection].section[medicationOnDischargeSection].title = "退院時投薬指示"
* section[structuredSection].section[medicationOnDischargeSection].title ^short = "セクションタイトル"
* section[structuredSection].section[medicationOnDischargeSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[medicationOnDischargeSection].code 1.. MS
* section[structuredSection].section[medicationOnDischargeSection].code ^short = "セクション区分コード"
* section[structuredSection].section[medicationOnDischargeSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[medicationOnDischargeSection].code.coding 1..1 MS
* section[structuredSection].section[medicationOnDischargeSection].code.coding.system 1.. MS
* section[structuredSection].section[medicationOnDischargeSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[medicationOnDischargeSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[medicationOnDischargeSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[medicationOnDischargeSection].code.coding.code 1.. MS
* section[structuredSection].section[medicationOnDischargeSection].code.coding.code = #444 (exactly)
* section[structuredSection].section[medicationOnDischargeSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[medicationOnDischargeSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[medicationOnDischargeSection].code.coding.display = "退院時投薬指示セクション" (exactly)
* section[structuredSection].section[medicationOnDischargeSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[medicationOnDischargeSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[medicationOnDischargeSection].code.coding.display MS
* section[structuredSection].section[medicationOnDischargeSection].code.coding.userSelected ..0
* section[structuredSection].section[medicationOnDischargeSection].code.text ..0
* section[structuredSection].section[medicationOnDischargeSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[medicationOnDischargeSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[medicationOnDischargeSection].text MS
* section[structuredSection].section[medicationOnDischargeSection].text.status MS
* section[structuredSection].section[medicationOnDischargeSection].text.status = #additional (exactly)
* section[structuredSection].section[medicationOnDischargeSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[medicationOnDischargeSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[medicationOnDischargeSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[medicationOnDischargeSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[medicationOnDischargeSection].mode ..0
* section[structuredSection].section[medicationOnDischargeSection].orderedBy ..0
* section[structuredSection].section[medicationOnDischargeSection].entry 0..* MS
* section[structuredSection].section[medicationOnDischargeSection].entry only Reference(JP_MedicationRequest_ePrescriptionData)
* section[structuredSection].section[medicationOnDischargeSection].entry ^short = "退院時の投薬指示情報を記述したMedicationRequestリソースを参照"
* section[structuredSection].section[medicationOnDischargeSection].entry ^definition = """投薬指示情報を記述して参照する。
                                                                1つの投薬指示情報につき1つのMedicationRequestリソースで記述されたものを参照する。
                                                                記述すべき投薬指示情報が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                投薬指示情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[structuredSection].section[medicationOnDischargeSection].emptyReason ..1
* section[structuredSection].section[medicationOnDischargeSection].section ..0
////
* section[structuredSection].section[instructionOnDischargeSection] ^short = "退院時方針指示セクション"
* section[structuredSection].section[instructionOnDischargeSection] ^definition = "退院時方針指示セクション"
* section[structuredSection].section[instructionOnDischargeSection].title 1.. MS
* section[structuredSection].section[instructionOnDischargeSection].title = "退院時方針指示"
* section[structuredSection].section[instructionOnDischargeSection].title ^short = "セクションタイトル"
* section[structuredSection].section[instructionOnDischargeSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[instructionOnDischargeSection].code 1.. MS
* section[structuredSection].section[instructionOnDischargeSection].code ^short = "セクション区分コード"
* section[structuredSection].section[instructionOnDischargeSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[instructionOnDischargeSection].code.coding 1..1 MS
* section[structuredSection].section[instructionOnDischargeSection].code.coding.system 1.. MS
* section[structuredSection].section[instructionOnDischargeSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[instructionOnDischargeSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[instructionOnDischargeSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[instructionOnDischargeSection].code.coding.code 1.. MS
* section[structuredSection].section[instructionOnDischargeSection].code.coding.code = #424 (exactly)
* section[structuredSection].section[instructionOnDischargeSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[instructionOnDischargeSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[instructionOnDischargeSection].code.coding.display = "退院時方針指示セクション" (exactly)
* section[structuredSection].section[instructionOnDischargeSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[instructionOnDischargeSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[instructionOnDischargeSection].code.coding.display MS
* section[structuredSection].section[instructionOnDischargeSection].code.coding.userSelected ..0
* section[structuredSection].section[instructionOnDischargeSection].code.text ..0
* section[structuredSection].section[instructionOnDischargeSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[instructionOnDischargeSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[instructionOnDischargeSection].text MS
* section[structuredSection].section[instructionOnDischargeSection].text.status MS
* section[structuredSection].section[instructionOnDischargeSection].text.status = #additional (exactly)
* section[structuredSection].section[instructionOnDischargeSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[instructionOnDischargeSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[instructionOnDischargeSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[instructionOnDischargeSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[instructionOnDischargeSection].mode ..0
* section[structuredSection].section[instructionOnDischargeSection].orderedBy ..0
* section[structuredSection].section[instructionOnDischargeSection].entry 0..* MS
* section[structuredSection].section[instructionOnDischargeSection].entry only Reference(JP_CarePlan)
* section[structuredSection].section[instructionOnDischargeSection].entry ^short = "退院時方針指示を記述したCarePlanリソースを参照"
* section[structuredSection].section[instructionOnDischargeSection].entry ^definition = """診療方針指示を記述して参照する。
                                                                1つの指示をひとつのCarePlanリソースで記述されたものを参照する。
                                                                記述すべき診療方針指示が特にないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[structuredSection].section[instructionOnDischargeSection].emptyReason ..1
* section[structuredSection].section[instructionOnDischargeSection].section ..0
////
//
* section[structuredSection].section[physicalStatusOnDischargeSection] ^short = "退院時身体所見セクション"
* section[structuredSection].section[physicalStatusOnDischargeSection] ^definition = "退院時身体所見セクション"
* section[structuredSection].section[physicalStatusOnDischargeSection].title 1.. MS
* section[structuredSection].section[physicalStatusOnDischargeSection].title = "退院時身体所見"
* section[structuredSection].section[physicalStatusOnDischargeSection].title ^short = "セクションタイトル"
* section[structuredSection].section[physicalStatusOnDischargeSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[physicalStatusOnDischargeSection].code 1.. MS
* section[structuredSection].section[physicalStatusOnDischargeSection].code ^short = "セクション区分コード"
* section[structuredSection].section[physicalStatusOnDischargeSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding 1..1 MS
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.system 1.. MS
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.code 1.. MS
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.code = #614 (exactly)
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.display = "退院時身体所見セクション" (exactly)
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.display MS
* section[structuredSection].section[physicalStatusOnDischargeSection].code.coding.userSelected ..0
* section[structuredSection].section[physicalStatusOnDischargeSection].code.text ..0
* section[structuredSection].section[physicalStatusOnDischargeSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[physicalStatusOnDischargeSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[physicalStatusOnDischargeSection].text MS
* section[structuredSection].section[physicalStatusOnDischargeSection].text.status MS
* section[structuredSection].section[physicalStatusOnDischargeSection].text.status = #additional (exactly)
* section[structuredSection].section[physicalStatusOnDischargeSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[physicalStatusOnDischargeSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[physicalStatusOnDischargeSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[physicalStatusOnDischargeSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[physicalStatusOnDischargeSection].mode ..0
* section[structuredSection].section[physicalStatusOnDischargeSection].orderedBy ..0
* section[structuredSection].section[physicalStatusOnDischargeSection].entry 0..* MS
* section[structuredSection].section[physicalStatusOnDischargeSection].entry only Reference(JP_Observation_Common)
* section[structuredSection].section[physicalStatusOnDischargeSection].entry ^short = "退院時の身体所見を記述したObservationリソースを参照"
* section[structuredSection].section[physicalStatusOnDischargeSection].entry ^definition = """退院時の身体所見を記述して参照する。
                                                                1つの身体所見につき1つのObservationリソースで記述されたものを参照する。
                                                                記述すべき身体所見が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                身体所見を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                """
* section[structuredSection].section[physicalStatusOnDischargeSection].emptyReason ..1
* section[structuredSection].section[physicalStatusOnDischargeSection].section ..0

////
* section[structuredSection].section[hospitalProcedureSection] ^short = "入院中治療セクション"
* section[structuredSection].section[hospitalProcedureSection] ^definition = "入院中治療セクション"
* section[structuredSection].section[hospitalProcedureSection].title 1.. MS
* section[structuredSection].section[hospitalProcedureSection].title = "入院中治療セクション"
* section[structuredSection].section[hospitalProcedureSection].title ^short = "セクションタイトル"
* section[structuredSection].section[hospitalProcedureSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[hospitalProcedureSection].code 1.. MS
* section[structuredSection].section[hospitalProcedureSection].code ^short = "セクション区分コード"
* section[structuredSection].section[hospitalProcedureSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[hospitalProcedureSection].code.coding 1..1 MS
* section[structuredSection].section[hospitalProcedureSection].code.coding.system 1.. MS
* section[structuredSection].section[hospitalProcedureSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[hospitalProcedureSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[hospitalProcedureSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[hospitalProcedureSection].code.coding.code 1.. MS
* section[structuredSection].section[hospitalProcedureSection].code.coding.code = #713 (exactly)
* section[structuredSection].section[hospitalProcedureSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[hospitalProcedureSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[hospitalProcedureSection].code.coding.display = "入院中治療セクション" (exactly)
* section[structuredSection].section[hospitalProcedureSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[hospitalProcedureSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[hospitalProcedureSection].code.coding.display MS
* section[structuredSection].section[hospitalProcedureSection].code.coding.userSelected ..0
* section[structuredSection].section[hospitalProcedureSection].code.text ..0
* section[structuredSection].section[hospitalProcedureSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[hospitalProcedureSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[hospitalProcedureSection].text MS
* section[structuredSection].section[hospitalProcedureSection].text.status MS
* section[structuredSection].section[hospitalProcedureSection].text.status = #additional (exactly)
* section[structuredSection].section[hospitalProcedureSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[hospitalProcedureSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[hospitalProcedureSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[hospitalProcedureSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[hospitalProcedureSection].mode ..0
* section[structuredSection].section[hospitalProcedureSection].orderedBy ..0
* section[structuredSection].section[hospitalProcedureSection].entry 0..* MS
* section[structuredSection].section[hospitalProcedureSection].entry only Reference(JP_Procedure)
* section[structuredSection].section[hospitalProcedureSection].entry ^short = "治療情報を記述したProcedureリソースを参照"
* section[structuredSection].section[hospitalProcedureSection].entry ^definition = """治療情報を記述して参照する。
                                                                1つの治療情報につき1つのProcedureリソースで記述されたものを参照する。
                                                                記述すべき治療情報が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                治療情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                               """
* section[structuredSection].section[hospitalProcedureSection].emptyReason ..1
* section[structuredSection].section[hospitalProcedureSection].section ..0
//

* section[structuredSection].section[hospitalStudySection] ^short = "入院中検査結果セクション"
* section[structuredSection].section[hospitalStudySection] ^definition = "入院中検査結果セクション"
* section[structuredSection].section[hospitalStudySection].title 1.. MS
* section[structuredSection].section[hospitalStudySection].title = "入院中検査結果"
* section[structuredSection].section[hospitalStudySection].title ^short = "セクションタイトル"
* section[structuredSection].section[hospitalStudySection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[hospitalStudySection].code 1.. MS
* section[structuredSection].section[hospitalStudySection].code ^short = "セクション区分コード"
* section[structuredSection].section[hospitalStudySection].code ^definition = "セクション区分コード"
* section[structuredSection].section[hospitalStudySection].code.coding 1..1 MS
* section[structuredSection].section[hospitalStudySection].code.coding.system 1.. MS
* section[structuredSection].section[hospitalStudySection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[hospitalStudySection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[hospitalStudySection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[hospitalStudySection].code.coding.code 1.. MS
* section[structuredSection].section[hospitalStudySection].code.coding.code = #623 (exactly)
* section[structuredSection].section[hospitalStudySection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[hospitalStudySection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[hospitalStudySection].code.coding.display = "入院中検査結果セクション" (exactly)
* section[structuredSection].section[hospitalStudySection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[hospitalStudySection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[hospitalStudySection].code.coding.display MS
* section[structuredSection].section[hospitalStudySection].code.coding.userSelected ..0
* section[structuredSection].section[hospitalStudySection].code.text ..0
* section[structuredSection].section[hospitalStudySection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[hospitalStudySection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[hospitalStudySection].text MS
* section[structuredSection].section[hospitalStudySection].text.status MS
* section[structuredSection].section[hospitalStudySection].text.status = #additional (exactly)
* section[structuredSection].section[hospitalStudySection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[hospitalStudySection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[hospitalStudySection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[hospitalStudySection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[hospitalStudySection].mode ..0
* section[structuredSection].section[hospitalStudySection].orderedBy ..0
* section[structuredSection].section[hospitalStudySection].entry 0..* MS
* section[structuredSection].section[hospitalStudySection].entry only Reference(JP_Observation_Common or JP_ImagingStudy_Radiology or JP_DiagnosticReport_Common or Bundle)
* section[structuredSection].section[hospitalStudySection].entry ^short = "入院中検査結果を記述したObservationリソースなどを参照"
* section[structuredSection].section[hospitalStudySection].entry ^definition = """入院中検査結果を記述して参照する。記述すべき結果が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                結果データを取得しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                """
* section[structuredSection].section[hospitalStudySection].emptyReason ..1
* section[structuredSection].section[hospitalStudySection].section ..0

////
//

* section[structuredSection].section[medicalDeviceSection] ^short = "医療機器セクション"
* section[structuredSection].section[medicalDeviceSection] ^definition = "医療機器セクション"
* section[structuredSection].section[medicalDeviceSection].title 1.. MS
* section[structuredSection].section[medicalDeviceSection].title = "医療機器"
* section[structuredSection].section[medicalDeviceSection].title ^short = "セクションタイトル"
* section[structuredSection].section[medicalDeviceSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[medicalDeviceSection].code 1.. MS
* section[structuredSection].section[medicalDeviceSection].code ^short = "セクション区分コード"
* section[structuredSection].section[medicalDeviceSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[medicalDeviceSection].code.coding 1..1 MS
* section[structuredSection].section[medicalDeviceSection].code.coding.system 1.. MS
* section[structuredSection].section[medicalDeviceSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[medicalDeviceSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[medicalDeviceSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[medicalDeviceSection].code.coding.code 1.. MS
* section[structuredSection].section[medicalDeviceSection].code.coding.code = #810 (exactly)
* section[structuredSection].section[medicalDeviceSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[medicalDeviceSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[medicalDeviceSection].code.coding.display = "医療機器セクション" (exactly)
* section[structuredSection].section[medicalDeviceSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[medicalDeviceSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[medicalDeviceSection].code.coding.display MS
* section[structuredSection].section[medicalDeviceSection].code.coding.userSelected ..0
* section[structuredSection].section[medicalDeviceSection].code.text ..0
* section[structuredSection].section[medicalDeviceSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[medicalDeviceSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[medicalDeviceSection].text MS
* section[structuredSection].section[medicalDeviceSection].text.status MS
* section[structuredSection].section[medicalDeviceSection].text.status = #additional (exactly)
* section[structuredSection].section[medicalDeviceSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[medicalDeviceSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[medicalDeviceSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[medicalDeviceSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[medicalDeviceSection].mode ..0
* section[structuredSection].section[medicalDeviceSection].orderedBy ..0
* section[structuredSection].section[medicalDeviceSection].entry 0..* MS
* section[structuredSection].section[medicalDeviceSection].entry only Reference(JP_DeviceUseStatement)
* section[structuredSection].section[medicalDeviceSection].entry ^short = "医療機器情報を記述したDocumentReferenceリソースを参照"
* section[structuredSection].section[medicalDeviceSection].entry ^definition = """医療機器情報を記述して参照する。
                                                                1つの医療機器情報をひとつのDeviceUseStatementリソースで記述されたものを参照する。
                                                                記述すべき医療機器情報が特にないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[structuredSection].section[medicalDeviceSection].emptyReason ..1
* section[structuredSection].section[medicalDeviceSection].section ..0
////
//
* section[structuredSection].section[immunizationSection] ^short = "予防接種歴セクション"
* section[structuredSection].section[immunizationSection] ^definition = "予防接種歴セクション"
* section[structuredSection].section[immunizationSection].title 1.. MS
* section[structuredSection].section[immunizationSection].title = "予防接種歴"
* section[structuredSection].section[immunizationSection].title ^short = "セクションタイトル"
* section[structuredSection].section[immunizationSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[immunizationSection].code 1.. MS
* section[structuredSection].section[immunizationSection].code ^short = "セクション区分コード"
* section[structuredSection].section[immunizationSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[immunizationSection].code.coding 1..1 MS
* section[structuredSection].section[immunizationSection].code.coding.system 1.. MS
* section[structuredSection].section[immunizationSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[immunizationSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[immunizationSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[immunizationSection].code.coding.code 1.. MS
* section[structuredSection].section[immunizationSection].code.coding.code = #530 (exactly)
* section[structuredSection].section[immunizationSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[immunizationSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[immunizationSection].code.coding.display = "予防接種歴セクション" (exactly)
* section[structuredSection].section[immunizationSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[immunizationSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[immunizationSection].code.coding.display MS
* section[structuredSection].section[immunizationSection].code.coding.userSelected ..0
* section[structuredSection].section[immunizationSection].code.text ..0
* section[structuredSection].section[immunizationSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[immunizationSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[immunizationSection].text MS
* section[structuredSection].section[immunizationSection].text.status MS
* section[structuredSection].section[immunizationSection].text.status = #additional (exactly)
* section[structuredSection].section[immunizationSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[immunizationSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[immunizationSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[immunizationSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[immunizationSection].mode ..0
* section[structuredSection].section[immunizationSection].orderedBy ..0
* section[structuredSection].section[immunizationSection].entry 0..* MS
* section[structuredSection].section[immunizationSection].entry only Reference(JP_Immunization)
* section[structuredSection].section[immunizationSection].entry ^short = "予防接種歴情報を記述したImmunizationリソースを参照"
* section[structuredSection].section[immunizationSection].entry ^definition = """予防接種歴情報を記述して参照する。
                                                                1つの予防接種歴情報につき1つのImmunizationリソースで記述されたものを参照する。
                                                                記述すべき予防接種歴情報が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                予防接種歴情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[structuredSection].section[immunizationSection].emptyReason ..1
* section[structuredSection].section[immunizationSection].section ..0
//
* section[structuredSection].section[advanceDirectiveSection] ^short = "事前指示セクション"
* section[structuredSection].section[advanceDirectiveSection] ^definition = "事前指示セクション"
* section[structuredSection].section[advanceDirectiveSection].title 1.. MS
* section[structuredSection].section[advanceDirectiveSection].title = "事前指示"
* section[structuredSection].section[advanceDirectiveSection].title ^short = "セクションタイトル"
* section[structuredSection].section[advanceDirectiveSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[advanceDirectiveSection].code 1.. MS
* section[structuredSection].section[advanceDirectiveSection].code ^short = "セクション区分コード"
* section[structuredSection].section[advanceDirectiveSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[advanceDirectiveSection].code.coding 1..1 MS
* section[structuredSection].section[advanceDirectiveSection].code.coding.system 1.. MS
* section[structuredSection].section[advanceDirectiveSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[advanceDirectiveSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[advanceDirectiveSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[advanceDirectiveSection].code.coding.code 1.. MS
* section[structuredSection].section[advanceDirectiveSection].code.coding.code = #410 (exactly)
* section[structuredSection].section[advanceDirectiveSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[advanceDirectiveSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[advanceDirectiveSection].code.coding.display = "事前指示セクション" (exactly)
* section[structuredSection].section[advanceDirectiveSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[advanceDirectiveSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[advanceDirectiveSection].code.coding.display MS
* section[structuredSection].section[advanceDirectiveSection].code.coding.userSelected ..0
* section[structuredSection].section[advanceDirectiveSection].code.text ..0
* section[structuredSection].section[advanceDirectiveSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[advanceDirectiveSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[advanceDirectiveSection].text MS
* section[structuredSection].section[advanceDirectiveSection].text.status MS
* section[structuredSection].section[advanceDirectiveSection].text.status = #additional (exactly)
* section[structuredSection].section[advanceDirectiveSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[advanceDirectiveSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[advanceDirectiveSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[advanceDirectiveSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[advanceDirectiveSection].mode ..0
* section[structuredSection].section[advanceDirectiveSection].orderedBy ..0
* section[structuredSection].section[advanceDirectiveSection].entry 0..* MS
* section[structuredSection].section[advanceDirectiveSection].entry only Reference(JP_Consent)
* section[structuredSection].section[advanceDirectiveSection].entry ^short = "事前指示を記述したConcentリソースを参照"
* section[structuredSection].section[advanceDirectiveSection].entry ^definition = """事前指示を記述して参照する。
                                                                1つの指示をひとつのConsentリソースで記述されたものを参照する。
                                                                記述すべき事前指示が特にないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[structuredSection].section[advanceDirectiveSection].emptyReason ..1
* section[structuredSection].section[advanceDirectiveSection].section ..0
////
* section[structuredSection].section[researchParticipationSection] ^short = "臨床研究参加セクション"
* section[structuredSection].section[researchParticipationSection] ^definition = "臨床研究参加セクション"
* section[structuredSection].section[researchParticipationSection].title 1.. MS
* section[structuredSection].section[researchParticipationSection].title = "臨床研究参加"
* section[structuredSection].section[researchParticipationSection].title ^short = "セクションタイトル"
* section[structuredSection].section[researchParticipationSection].title ^definition = "セクションタイトル。固定値。"
* section[structuredSection].section[researchParticipationSection].code 1.. MS
* section[structuredSection].section[researchParticipationSection].code ^short = "セクション区分コード"
* section[structuredSection].section[researchParticipationSection].code ^definition = "セクション区分コード"
* section[structuredSection].section[researchParticipationSection].code.coding 1..1 MS
* section[structuredSection].section[researchParticipationSection].code.coding.system 1.. MS
* section[structuredSection].section[researchParticipationSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[structuredSection].section[researchParticipationSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[structuredSection].section[researchParticipationSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[structuredSection].section[researchParticipationSection].code.coding.code 1.. MS
* section[structuredSection].section[researchParticipationSection].code.coding.code = #830 (exactly)
* section[structuredSection].section[researchParticipationSection].code.coding.code ^short = "セクション区分のコード値"
* section[structuredSection].section[researchParticipationSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[structuredSection].section[researchParticipationSection].code.coding.display = "臨床研究参加セクション" (exactly)
* section[structuredSection].section[researchParticipationSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[structuredSection].section[researchParticipationSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[structuredSection].section[researchParticipationSection].code.coding.display MS
* section[structuredSection].section[researchParticipationSection].code.coding.userSelected ..0
* section[structuredSection].section[researchParticipationSection].code.text ..0
* section[structuredSection].section[researchParticipationSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[structuredSection].section[researchParticipationSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[structuredSection].section[researchParticipationSection].text MS
* section[structuredSection].section[researchParticipationSection].text.status MS
* section[structuredSection].section[researchParticipationSection].text.status = #additional (exactly)
* section[structuredSection].section[researchParticipationSection].text.status ^short = "セクションの内容作成状態コード"
* section[structuredSection].section[researchParticipationSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[structuredSection].section[researchParticipationSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[structuredSection].section[researchParticipationSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[structuredSection].section[researchParticipationSection].mode ..0
* section[structuredSection].section[researchParticipationSection].orderedBy ..0
* section[structuredSection].section[researchParticipationSection].entry 0..* MS
* section[structuredSection].section[researchParticipationSection].entry only Reference(JP_ResearchSubject)
* section[structuredSection].section[researchParticipationSection].entry ^short = "臨床研究参加情報を記述したDocumentReferenceリソースを参照"
* section[structuredSection].section[researchParticipationSection].entry ^definition = """臨床研究参加情報を記述して参照する。
                                                                1つの臨床研究参加情報をひとつのResearchSubjectリソースで記述されたものを参照する。
                                                                記述すべき臨床研究参加情報が特にないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[structuredSection].section[researchParticipationSection].emptyReason ..1
* section[structuredSection].section[researchParticipationSection].section ..0
//