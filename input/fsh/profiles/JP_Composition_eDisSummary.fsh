// 
Invariant: checkExist-CDASection-or-CompositionSection
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
* obeys checkExist-CDASection-or-CompositionSection
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
    and cdaSection   0..1 MS // CDA参照セクション    cdaSection
    and compositionSection     0..1 MS // 構造情報セクション   compositionSection
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
* section[cdaSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
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
* section[cdaSection].emptyReason ..0
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
* section[attachmentSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
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
* section[attachmentSection].entry 1..1
* section[attachmentSection].entry only Reference(DocumentReference or Binary)  // あえてJP_を外している
* section[attachmentSection].entry ^short = "添付情報ファイルへの参照"
* section[attachmentSection].entry ^definition = "添付情報ファイルへの参照"
* section[attachmentSection].emptyReason ..0
* section[attachmentSection].section ..0
//
//
* section[compositionSection] ^short = "構造情報セクション"
* section[compositionSection] ^definition = "構造情報セクション"
* section[compositionSection].title 1.. MS
* section[compositionSection].title = "構造情報" (exactly)
* section[compositionSection].title ^short = "セクションタイトル"
* section[compositionSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].code 1.. MS
* section[compositionSection].code ^short = "セクション区分コード"
* section[compositionSection].code ^definition = "セクション区分コード"
* section[compositionSection].code.coding 1..1 MS
* section[compositionSection].code.coding.system 1.. MS
* section[compositionSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].code.coding.code 1.. MS
* section[compositionSection].code.coding.code = #300 (exactly)
* section[compositionSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].code.coding.display = "構造情報セクション" (exactly)
* section[compositionSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].code.coding.display MS
* section[compositionSection].code.coding.userSelected ..0
* section[compositionSection].code.text ..0
* section[compositionSection].text ..0 
* section[compositionSection].mode ..0
* section[compositionSection].orderedBy ..0
* section[compositionSection].emptyReason ..0  MS
//* section[compositionSection].emptyReason.coding    1..1    MS
//* section[compositionSection].emptyReason.coding.system = "http://terminology.hl7.org/CodeSystem/list-empty-reason"
//* section[compositionSection].emptyReason.coding.code = #unavilable (exactly)
//
* section[compositionSection].section ^slicing.discriminator.type = #value
* section[compositionSection].section ^slicing.discriminator.path = "code.coding.code"
* section[compositionSection].section ^slicing.rules = #open

* section[compositionSection].section   contains 
        admissionDetailsSection	  1..1    MS  // 入院詳細セクション
    and admissionDiagnosesSection    1..1    MS  // 入院時診断セクション
    and allergiesIIntoleranceSection     0..1    MS  // アレルギー・不耐性反応セクション
    and chiefComplaintSection    1..1    MS  // 入院時主訴セクション
    and reasonForAdmissionSection      1..1    MS  // 入院理由セクション
    and presentIllnessSection     1..1    MS  // 入院時現病歴セクション
    and pastIllnessOnAdmissionSection    0..1    MS  // 入院時既往歴セクション
    and admissionMedicationsSection   0..1    MS  //  入院時服薬セクション
    and socialHistorySection      0..1    MS  //  入院時社会歴セクション
	and admissionPhysicalStatusSection   0..1    MS  //  入院時身体所見セクション
	and familiyHistorySection      0..1    MS  //  入院時家族歴セクション
	and hospitalCourseSection     1..1    MS  //  入院中経過セクション
	and dischargeDetailsSection     1..1    MS  //  退院時詳細セクション
	and dischargeDiagnosesSection     1..1    MS  //  退院時診断セクション
	and dischargedischargeMedicationSection     1..1    MS  //  退院時投薬指示セクション 
	and dischargeInstructionSection     1..1    MS  //  退院時方針指示セクション
	and dischargePhysicalStatusSection    0..1    MS  //  退院時身体所見セクション
	and hospitalProcedureSection 0..1 MS // 入院中治療セクション
    and hospitalStudySection   0..1 MS // 入院中検査結果セクション
    and medicalDeviceSection      0..1    MS  //  医療機器セクション
    and immunizationSection      0..1    MS  // 予防接種歴セクション
	and advanceDirectiveSection   0..1    MS  //  事前指示セクション
	and researchParticipationSection      0..1    MS  //  臨床研究参加セクション
//
* section[compositionSection].section[admissionDetailsSection]
* section[compositionSection].section[admissionDetailsSection] ^short = "入院詳細セクション"
* section[compositionSection].section[admissionDetailsSection] ^definition = "入院詳細セクション"
* section[compositionSection].section[admissionDetailsSection].title 1.. MS
* section[compositionSection].section[admissionDetailsSection].title = "入院詳細"
* section[compositionSection].section[admissionDetailsSection].title ^short = "セクションタイトル"
* section[compositionSection].section[admissionDetailsSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[admissionDetailsSection].code 1.. MS
* section[compositionSection].section[admissionDetailsSection].code ^short = "セクション区分コード"
* section[compositionSection].section[admissionDetailsSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[admissionDetailsSection].code.coding 1..1 MS
* section[compositionSection].section[admissionDetailsSection].code.coding.system 1.. MS
* section[compositionSection].section[admissionDetailsSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[admissionDetailsSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[admissionDetailsSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[admissionDetailsSection].code.coding.code 1.. MS
* section[compositionSection].section[admissionDetailsSection].code.coding.code = #322 (exactly)
* section[compositionSection].section[admissionDetailsSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[admissionDetailsSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[admissionDetailsSection].code.coding.display = "入院詳細セクション" (exactly)
* section[compositionSection].section[admissionDetailsSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[admissionDetailsSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[admissionDetailsSection].code.coding.display MS
* section[compositionSection].section[admissionDetailsSection].code.coding.userSelected ..0
* section[compositionSection].section[admissionDetailsSection].code.text ..0
* section[compositionSection].section[admissionDetailsSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[admissionDetailsSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[admissionDetailsSection].text MS
* section[compositionSection].section[admissionDetailsSection].text.status MS
* section[compositionSection].section[admissionDetailsSection].text.status = #additional (exactly)
* section[compositionSection].section[admissionDetailsSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[admissionDetailsSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[admissionDetailsSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[admissionDetailsSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[admissionDetailsSection].mode ..0
* section[compositionSection].section[admissionDetailsSection].orderedBy ..0
* section[compositionSection].section[admissionDetailsSection].entry 1..1 MS
* section[compositionSection].section[admissionDetailsSection].entry only Reference(JP_Encounter)
* section[compositionSection].section[admissionDetailsSection].entry ^short = "Encounterリソースを参照"
* section[compositionSection].section[admissionDetailsSection].entry ^definition = "Encounterリソースを参照"
* section[compositionSection].section[admissionDetailsSection].emptyReason ..0 MS
* section[compositionSection].section[admissionDetailsSection].section ..0
//
//
* section[compositionSection].section[admissionDiagnosesSection]
* section[compositionSection].section[admissionDiagnosesSection] ^short = "入院時診断セクション"
* section[compositionSection].section[admissionDiagnosesSection] ^definition = "入院時診断セクション"
* section[compositionSection].section[admissionDiagnosesSection].title 1.. MS
* section[compositionSection].section[admissionDiagnosesSection].title = "入院時診断"
* section[compositionSection].section[admissionDiagnosesSection].title ^short = "セクションタイトル"
* section[compositionSection].section[admissionDiagnosesSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[admissionDiagnosesSection].code 1.. MS
* section[compositionSection].section[admissionDiagnosesSection].code ^short = "セクション区分コード"
* section[compositionSection].section[admissionDiagnosesSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[admissionDiagnosesSection].code.coding 1..1 MS
* section[compositionSection].section[admissionDiagnosesSection].code.coding.system 1.. MS
* section[compositionSection].section[admissionDiagnosesSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section" (exactly)
* section[compositionSection].section[admissionDiagnosesSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[admissionDiagnosesSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[admissionDiagnosesSection].code.coding.code 1.. MS
* section[compositionSection].section[admissionDiagnosesSection].code.coding.code = #342 (exactly)
* section[compositionSection].section[admissionDiagnosesSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[admissionDiagnosesSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[admissionDiagnosesSection].code.coding.display = "入院時診断セクション" (exactly)
* section[compositionSection].section[admissionDiagnosesSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[admissionDiagnosesSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[admissionDiagnosesSection].code.coding.display MS
* section[compositionSection].section[admissionDiagnosesSection].code.coding.userSelected ..0
* section[compositionSection].section[admissionDiagnosesSection].code.text ..0
* section[compositionSection].section[admissionDiagnosesSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[admissionDiagnosesSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[admissionDiagnosesSection].text MS
* section[compositionSection].section[admissionDiagnosesSection].text.status MS
* section[compositionSection].section[admissionDiagnosesSection].text.status = #additional (exactly)
* section[compositionSection].section[admissionDiagnosesSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[admissionDiagnosesSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[admissionDiagnosesSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[admissionDiagnosesSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[admissionDiagnosesSection].mode ..0
* section[compositionSection].section[admissionDiagnosesSection].orderedBy ..0
* section[compositionSection].section[admissionDiagnosesSection].entry 0..* MS
* section[compositionSection].section[admissionDiagnosesSection].entry only Reference(JP_Condition)
* section[compositionSection].section[admissionDiagnosesSection].entry ^short = "必須。入院時の傷病名・主訴を１個以上必ず記述する。"
* section[compositionSection].section[admissionDiagnosesSection].entry ^definition = "入院時の傷病名"
* section[compositionSection].section[admissionDiagnosesSection].emptyReason ..1 MS
* section[compositionSection].section[admissionDiagnosesSection].section ..0
//
//
* section[compositionSection].section[allergiesIIntoleranceSection]
* section[compositionSection].section[allergiesIIntoleranceSection] ^short = "アレルギー・不耐性反応セクション"
* section[compositionSection].section[allergiesIIntoleranceSection] ^definition = "アレルギー・不耐性反応セクション"
* section[compositionSection].section[allergiesIIntoleranceSection].title 1.. MS
* section[compositionSection].section[allergiesIIntoleranceSection].title = "アレルギー・不耐性反応"
* section[compositionSection].section[allergiesIIntoleranceSection].title ^short = "セクションタイトル"
* section[compositionSection].section[allergiesIIntoleranceSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[allergiesIIntoleranceSection].code 1.. MS
* section[compositionSection].section[allergiesIIntoleranceSection].code ^short = "セクション区分コード"
* section[compositionSection].section[allergiesIIntoleranceSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding 1..1 MS
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.system 1.. MS
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.code 1.. MS
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.code = #510 (exactly)
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.display = "アレルギー・不耐性反応セクション" (exactly)
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.display MS
* section[compositionSection].section[allergiesIIntoleranceSection].code.coding.userSelected ..0
* section[compositionSection].section[allergiesIIntoleranceSection].code.text ..0
* section[compositionSection].section[allergiesIIntoleranceSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[allergiesIIntoleranceSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[allergiesIIntoleranceSection].text MS
* section[compositionSection].section[allergiesIIntoleranceSection].text.status MS
* section[compositionSection].section[allergiesIIntoleranceSection].text.status = #additional (exactly)
* section[compositionSection].section[allergiesIIntoleranceSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[allergiesIIntoleranceSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[allergiesIIntoleranceSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[allergiesIIntoleranceSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[allergiesIIntoleranceSection].mode ..0
* section[compositionSection].section[allergiesIIntoleranceSection].orderedBy ..0
* section[compositionSection].section[allergiesIIntoleranceSection].entry 0..* MS
* section[compositionSection].section[allergiesIIntoleranceSection].entry only Reference(JP_AllergyIntolerance)
* section[compositionSection].section[allergiesIIntoleranceSection].entry ^short = "アレルギー・不耐性反応情報を記述したAllergyIntoleranceリソースを参照"
* section[compositionSection].section[allergiesIIntoleranceSection].entry ^definition = """アレルギー・不耐性反応情報を記述して参照する。
                                                                1つのアレルギーにつき1つのAllergyIntoleranceリソースで記述されたものを参照する。
                                                                記述すべきアレルギー・不耐性反応情報が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                アレルギー・不耐性反応情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。                                                                
                                                                """
* section[compositionSection].section[allergiesIIntoleranceSection].emptyReason ..1
* section[compositionSection].section[allergiesIIntoleranceSection].section ..0
//
////
* section[compositionSection].section[chiefComplaintSection]
* section[compositionSection].section[chiefComplaintSection] ^short = "入院時主訴セクション"
* section[compositionSection].section[chiefComplaintSection] ^definition = "入院時主訴セクション"
* section[compositionSection].section[chiefComplaintSection].title 1.. MS
* section[compositionSection].section[chiefComplaintSection].title = "入院時主訴"
* section[compositionSection].section[chiefComplaintSection].title ^short = "セクションタイトル"
* section[compositionSection].section[chiefComplaintSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[chiefComplaintSection].code 1.. MS
* section[compositionSection].section[chiefComplaintSection].code ^short = "セクション区分コード"
* section[compositionSection].section[chiefComplaintSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[chiefComplaintSection].code.coding 1..1 MS
* section[compositionSection].section[chiefComplaintSection].code.coding.system 1.. MS
* section[compositionSection].section[chiefComplaintSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[chiefComplaintSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[chiefComplaintSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[chiefComplaintSection].code.coding.code 1.. MS
* section[compositionSection].section[chiefComplaintSection].code.coding.code = #352 (exactly)
* section[compositionSection].section[chiefComplaintSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[chiefComplaintSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[chiefComplaintSection].code.coding.display = "入院時主訴セクション" (exactly)
* section[compositionSection].section[chiefComplaintSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[chiefComplaintSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[chiefComplaintSection].code.coding.display MS
* section[compositionSection].section[chiefComplaintSection].code.coding.userSelected ..0
* section[compositionSection].section[chiefComplaintSection].code.text ..0
* section[compositionSection].section[chiefComplaintSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[chiefComplaintSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[chiefComplaintSection].text MS
* section[compositionSection].section[chiefComplaintSection].text.status MS
* section[compositionSection].section[chiefComplaintSection].text.status = #additional (exactly)
* section[compositionSection].section[chiefComplaintSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[chiefComplaintSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[chiefComplaintSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[chiefComplaintSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[chiefComplaintSection].mode ..0
* section[compositionSection].section[chiefComplaintSection].orderedBy ..0
* section[compositionSection].section[chiefComplaintSection].entry 0..* MS
* section[compositionSection].section[chiefComplaintSection].entry only Reference(JP_Condition)
* section[compositionSection].section[chiefComplaintSection].entry ^short = "主訴に対応するConditionリソースを参照"
* section[compositionSection].section[chiefComplaintSection].entry ^definition = "主訴に対応するConditionリソースを参照"
* section[compositionSection].section[chiefComplaintSection].emptyReason ..1
* section[compositionSection].section[chiefComplaintSection].section ..0
//
* section[compositionSection].section[reasonForAdmissionSection]
* section[compositionSection].section[reasonForAdmissionSection] ^short = "入院理由セクション"
* section[compositionSection].section[reasonForAdmissionSection] ^definition = "入院理由セクション"
* section[compositionSection].section[reasonForAdmissionSection].title 1.. MS
* section[compositionSection].section[reasonForAdmissionSection].title = "入院理由"
* section[compositionSection].section[reasonForAdmissionSection].title ^short = "セクションタイトル"
* section[compositionSection].section[reasonForAdmissionSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[reasonForAdmissionSection].code 1.. MS
* section[compositionSection].section[reasonForAdmissionSection].code ^short = "セクション区分コード"
* section[compositionSection].section[reasonForAdmissionSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[reasonForAdmissionSection].code.coding 1..1 MS
* section[compositionSection].section[reasonForAdmissionSection].code.coding.system 1.. MS
* section[compositionSection].section[reasonForAdmissionSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[reasonForAdmissionSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[reasonForAdmissionSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[reasonForAdmissionSection].code.coding.code 1.. MS
* section[compositionSection].section[reasonForAdmissionSection].code.coding.code = #312 (exactly)
* section[compositionSection].section[reasonForAdmissionSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[reasonForAdmissionSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[reasonForAdmissionSection].code.coding.display = "手術セクション" (exactly)
* section[compositionSection].section[reasonForAdmissionSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[reasonForAdmissionSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[reasonForAdmissionSection].code.coding.display MS
* section[compositionSection].section[reasonForAdmissionSection].code.coding.userSelected ..0
* section[compositionSection].section[reasonForAdmissionSection].code.text ..0
* section[compositionSection].section[reasonForAdmissionSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[reasonForAdmissionSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[reasonForAdmissionSection].text MS
* section[compositionSection].section[reasonForAdmissionSection].text.status MS
* section[compositionSection].section[reasonForAdmissionSection].text.status = #additional (exactly)
* section[compositionSection].section[reasonForAdmissionSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[reasonForAdmissionSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[reasonForAdmissionSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[reasonForAdmissionSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[reasonForAdmissionSection].mode ..0
* section[compositionSection].section[reasonForAdmissionSection].orderedBy ..0
* section[compositionSection].section[reasonForAdmissionSection].entry 0..1 MS
* section[compositionSection].section[reasonForAdmissionSection].entry only Reference(JP_Encouter)
* section[compositionSection].section[reasonForAdmissionSection].entry ^short = "入院理由をEncounter.reasonCodeに記述する"
* section[compositionSection].section[reasonForAdmissionSection].entry ^definition = "CodeableConceptであるEncounter.reasonCodeに病名あるいはtextで記述できる"
* section[compositionSection].section[reasonForAdmissionSection].emptyReason ..1
* section[compositionSection].section[reasonForAdmissionSection].section ..0
////
//
* section[compositionSection].section[presentIllnessSection]
* section[compositionSection].section[presentIllnessSection] ^short = "入院時現病歴セクション"
* section[compositionSection].section[presentIllnessSection] ^definition = "入院時現病歴セクション"
* section[compositionSection].section[presentIllnessSection].title 1.. MS
* section[compositionSection].section[presentIllnessSection].title = "入院時現病歴"
* section[compositionSection].section[presentIllnessSection].title ^short = "セクションタイトル"
* section[compositionSection].section[presentIllnessSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[presentIllnessSection].code 1.. MS
* section[compositionSection].section[presentIllnessSection].code ^short = "セクション区分コード"
* section[compositionSection].section[presentIllnessSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[presentIllnessSection].code.coding 1..1 MS
* section[compositionSection].section[presentIllnessSection].code.coding.system 1.. MS
* section[compositionSection].section[presentIllnessSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[presentIllnessSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[presentIllnessSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[presentIllnessSection].code.coding.code 1.. MS
* section[compositionSection].section[presentIllnessSection].code.coding.code = #362 (exactly)
* section[compositionSection].section[presentIllnessSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[presentIllnessSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[presentIllnessSection].code.coding.display = "入院時現病歴セクション" (exactly)
* section[compositionSection].section[presentIllnessSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[presentIllnessSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[presentIllnessSection].code.coding.display MS
* section[compositionSection].section[presentIllnessSection].code.coding.userSelected ..0
* section[compositionSection].section[presentIllnessSection].code.text ..0
* section[compositionSection].section[presentIllnessSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[presentIllnessSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[presentIllnessSection].text MS
* section[compositionSection].section[presentIllnessSection].text.status MS
* section[compositionSection].section[presentIllnessSection].text.status = #additional (exactly)
* section[compositionSection].section[presentIllnessSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[presentIllnessSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[presentIllnessSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[presentIllnessSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[presentIllnessSection].mode ..0
* section[compositionSection].section[presentIllnessSection].orderedBy ..0
* section[compositionSection].section[presentIllnessSection].entry 0..* MS
* section[compositionSection].section[presentIllnessSection].entry only Reference(JP_Condition)
* section[compositionSection].section[presentIllnessSection].entry ^short = "必須。現病歴として記述すべき疾患に関する現在にいたる経過歴を１個以上必ず記述したConditionリソースを参照する。"
* section[compositionSection].section[presentIllnessSection].entry ^definition = """フリーテキストでしか記述できない場合には、それをCondition.code.text 
                                                                            およびCodition.noteに記述したConditionリソースを参照する。
                                                                            疾患ごとに分けて現病歴を記述できる場合には、それぞれをひとつのConditionリソースで記述して参照する。
                                                                            """
* section[compositionSection].section[presentIllnessSection].emptyReason ..0
* section[compositionSection].section[presentIllnessSection].section ..0
////
* section[compositionSection].section[pastIllnessSection]
* section[compositionSection].section[pastIllnessSection] ^short = "入院時既往歴セクション"
* section[compositionSection].section[pastIllnessSection] ^definition = "入院時既往歴セクション"
* section[compositionSection].section[pastIllnessSection].title 1.. MS
* section[compositionSection].section[pastIllnessSection].title = "入院時既往歴"
* section[compositionSection].section[pastIllnessSection].title ^short = "セクションタイトル"
* section[compositionSection].section[pastIllnessSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[pastIllnessSection].code 1.. MS
* section[compositionSection].section[pastIllnessSection].code ^short = "セクション区分コード"
* section[compositionSection].section[pastIllnessSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[pastIllnessSection].code.coding 1..1 MS
* section[compositionSection].section[pastIllnessSection].code.coding.system 1.. MS
* section[compositionSection].section[pastIllnessSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[pastIllnessSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[pastIllnessSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[pastIllnessSection].code.coding.code 1.. MS
* section[compositionSection].section[pastIllnessSection].code.coding.code = #372 (exactly)
* section[compositionSection].section[pastIllnessSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[pastIllnessSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[pastIllnessSection].code.coding.display = "入院時既往歴セクション" (exactly)
* section[compositionSection].section[pastIllnessSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[pastIllnessSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[pastIllnessSection].code.coding.display MS
* section[compositionSection].section[pastIllnessSection].code.coding.userSelected ..0
* section[compositionSection].section[pastIllnessSection].code.text ..0
* section[compositionSection].section[pastIllnessSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[pastIllnessSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[pastIllnessSection].text MS
* section[compositionSection].section[pastIllnessSection].text.status MS
* section[compositionSection].section[pastIllnessSection].text.status = #additional (exactly)
* section[compositionSection].section[pastIllnessSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[pastIllnessSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[pastIllnessSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[pastIllnessSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[pastIllnessSection].mode ..0
* section[compositionSection].section[pastIllnessSection].orderedBy ..0
* section[compositionSection].section[pastIllnessSection].entry 0..* MS
* section[compositionSection].section[pastIllnessSection].entry only Reference(JP_Condition)
* section[compositionSection].section[pastIllnessSection].entry ^short = "既往歴をConditionリソースに記述して参照する。"
* section[compositionSection].section[pastIllnessSection].entry ^definition = """既往歴をConditionリソースに記述して参照する。
                                                                1つの既往疾患につき1つのConditionリソースで記述されたものを参照する。
                                                                記述すべき既往疾患が存在しないことを明示的に記述する（「既往特になし」など）場合にはentry要素は出現せず、emptyReasonにnilknownを記述する。
                                                                既往疾患情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                """
* section[compositionSection].section[pastIllnessSection].emptyReason ..1
* section[compositionSection].section[pastIllnessSection].section ..0
////

* section[compositionSection].section[admissionMedicationsSection]
* section[compositionSection].section[admissionMedicationsSection] ^short = "入院時服薬セクション"
* section[compositionSection].section[admissionMedicationsSection] ^definition = "入院時服薬セクション"
* section[compositionSection].section[admissionMedicationsSection].title 1.. MS
* section[compositionSection].section[admissionMedicationsSection].title = "入院時服薬"
* section[compositionSection].section[admissionMedicationsSection].title ^short = "セクションタイトル"
* section[compositionSection].section[admissionMedicationsSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[admissionMedicationsSection].code 1.. MS
* section[compositionSection].section[admissionMedicationsSection].code ^short = "セクション区分コード"
* section[compositionSection].section[admissionMedicationsSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[admissionMedicationsSection].code.coding 1..1 MS
* section[compositionSection].section[admissionMedicationsSection].code.coding.system 1.. MS
* section[compositionSection].section[admissionMedicationsSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[admissionMedicationsSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[admissionMedicationsSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[admissionMedicationsSection].code.coding.code 1.. MS
* section[compositionSection].section[admissionMedicationsSection].code.coding.code = #432 (exactly)
* section[compositionSection].section[admissionMedicationsSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[admissionMedicationsSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[admissionMedicationsSection].code.coding.display = "入院時服薬セクション" (exactly)
* section[compositionSection].section[admissionMedicationsSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[admissionMedicationsSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[admissionMedicationsSection].code.coding.display MS
* section[compositionSection].section[admissionMedicationsSection].code.coding.userSelected ..0
* section[compositionSection].section[admissionMedicationsSection].code.text ..0
* section[compositionSection].section[admissionMedicationsSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[admissionMedicationsSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[admissionMedicationsSection].text MS
* section[compositionSection].section[admissionMedicationsSection].text.status MS
* section[compositionSection].section[admissionMedicationsSection].text.status = #additional (exactly)
* section[compositionSection].section[admissionMedicationsSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[admissionMedicationsSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[admissionMedicationsSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[admissionMedicationsSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[admissionMedicationsSection].mode ..0
* section[compositionSection].section[admissionMedicationsSection].orderedBy ..0
* section[compositionSection].section[admissionMedicationsSection].entry 0..* MS
* section[compositionSection].section[admissionMedicationsSection].entry only Reference(JP_MedicationStatement)
* section[compositionSection].section[admissionMedicationsSection].entry ^short = "投薬情報を記述したMedicationStatementを参照"
* section[compositionSection].section[admissionMedicationsSection].entry ^definition = """入院時の服薬情報（正確には入院直前までの服薬情報）は、1医薬品ごとに1つのMedicationStatementリソースを使用して記述する。
    MedicationStatementでは、1医薬品ごとに用法を記述することができ、
    それが必要な場合で情報が入手できる場合には、MedicationStatement.dosage要素に記述する"""
* section[compositionSection].section[admissionMedicationsSection].emptyReason ..1
* section[compositionSection].section[admissionMedicationsSection].section ..0
////
////
* section[compositionSection].section[socialHistorySection]
* section[compositionSection].section[socialHistorySection] ^short = "入院時社会歴セクション"
* section[compositionSection].section[socialHistorySection] ^definition = "入院時社会歴セクション"
* section[compositionSection].section[socialHistorySection].title 1.. MS
* section[compositionSection].section[socialHistorySection].title = "入院時社会歴"
* section[compositionSection].section[socialHistorySection].title ^short = "セクションタイトル"
* section[compositionSection].section[socialHistorySection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[socialHistorySection].code 1.. MS
* section[compositionSection].section[socialHistorySection].code ^short = "セクション区分コード"
* section[compositionSection].section[socialHistorySection].code ^definition = "セクション区分コード"
* section[compositionSection].section[socialHistorySection].code.coding 1..1 MS
* section[compositionSection].section[socialHistorySection].code.coding.system 1.. MS
* section[compositionSection].section[socialHistorySection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[socialHistorySection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[socialHistorySection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[socialHistorySection].code.coding.code 1.. MS
* section[compositionSection].section[socialHistorySection].code.coding.code = #642 (exactly)
* section[compositionSection].section[socialHistorySection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[socialHistorySection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[socialHistorySection].code.coding.display = "入院時社会歴セクション" (exactly)
* section[compositionSection].section[socialHistorySection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[socialHistorySection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[socialHistorySection].code.coding.display MS
* section[compositionSection].section[socialHistorySection].code.coding.userSelected ..0
* section[compositionSection].section[socialHistorySection].code.text ..0
* section[compositionSection].section[socialHistorySection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[socialHistorySection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[socialHistorySection].text MS
* section[compositionSection].section[socialHistorySection].text.status MS
* section[compositionSection].section[socialHistorySection].text.status = #additional (exactly)
* section[compositionSection].section[socialHistorySection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[socialHistorySection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[socialHistorySection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[socialHistorySection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[socialHistorySection].mode ..0
* section[compositionSection].section[socialHistorySection].orderedBy ..0
* section[compositionSection].section[socialHistorySection].entry 0..* MS
* section[compositionSection].section[socialHistorySection].entry only Reference(JP_Observation_SocialHistory)
* section[compositionSection].section[socialHistorySection].entry ^short = "社会歴・生活習慣情報を記述したObservationリソースを参照"
* section[compositionSection].section[socialHistorySection].entry ^definition = """社会歴・生活習慣情報を記述して参照する。
                                                                1つの社会歴・生活習慣につき1つのObservationリソースで記述されたものを参照する。
                                                                記述すべき社会歴・生活習慣情報が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                社会歴・生活習慣情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[compositionSection].section[socialHistorySection].emptyReason ..1
* section[compositionSection].section[socialHistorySection].section ..0
//
//
* section[compositionSection].section[admissionPhysicalStatusSection]
* section[compositionSection].section[admissionPhysicalStatusSection] ^short = "入院時身体所見セクション"
* section[compositionSection].section[admissionPhysicalStatusSection] ^definition = "入院時身体所見セクション"
* section[compositionSection].section[admissionPhysicalStatusSection].title 1.. MS
* section[compositionSection].section[admissionPhysicalStatusSection].title = "入院時身体所見"
* section[compositionSection].section[admissionPhysicalStatusSection].title ^short = "セクションタイトル"
* section[compositionSection].section[admissionPhysicalStatusSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[admissionPhysicalStatusSection].code 1.. MS
* section[compositionSection].section[admissionPhysicalStatusSection].code ^short = "セクション区分コード"
* section[compositionSection].section[admissionPhysicalStatusSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding 1..1 MS
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.system 1.. MS
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.code 1.. MS
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.code = #612 (exactly)
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.display = "入院時身体所見セクション" (exactly)
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.display MS
* section[compositionSection].section[admissionPhysicalStatusSection].code.coding.userSelected ..0
* section[compositionSection].section[admissionPhysicalStatusSection].code.text ..0
* section[compositionSection].section[admissionPhysicalStatusSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[admissionPhysicalStatusSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[admissionPhysicalStatusSection].text MS
* section[compositionSection].section[admissionPhysicalStatusSection].text.status MS
* section[compositionSection].section[admissionPhysicalStatusSection].text.status = #additional (exactly)
* section[compositionSection].section[admissionPhysicalStatusSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[admissionPhysicalStatusSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[admissionPhysicalStatusSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[admissionPhysicalStatusSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[admissionPhysicalStatusSection].mode ..0
* section[compositionSection].section[admissionPhysicalStatusSection].orderedBy ..0
* section[compositionSection].section[admissionPhysicalStatusSection].entry 0..* MS
* section[compositionSection].section[admissionPhysicalStatusSection].entry only Reference(JP_Observation_Common)
* section[compositionSection].section[admissionPhysicalStatusSection].entry ^short = "入院時の身体所見を記述したObservationリソースを参照"
* section[compositionSection].section[admissionPhysicalStatusSection].entry ^definition = """入院時の身体所見を記述して参照する。
                                                                1つの身体所見につき1つのObservationリソースで記述されたものを参照する。
                                                                記述すべき身体所見が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                身体所見を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                """
* section[compositionSection].section[admissionPhysicalStatusSection].emptyReason ..1
* section[compositionSection].section[admissionPhysicalStatusSection].section ..0
////
* section[compositionSection].section[familiyHistorySection]
* section[compositionSection].section[familiyHistorySection] ^short = "入院時家族歴セクション"
* section[compositionSection].section[familiyHistorySection] ^definition = "入院時家族歴セクション"
* section[compositionSection].section[familiyHistorySection].title 1.. MS
* section[compositionSection].section[familiyHistorySection].title = "入院時家族歴"
* section[compositionSection].section[familiyHistorySection].title ^short = "セクションタイトル"
* section[compositionSection].section[familiyHistorySection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[familiyHistorySection].code 1.. MS
* section[compositionSection].section[familiyHistorySection].code ^short = "セクション区分コード"
* section[compositionSection].section[familiyHistorySection].code ^definition = "セクション区分コード"
* section[compositionSection].section[familiyHistorySection].code.coding 1..1 MS
* section[compositionSection].section[familiyHistorySection].code.coding.system 1.. MS
* section[compositionSection].section[familiyHistorySection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[familiyHistorySection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[familiyHistorySection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[familiyHistorySection].code.coding.code 1.. MS
* section[compositionSection].section[familiyHistorySection].code.coding.code = #552 (exactly)
* section[compositionSection].section[familiyHistorySection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[familiyHistorySection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[familiyHistorySection].code.coding.display = "入院時家族歴セクション" (exactly)
* section[compositionSection].section[familiyHistorySection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[familiyHistorySection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[familiyHistorySection].code.coding.display MS
* section[compositionSection].section[familiyHistorySection].code.coding.userSelected ..0
* section[compositionSection].section[familiyHistorySection].code.text ..0
* section[compositionSection].section[familiyHistorySection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[familiyHistorySection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[familiyHistorySection].text MS
* section[compositionSection].section[familiyHistorySection].text.status MS
* section[compositionSection].section[familiyHistorySection].text.status = #additional (exactly)
* section[compositionSection].section[familiyHistorySection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[familiyHistorySection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[familiyHistorySection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[familiyHistorySection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[familiyHistorySection].mode ..0
* section[compositionSection].section[familiyHistorySection].orderedBy ..0
* section[compositionSection].section[familiyHistorySection].entry 0..* MS
* section[compositionSection].section[familiyHistorySection].entry only Reference(JP_FamilyMemberHistory)
* section[compositionSection].section[familiyHistorySection].entry ^short = "入院時に取得した家族歴情報を記述したFamilyMemberHistoryリソースを参照"
* section[compositionSection].section[familiyHistorySection].entry ^definition = """入院時に取得した家族歴情報情報を記述して参照する。
                                                                1つの家族歴につき1つのFamilyMemberHistoryリソースで記述されたものを参照する。
                                                                記述すべき家族歴情報が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                家族歴情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                """
* section[compositionSection].section[familiyHistorySection].emptyReason ..1
* section[compositionSection].section[familiyHistorySection].section ..0
//
//

* section[compositionSection].section[hospitalCourseSection]
* section[compositionSection].section[hospitalCourseSection] ^short = "入院中経過セクション"
* section[compositionSection].section[hospitalCourseSection] ^definition = "入院中経過セクション"
* section[compositionSection].section[hospitalCourseSection].title 1.. MS
* section[compositionSection].section[hospitalCourseSection].title = "入院中経過"
* section[compositionSection].section[hospitalCourseSection].title ^short = "セクションタイトル"
* section[compositionSection].section[hospitalCourseSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[hospitalCourseSection].code 1.. MS
* section[compositionSection].section[hospitalCourseSection].code ^short = "セクション区分コード"
* section[compositionSection].section[hospitalCourseSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[hospitalCourseSection].code.coding 1..1 MS
* section[compositionSection].section[hospitalCourseSection].code.coding.system 1.. MS
* section[compositionSection].section[hospitalCourseSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[hospitalCourseSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[hospitalCourseSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[hospitalCourseSection].code.coding.code 1.. MS
* section[compositionSection].section[hospitalCourseSection].code.coding.code = #333 (exactly)
* section[compositionSection].section[hospitalCourseSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[hospitalCourseSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[hospitalCourseSection].code.coding.display = "入院中経過セクション" (exactly)
* section[compositionSection].section[hospitalCourseSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[hospitalCourseSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[hospitalCourseSection].code.coding.display MS
* section[compositionSection].section[hospitalCourseSection].code.coding.userSelected ..0
* section[compositionSection].section[hospitalCourseSection].code.text ..0
* section[compositionSection].section[hospitalCourseSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[hospitalCourseSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[hospitalCourseSection].text MS
* section[compositionSection].section[hospitalCourseSection].text.status MS
* section[compositionSection].section[hospitalCourseSection].text.status = #additional (exactly)
* section[compositionSection].section[hospitalCourseSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[hospitalCourseSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[hospitalCourseSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[hospitalCourseSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[hospitalCourseSection].mode ..0
* section[compositionSection].section[hospitalCourseSection].orderedBy ..0
* section[compositionSection].section[hospitalCourseSection].entry 1..* MS
* section[compositionSection].section[hospitalCourseSection].entry only Reference(JP_DocumentReference)
* section[compositionSection].section[hospitalCourseSection].entry ^short = "臨床経過を記述したDocumentReferenceリソースを参照"
* section[compositionSection].section[hospitalCourseSection].entry ^definition = """臨床経過を記述して参照する。
                                                                1つ以上のDocumentReferenceリソースで記述されたものを参照する。
                                                                診療情報提供書では臨床経過の記述は常に必要である。
                                                                """
* section[compositionSection].section[hospitalCourseSection].emptyReason ..0
* section[compositionSection].section[hospitalCourseSection].section ..0
////
////
* section[compositionSection].section[dischargeDetailsSection]
* section[compositionSection].section[dischargeDetailsSection] ^short = "退院時詳細セクション"
* section[compositionSection].section[dischargeDetailsSection] ^definition = "退院時詳細セクション"
* section[compositionSection].section[dischargeDetailsSection].title 1.. MS
* section[compositionSection].section[dischargeDetailsSection].title = "退院時詳細"
* section[compositionSection].section[dischargeDetailsSection].title ^short = "セクションタイトル"
* section[compositionSection].section[dischargeDetailsSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[dischargeDetailsSection].code 1.. MS
* section[compositionSection].section[dischargeDetailsSection].code ^short = "セクション区分コード"
* section[compositionSection].section[dischargeDetailsSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[dischargeDetailsSection].code.coding 1..1 MS
* section[compositionSection].section[dischargeDetailsSection].code.coding.system 1.. MS
* section[compositionSection].section[dischargeDetailsSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[dischargeDetailsSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[dischargeDetailsSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[dischargeDetailsSection].code.coding.code 1.. MS
* section[compositionSection].section[dischargeDetailsSection].code.coding.code = #324 (exactly)
* section[compositionSection].section[dischargeDetailsSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[dischargeDetailsSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[dischargeDetailsSection].code.coding.display = "退院時詳細セクション" (exactly)
* section[compositionSection].section[dischargeDetailsSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[dischargeDetailsSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[dischargeDetailsSection].code.coding.display MS
* section[compositionSection].section[dischargeDetailsSection].code.coding.userSelected ..0
* section[compositionSection].section[dischargeDetailsSection].code.text ..0
* section[compositionSection].section[dischargeDetailsSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[dischargeDetailsSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[dischargeDetailsSection].text MS
* section[compositionSection].section[dischargeDetailsSection].text.status MS
* section[compositionSection].section[dischargeDetailsSection].text.status = #additional (exactly)
* section[compositionSection].section[dischargeDetailsSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[dischargeDetailsSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[dischargeDetailsSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[dischargeDetailsSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[dischargeDetailsSection].mode ..0
* section[compositionSection].section[dischargeDetailsSection].orderedBy ..0
* section[compositionSection].section[dischargeDetailsSection].entry 1..1 MS
* section[compositionSection].section[dischargeDetailsSection].entry only Reference(JP_Encounter)
* section[compositionSection].section[dischargeDetailsSection].entry ^short = "Encounterへの参照"
* section[compositionSection].section[dischargeDetailsSection].entry ^definition = "Encounterへの参照"
* section[compositionSection].section[dischargeDetailsSection].emptyReason ..0
* section[compositionSection].section[dischargeDetailsSection].section ..0
//
//
* section[compositionSection].section[dischargeDiagnosesSection ]
* section[compositionSection].section[dischargeDiagnosesSection ] ^short = "退院時診断セクション"
* section[compositionSection].section[dischargeDiagnosesSection ] ^definition = "退院時診断セクション"
* section[compositionSection].section[dischargeDiagnosesSection ].title 1.. MS
* section[compositionSection].section[dischargeDiagnosesSection ].title = "退院時診断"
* section[compositionSection].section[dischargeDiagnosesSection ].title ^short = "セクションタイトル"
* section[compositionSection].section[dischargeDiagnosesSection ].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[dischargeDiagnosesSection ].code 1.. MS
* section[compositionSection].section[dischargeDiagnosesSection ].code ^short = "セクション区分コード"
* section[compositionSection].section[dischargeDiagnosesSection ].code ^definition = "セクション区分コード"
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding 1..1 MS
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.system 1.. MS
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.code 1.. MS
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.code = #344 (exactly)
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.display = "退院時診断セクション" (exactly)
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.display MS
* section[compositionSection].section[dischargeDiagnosesSection ].code.coding.userSelected ..0
* section[compositionSection].section[dischargeDiagnosesSection ].code.text ..0
* section[compositionSection].section[dischargeDiagnosesSection ].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[dischargeDiagnosesSection ].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[dischargeDiagnosesSection ].text MS
* section[compositionSection].section[dischargeDiagnosesSection ].text.status MS
* section[compositionSection].section[dischargeDiagnosesSection ].text.status = #additional (exactly)
* section[compositionSection].section[dischargeDiagnosesSection ].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[dischargeDiagnosesSection ].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[dischargeDiagnosesSection ].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[dischargeDiagnosesSection ].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[dischargeDiagnosesSection ].mode ..0
* section[compositionSection].section[dischargeDiagnosesSection ].orderedBy ..0
* section[compositionSection].section[dischargeDiagnosesSection ].entry 1..* MS
* section[compositionSection].section[dischargeDiagnosesSection ].entry only Reference(JP_Condition)
* section[compositionSection].section[dischargeDiagnosesSection ].entry ^short = "必須。傷病名・主訴を１個以上必ず記述する。"
* section[compositionSection].section[dischargeDiagnosesSection ].entry ^definition = """傷病名・主訴を１個以上必ず記述する。1つにつき1つのConditionで記述されたものを参照する。
    フリーテキストでしか記述できない場合には、Condition.code.text に記述する。
    """
* section[compositionSection].section[dischargeDiagnosesSection ].emptyReason ..1 MS
* section[compositionSection].section[dischargeDiagnosesSection ].section ..0
////
//

* section[compositionSection].section[dischargeMedicationSection]
* section[compositionSection].section[dischargeMedicationSection] ^short = "退院時投薬指示セクション"
* section[compositionSection].section[dischargeMedicationSection] ^definition = "退院時投薬指示セクション"
* section[compositionSection].section[dischargeMedicationSection].title 1.. MS
* section[compositionSection].section[dischargeMedicationSection].title = "退院時投薬指示"
* section[compositionSection].section[dischargeMedicationSection].title ^short = "セクションタイトル"
* section[compositionSection].section[dischargeMedicationSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[dischargeMedicationSection].code 1.. MS
* section[compositionSection].section[dischargeMedicationSection].code ^short = "セクション区分コード"
* section[compositionSection].section[dischargeMedicationSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[dischargeMedicationSection].code.coding 1..1 MS
* section[compositionSection].section[dischargeMedicationSection].code.coding.system 1.. MS
* section[compositionSection].section[dischargeMedicationSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[dischargeMedicationSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[dischargeMedicationSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[dischargeMedicationSection].code.coding.code 1.. MS
* section[compositionSection].section[dischargeMedicationSection].code.coding.code = #444 (exactly)
* section[compositionSection].section[dischargeMedicationSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[dischargeMedicationSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[dischargeMedicationSection].code.coding.display = "投薬指示セクション" (exactly)
* section[compositionSection].section[dischargeMedicationSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[dischargeMedicationSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[dischargeMedicationSection].code.coding.display MS
* section[compositionSection].section[dischargeMedicationSection].code.coding.userSelected ..0
* section[compositionSection].section[dischargeMedicationSection].code.text ..0
* section[compositionSection].section[dischargeMedicationSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[dischargeMedicationSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[dischargeMedicationSection].text MS
* section[compositionSection].section[dischargeMedicationSection].text.status MS
* section[compositionSection].section[dischargeMedicationSection].text.status = #additional (exactly)
* section[compositionSection].section[dischargeMedicationSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[dischargeMedicationSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[dischargeMedicationSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[dischargeMedicationSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[dischargeMedicationSection].mode ..0
* section[compositionSection].section[dischargeMedicationSection].orderedBy ..0
* section[compositionSection].section[dischargeMedicationSection].entry 0..* MS
* section[compositionSection].section[dischargeMedicationSection].entry only Reference(JP_MedicationRequest_ePrescriptionData)
* section[compositionSection].section[dischargeMedicationSection].entry ^short = "退院時の投薬指示情報を記述したMedicationRequestリソースを参照"
* section[compositionSection].section[dischargeMedicationSection].entry ^definition = """投薬指示情報を記述して参照する。
                                                                1つの投薬指示情報につき1つのMedicationRequestリソースで記述されたものを参照する。
                                                                記述すべき投薬指示情報が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                投薬指示情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[compositionSection].section[dischargeMedicationSection].emptyReason ..1
* section[compositionSection].section[dischargeMedicationSection].section ..0
////
* section[compositionSection].section[dischargeInstructionSection]
* section[compositionSection].section[dischargeInstructionSection] ^short = "退院時方針指示セクション"
* section[compositionSection].section[dischargeInstructionSection] ^definition = "退院時方針指示セクション"
* section[compositionSection].section[dischargeInstructionSection].title 1.. MS
* section[compositionSection].section[dischargeInstructionSection].title = "退院時方針指示"
* section[compositionSection].section[dischargeInstructionSection].title ^short = "セクションタイトル"
* section[compositionSection].section[dischargeInstructionSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[dischargeInstructionSection].code 1.. MS
* section[compositionSection].section[dischargeInstructionSection].code ^short = "セクション区分コード"
* section[compositionSection].section[dischargeInstructionSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[dischargeInstructionSection].code.coding 1..1 MS
* section[compositionSection].section[dischargeInstructionSection].code.coding.system 1.. MS
* section[compositionSection].section[dischargeInstructionSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[dischargeInstructionSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[dischargeInstructionSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[dischargeInstructionSection].code.coding.code 1.. MS
* section[compositionSection].section[dischargeInstructionSection].code.coding.code = #424 (exactly)
* section[compositionSection].section[dischargeInstructionSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[dischargeInstructionSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[dischargeInstructionSection].code.coding.display = "退院時方針指示セクション" (exactly)
* section[compositionSection].section[dischargeInstructionSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[dischargeInstructionSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[dischargeInstructionSection].code.coding.display MS
* section[compositionSection].section[dischargeInstructionSection].code.coding.userSelected ..0
* section[compositionSection].section[dischargeInstructionSection].code.text ..0
* section[compositionSection].section[dischargeInstructionSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[dischargeInstructionSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[dischargeInstructionSection].text MS
* section[compositionSection].section[dischargeInstructionSection].text.status MS
* section[compositionSection].section[dischargeInstructionSection].text.status = #additional (exactly)
* section[compositionSection].section[dischargeInstructionSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[dischargeInstructionSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[dischargeInstructionSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[dischargeInstructionSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[dischargeInstructionSection].mode ..0
* section[compositionSection].section[dischargeInstructionSection].orderedBy ..0
* section[compositionSection].section[dischargeInstructionSection].entry 0..* MS
* section[compositionSection].section[dischargeInstructionSection].entry only Reference(JP_CarePlan)
* section[compositionSection].section[dischargeInstructionSection].entry ^short = "退院時方針指示を記述したCarePlanリソースを参照"
* section[compositionSection].section[dischargeInstructionSection].entry ^definition = """診療方針指示を記述して参照する。
                                                                1つの指示をひとつのCarePlanリソースで記述されたものを参照する。
                                                                記述すべき診療方針指示が特にないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[compositionSection].section[dischargeInstructionSection].emptyReason ..1
* section[compositionSection].section[dischargeInstructionSection].section ..0
////
//
* section[compositionSection].section[dischargePhysicalStatusSection]
* section[compositionSection].section[dischargePhysicalStatusSection] ^short = "退院時身体所見セクション"
* section[compositionSection].section[dischargePhysicalStatusSection] ^definition = "退院時身体所見セクション"
* section[compositionSection].section[dischargePhysicalStatusSection].title 1.. MS
* section[compositionSection].section[dischargePhysicalStatusSection].title = "退院時身体所見"
* section[compositionSection].section[dischargePhysicalStatusSection].title ^short = "セクションタイトル"
* section[compositionSection].section[dischargePhysicalStatusSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[dischargePhysicalStatusSection].code 1.. MS
* section[compositionSection].section[dischargePhysicalStatusSection].code ^short = "セクション区分コード"
* section[compositionSection].section[dischargePhysicalStatusSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding 1..1 MS
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.system 1.. MS
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.code 1.. MS
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.code = #614 (exactly)
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.display = "退院時身体所見セクション" (exactly)
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.display MS
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.userSelected ..0
* section[compositionSection].section[dischargePhysicalStatusSection].code.text ..0
* section[compositionSection].section[dischargePhysicalStatusSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[dischargePhysicalStatusSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[dischargePhysicalStatusSection].text MS
* section[compositionSection].section[dischargePhysicalStatusSection].text.status MS
* section[compositionSection].section[dischargePhysicalStatusSection].text.status = #additional (exactly)
* section[compositionSection].section[dischargePhysicalStatusSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[dischargePhysicalStatusSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[dischargePhysicalStatusSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[dischargePhysicalStatusSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[dischargePhysicalStatusSection].mode ..0
* section[compositionSection].section[dischargePhysicalStatusSection].orderedBy ..0
* section[compositionSection].section[dischargePhysicalStatusSection].entry 0..* MS
* section[compositionSection].section[dischargePhysicalStatusSection].entry only Reference(JP_Observation_Common)
* section[compositionSection].section[dischargePhysicalStatusSection].entry ^short = "退院時の身体所見を記述したObservationリソースを参照"
* section[compositionSection].section[dischargePhysicalStatusSection].entry ^definition = """退院時の身体所見を記述して参照する。
                                                                1つの身体所見につき1つのObservationリソースで記述されたものを参照する。
                                                                記述すべき身体所見が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                身体所見を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                """
* section[compositionSection].section[dischargePhysicalStatusSection].emptyReason ..1
* section[compositionSection].section[dischargePhysicalStatusSection].section ..0

////
* section[compositionSection].section[hospitalProcedureSection]
* section[compositionSection].section[hospitalProcedureSection] ^short = "入院中治療セクション"
* section[compositionSection].section[hospitalProcedureSection] ^definition = "入院中治療セクション"
* section[compositionSection].section[hospitalProcedureSection].title 1.. MS
* section[compositionSection].section[hospitalProcedureSection].title = "入院中治療セクション"
* section[compositionSection].section[hospitalProcedureSection].title ^short = "セクションタイトル"
* section[compositionSection].section[hospitalProcedureSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[hospitalProcedureSection].code 1.. MS
* section[compositionSection].section[hospitalProcedureSection].code ^short = "セクション区分コード"
* section[compositionSection].section[hospitalProcedureSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[hospitalProcedureSection].code.coding 1..1 MS
* section[compositionSection].section[hospitalProcedureSection].code.coding.system 1.. MS
* section[compositionSection].section[hospitalProcedureSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[hospitalProcedureSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[hospitalProcedureSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[hospitalProcedureSection].code.coding.code 1.. MS
* section[compositionSection].section[hospitalProcedureSection].code.coding.code = #713 (exactly)
* section[compositionSection].section[hospitalProcedureSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[hospitalProcedureSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[hospitalProcedureSection].code.coding.display = "入院中治療セクション" (exactly)
* section[compositionSection].section[hospitalProcedureSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[hospitalProcedureSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[hospitalProcedureSection].code.coding.display MS
* section[compositionSection].section[hospitalProcedureSection].code.coding.userSelected ..0
* section[compositionSection].section[hospitalProcedureSection].code.text ..0
* section[compositionSection].section[hospitalProcedureSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[hospitalProcedureSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[hospitalProcedureSection].text MS
* section[compositionSection].section[hospitalProcedureSection].text.status MS
* section[compositionSection].section[hospitalProcedureSection].text.status = #additional (exactly)
* section[compositionSection].section[hospitalProcedureSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[hospitalProcedureSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[hospitalProcedureSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[hospitalProcedureSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[hospitalProcedureSection].mode ..0
* section[compositionSection].section[hospitalProcedureSection].orderedBy ..0
* section[compositionSection].section[hospitalProcedureSection].entry 0..* MS
* section[compositionSection].section[hospitalProcedureSection].entry only Reference(JP_Procedure)
* section[compositionSection].section[hospitalProcedureSection].entry ^short = "治療情報を記述したProcedureリソースを参照"
* section[compositionSection].section[hospitalProcedureSection].entry ^definition = """治療情報を記述して参照する。
                                                                1つの治療情報につき1つのProcedureリソースで記述されたものを参照する。
                                                                記述すべき治療情報が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                治療情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                               """
* section[compositionSection].section[hospitalProcedureSection].emptyReason ..1
* section[compositionSection].section[hospitalProcedureSection].section ..0
//

* section[compositionSection].section[dischargePhysicalStatusSection]
* section[compositionSection].section[dischargePhysicalStatusSection] ^short = "入院中検査結果セクション"
* section[compositionSection].section[dischargePhysicalStatusSection] ^definition = "入院中検査結果セクション"
* section[compositionSection].section[dischargePhysicalStatusSection].title 1.. MS
* section[compositionSection].section[dischargePhysicalStatusSection].title = "入院中検査結果"
* section[compositionSection].section[dischargePhysicalStatusSection].title ^short = "セクションタイトル"
* section[compositionSection].section[dischargePhysicalStatusSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[dischargePhysicalStatusSection].code 1.. MS
* section[compositionSection].section[dischargePhysicalStatusSection].code ^short = "セクション区分コード"
* section[compositionSection].section[dischargePhysicalStatusSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding 1..1 MS
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.system 1.. MS
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.code 1.. MS
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.code = #623 (exactly)
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.display = "入院中検査結果セクション" (exactly)
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.display MS
* section[compositionSection].section[dischargePhysicalStatusSection].code.coding.userSelected ..0
* section[compositionSection].section[dischargePhysicalStatusSection].code.text ..0
* section[compositionSection].section[dischargePhysicalStatusSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[dischargePhysicalStatusSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[dischargePhysicalStatusSection].text MS
* section[compositionSection].section[dischargePhysicalStatusSection].text.status MS
* section[compositionSection].section[dischargePhysicalStatusSection].text.status = #additional (exactly)
* section[compositionSection].section[dischargePhysicalStatusSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[dischargePhysicalStatusSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[dischargePhysicalStatusSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[dischargePhysicalStatusSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[dischargePhysicalStatusSection].mode ..0
* section[compositionSection].section[dischargePhysicalStatusSection].orderedBy ..0
* section[compositionSection].section[dischargePhysicalStatusSection].entry 0..* MS
* section[compositionSection].section[dischargePhysicalStatusSection].entry only Reference(JP_Observation_Common or JP_Imaging_study or JP_DiagnosticReport_Common or JP_Bundle)
* section[compositionSection].section[dischargePhysicalStatusSection].entry ^short = "入院中検査結果を記述したObservationリソースなどを参照"
* section[compositionSection].section[dischargePhysicalStatusSection].entry ^definition = """入院中検査結果を記述して参照する。記述すべき結果が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                結果データを取得しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                """
* section[compositionSection].section[dischargePhysicalStatusSection].emptyReason ..1
* section[compositionSection].section[dischargePhysicalStatusSection].section ..0

////
//

* section[compositionSection].section[medicalDeviceSection]
* section[compositionSection].section[medicalDeviceSection] ^short = "医療機器セクション"
* section[compositionSection].section[medicalDeviceSection] ^definition = "医療機器セクション"
* section[compositionSection].section[medicalDeviceSection].title 1.. MS
* section[compositionSection].section[medicalDeviceSection].title = "医療機器"
* section[compositionSection].section[medicalDeviceSection].title ^short = "セクションタイトル"
* section[compositionSection].section[medicalDeviceSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[medicalDeviceSection].code 1.. MS
* section[compositionSection].section[medicalDeviceSection].code ^short = "セクション区分コード"
* section[compositionSection].section[medicalDeviceSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[medicalDeviceSection].code.coding 1..1 MS
* section[compositionSection].section[medicalDeviceSection].code.coding.system 1.. MS
* section[compositionSection].section[medicalDeviceSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[medicalDeviceSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[medicalDeviceSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[medicalDeviceSection].code.coding.code 1.. MS
* section[compositionSection].section[medicalDeviceSection].code.coding.code = #810 (exactly)
* section[compositionSection].section[medicalDeviceSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[medicalDeviceSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[medicalDeviceSection].code.coding.display = "医療機器セクション" (exactly)
* section[compositionSection].section[medicalDeviceSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[medicalDeviceSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[medicalDeviceSection].code.coding.display MS
* section[compositionSection].section[medicalDeviceSection].code.coding.userSelected ..0
* section[compositionSection].section[medicalDeviceSection].code.text ..0
* section[compositionSection].section[medicalDeviceSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[medicalDeviceSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[medicalDeviceSection].text MS
* section[compositionSection].section[medicalDeviceSection].text.status MS
* section[compositionSection].section[medicalDeviceSection].text.status = #additional (exactly)
* section[compositionSection].section[medicalDeviceSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[medicalDeviceSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[medicalDeviceSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[medicalDeviceSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[medicalDeviceSection].mode ..0
* section[compositionSection].section[medicalDeviceSection].orderedBy ..0
* section[compositionSection].section[medicalDeviceSection].entry 0..* MS
* section[compositionSection].section[medicalDeviceSection].entry only Reference(JP_DeviceUseStatement)
* section[compositionSection].section[medicalDeviceSection].entry ^short = "医療機器情報を記述したDocumentReferenceリソースを参照"
* section[compositionSection].section[medicalDeviceSection].entry ^definition = """医療機器情報を記述して参照する。
                                                                1つの医療機器情報をひとつのDeviceUseStatementリソースで記述されたものを参照する。
                                                                記述すべき医療機器情報が特にないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[compositionSection].section[medicalDeviceSection].emptyReason ..1
* section[compositionSection].section[medicalDeviceSection].section ..0
////
//
* section[compositionSection].section[immunizationSection]
* section[compositionSection].section[immunizationSection] ^short = "予防接種歴セクション"
* section[compositionSection].section[immunizationSection] ^definition = "予防接種歴セクション"
* section[compositionSection].section[immunizationSection].title 1.. MS
* section[compositionSection].section[immunizationSection].title = "予防接種歴"
* section[compositionSection].section[immunizationSection].title ^short = "セクションタイトル"
* section[compositionSection].section[immunizationSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[immunizationSection].code 1.. MS
* section[compositionSection].section[immunizationSection].code ^short = "セクション区分コード"
* section[compositionSection].section[immunizationSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[immunizationSection].code.coding 1..1 MS
* section[compositionSection].section[immunizationSection].code.coding.system 1.. MS
* section[compositionSection].section[immunizationSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[immunizationSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[immunizationSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[immunizationSection].code.coding.code 1.. MS
* section[compositionSection].section[immunizationSection].code.coding.code = #530 (exactly)
* section[compositionSection].section[immunizationSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[immunizationSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[immunizationSection].code.coding.display = "予防接種歴セクション" (exactly)
* section[compositionSection].section[immunizationSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[immunizationSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[immunizationSection].code.coding.display MS
* section[compositionSection].section[immunizationSection].code.coding.userSelected ..0
* section[compositionSection].section[immunizationSection].code.text ..0
* section[compositionSection].section[immunizationSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[immunizationSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[immunizationSection].text MS
* section[compositionSection].section[immunizationSection].text.status MS
* section[compositionSection].section[immunizationSection].text.status = #additional (exactly)
* section[compositionSection].section[immunizationSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[immunizationSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[immunizationSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[immunizationSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[immunizationSection].mode ..0
* section[compositionSection].section[immunizationSection].orderedBy ..0
* section[compositionSection].section[immunizationSection].entry 0..* MS
* section[compositionSection].section[immunizationSection].entry only Reference(JP_Immunization)
* section[compositionSection].section[immunizationSection].entry ^short = "予防接種歴情報を記述したImmunizationリソースを参照"
* section[compositionSection].section[immunizationSection].entry ^definition = """予防接種歴情報を記述して参照する。
                                                                1つの予防接種歴情報につき1つのImmunizationリソースで記述されたものを参照する。
                                                                記述すべき予防接種歴情報が存在しないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                予防接種歴情報を聴取しようとしていない場合でそれを明示的に記述する（「取得せず」など）場合にはentry要素は出現せず、emptyReasonに notasked を記述する。
                                                                情報が患者やシステムから取得できない状況でそれを明示的に記述する（「取得できず」「不明」など）場合にはentry要素は出現せず、emptyReasonに unavailable を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[compositionSection].section[immunizationSection].emptyReason ..1
* section[compositionSection].section[immunizationSection].section ..0
//
* section[compositionSection].section[advanceDirectiveSection]
* section[compositionSection].section[advanceDirectiveSection] ^short = "事前指示セクション"
* section[compositionSection].section[advanceDirectiveSection] ^definition = "事前指示セクション"
* section[compositionSection].section[advanceDirectiveSection].title 1.. MS
* section[compositionSection].section[advanceDirectiveSection].title = "事前指示"
* section[compositionSection].section[advanceDirectiveSection].title ^short = "セクションタイトル"
* section[compositionSection].section[advanceDirectiveSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[advanceDirectiveSection].code 1.. MS
* section[compositionSection].section[advanceDirectiveSection].code ^short = "セクション区分コード"
* section[compositionSection].section[advanceDirectiveSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[advanceDirectiveSection].code.coding 1..1 MS
* section[compositionSection].section[advanceDirectiveSection].code.coding.system 1.. MS
* section[compositionSection].section[advanceDirectiveSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[advanceDirectiveSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[advanceDirectiveSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[advanceDirectiveSection].code.coding.code 1.. MS
* section[compositionSection].section[advanceDirectiveSection].code.coding.code = #410 (exactly)
* section[compositionSection].section[advanceDirectiveSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[advanceDirectiveSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[advanceDirectiveSection].code.coding.display = "事前指示セクション" (exactly)
* section[compositionSection].section[advanceDirectiveSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[advanceDirectiveSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[advanceDirectiveSection].code.coding.display MS
* section[compositionSection].section[advanceDirectiveSection].code.coding.userSelected ..0
* section[compositionSection].section[advanceDirectiveSection].code.text ..0
* section[compositionSection].section[advanceDirectiveSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[advanceDirectiveSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[advanceDirectiveSection].text MS
* section[compositionSection].section[advanceDirectiveSection].text.status MS
* section[compositionSection].section[advanceDirectiveSection].text.status = #additional (exactly)
* section[compositionSection].section[advanceDirectiveSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[advanceDirectiveSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[advanceDirectiveSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[advanceDirectiveSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[advanceDirectiveSection].mode ..0
* section[compositionSection].section[advanceDirectiveSection].orderedBy ..0
* section[compositionSection].section[advanceDirectiveSection].entry 0..* MS
* section[compositionSection].section[advanceDirectiveSection].entry only Reference(JP_Consent)
* section[compositionSection].section[advanceDirectiveSection].entry ^short = "事前指示を記述したConcentリソースを参照"
* section[compositionSection].section[advanceDirectiveSection].entry ^definition = """事前指示を記述して参照する。
                                                                1つの指示をひとつのConsentリソースで記述されたものを参照する。
                                                                記述すべき事前指示が特にないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[compositionSection].section[advanceDirectiveSection].emptyReason ..1
* section[compositionSection].section[advanceDirectiveSection].section ..0
////
* section[compositionSection].section[researchParticipationSection]
* section[compositionSection].section[researchParticipationSection] ^short = "臨床研究参加セクション"
* section[compositionSection].section[researchParticipationSection] ^definition = "臨床研究参加セクション"
* section[compositionSection].section[researchParticipationSection].title 1.. MS
* section[compositionSection].section[researchParticipationSection].title = "臨床研究参加"
* section[compositionSection].section[researchParticipationSection].title ^short = "セクションタイトル"
* section[compositionSection].section[researchParticipationSection].title ^definition = "セクションタイトル。固定値。"
* section[compositionSection].section[researchParticipationSection].code 1.. MS
* section[compositionSection].section[researchParticipationSection].code ^short = "セクション区分コード"
* section[compositionSection].section[researchParticipationSection].code ^definition = "セクション区分コード"
* section[compositionSection].section[researchParticipationSection].code.coding 1..1 MS
* section[compositionSection].section[researchParticipationSection].code.coding.system 1.. MS
* section[compositionSection].section[researchParticipationSection].code.coding.system = "http://jpfhir.jp/fhir/eClinicalSummary/CodeSystem/document-section " (exactly)
* section[compositionSection].section[researchParticipationSection].code.coding.system ^short = "セクション区分コードのコード体系"
* section[compositionSection].section[researchParticipationSection].code.coding.system ^definition = "セクション区分コードのコード体系を識別するURI。固定値。"
* section[compositionSection].section[researchParticipationSection].code.coding.code 1.. MS
* section[compositionSection].section[researchParticipationSection].code.coding.code = #830 (exactly)
* section[compositionSection].section[researchParticipationSection].code.coding.code ^short = "セクション区分のコード値"
* section[compositionSection].section[researchParticipationSection].code.coding.code ^definition = "セクション区分のコード値。\r\n固定値。"
* section[compositionSection].section[researchParticipationSection].code.coding.display = "臨床研究参加セクション" (exactly)
* section[compositionSection].section[researchParticipationSection].code.coding.display ^short = "セクション区分コードの表示名"
* section[compositionSection].section[researchParticipationSection].code.coding.display ^definition = "セクション区分コードの表示名。"
* section[compositionSection].section[researchParticipationSection].code.coding.display MS
* section[compositionSection].section[researchParticipationSection].code.coding.userSelected ..0
* section[compositionSection].section[researchParticipationSection].code.text ..0
* section[compositionSection].section[researchParticipationSection].text ^short = "このセクションに含められるすべてのテキスト（叙述的記述）表現"
* section[compositionSection].section[researchParticipationSection].text ^definition = "本セクションの内容をテキストで表現した文字列。内容を省略しても構わない。 このデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。"
* section[compositionSection].section[researchParticipationSection].text MS
* section[compositionSection].section[researchParticipationSection].text.status MS
* section[compositionSection].section[researchParticipationSection].text.status = #additional (exactly)
* section[compositionSection].section[researchParticipationSection].text.status ^short = "セクションの内容作成状態コード"
* section[compositionSection].section[researchParticipationSection].text.status ^definition = "generated | extensions | additional | empty　から　\"additional\" の固定値。このセクションに含められるすべてのentry要素による情報に加えて、それらで表現し尽くせていない情報も含めた完全な叙述表現であることを示す。"
* section[compositionSection].section[researchParticipationSection].text.div ^short = "xhtml簡略形式に従った叙述記述データ"
* section[compositionSection].section[researchParticipationSection].text.div ^definition = "本セクションの内容を xhtml 形式のテキストで表現した文字列。内容を省略しても構わない。 \r\nこのデータは人がこのセクションの内容の概略をひと目で把握するためだけに使われるものであり、データ処理対象としてはならない。\r\nテキストは構造化された情報から自動的にシステムが生成したものとし、それ以上に情報を追加してはならない。"
* section[compositionSection].section[researchParticipationSection].mode ..0
* section[compositionSection].section[researchParticipationSection].orderedBy ..0
* section[compositionSection].section[researchParticipationSection].entry 0..* MS
* section[compositionSection].section[researchParticipationSection].entry only Reference(JP_ResearchSubject)
* section[compositionSection].section[researchParticipationSection].entry ^short = "臨床研究参加情報を記述したDocumentReferenceリソースを参照"
* section[compositionSection].section[researchParticipationSection].entry ^definition = """臨床研究参加情報を記述して参照する。
                                                                1つの臨床研究参加情報をひとつのResearchSubjectリソースで記述されたものを参照する。
                                                                記述すべき臨床研究参加情報が特にないことを明示的に記述する（「特になし」など）場合にはentry要素は出現せず、emptyReasonに nilknown を記述する。
                                                                記述すべき情報が特にない場合であって、そのことを明示的に記述する必要もない場合には、このサブセクションを出現させない。
                                                                """
* section[compositionSection].section[researchParticipationSection].emptyReason ..1
* section[compositionSection].section[researchParticipationSection].section ..0
//