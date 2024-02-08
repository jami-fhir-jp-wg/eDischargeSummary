// 医療文書区分コード
CodeSystem:  JP_codeSystem_documentTypeCode
Id:   jp-codeSystem-documentTypeCode
Description: "FHIR文書の文書区分（医療文書全般）"
* ^url = "http://jpfhir.jp/fhir/Common/CodeSystem/doc-typecodes"
// * ^valueSet = "http://jpfhir.jp/fhir/Common/ValueSet/doc-typecodes"
* ^title = "FHIR文書の文書区分（医療文書全般）"
* ^status = #active
* ^experimental = false
* ^content = #complete
* ^caseSensitive = false
* #JPGCHKUP01 "健診結果報告書"
* #JPMCHKUP01 "自治体検診結果報告書"
* #18842-5 "退院時サマリー"
* #57133-1 "診療情報提供書"
* #57833-6 "処方箋"

// 退院時サマリーセクション区分コード
CodeSystem: JP_codeSystem_eDischargeSummary_document_section
Id: jp-codeSystem-eDischargeSummary-document-section
Description: "サマリー情報用セクション区分コード　診療情報用を含む"
* ^url = "http://jpfhir.jp/fhir/eDischargeSummary/CodeSystem/document-section"
* ^title = "サマリー情報用セクション区分コード"
* ^status = #active
* ^experimental = false
* ^content = #complete
* ^caseSensitive = false
* #200	"CDA参照セクション" //  cdaSection
* #210	"添付情報セクション"    //  attachmentSection
* #220	"備考・連絡情報セクション"  //  remarksCommunicatonSection
* #230  "PDFセクション" // pdfSection
* #300	"構造情報セクション"    //  compositionSection
* #312  "入院理由セクション"    // reasonForAdmissionSection
* #322  "入院時詳細セクション"  // detailsOnAdmissionSection
* #324  "退院時詳細セクション"  // diagnosesOnDischargeSection
* #330	"臨床経過セクション"    // clinicalCourseSection
* #333  "入院中経過セクション"  // hospitalCourseSection
* #340	"傷病名・主訴セクション"    //  problemSection
* #342  "入院時診断セクション"  // diagnosesOnAdmissionSection
* #344  "退院時診断セクション"  // diagnosesOnDischargeSection
* #352  "主訴セクション"    //  chiefComplaintsSection
* #360	"現病歴セクション"  //  presentIllnessSection
* #362  "現病歴セクション"  // presentIllnessSection
* #370	"既往歴セクション"  //  pastIllnessSection
* #372  "既往歴セクション"  // pastIllnessSection 入院時既往歴
* #410	"事前指示セクション"    //  advanceDirectiveSection
* #420	"診療方針指示セクション"    //  clinicalInstructionSection
* #424  "退院時方針指示セクション"  // instructionOnDischargeSection
* #430	"投薬指示セクション"    //  medicationSection
* #432  "入院時服薬セクション"  // medicationsOnAdmissionSection
* #444  "退院時投薬指示セクション"  // medicationOnDischargeSection
* #510	"アレルギー・不耐性反応セクション"  //  allergiesIIntoleranceSection
* #520	"感染症情報セクション"  //  infectionInformationSection
* #530	"予防接種歴セクション"  //  immunizationSection
* #550	"家族歴セクション"     //   familiyHistorySection
* #552  "家族歴セクション"  //  familiyHistorySection 入院時情報・退院時サマリー
* #610	"身体所見セクション"    //  physicalStatusSection
* #612  "入院時身体所見セクション"  // physicalStatusOnAdmissionSection
* #614  "退院時身体所見セクション"  // physicalStatusOnDischargeSection
* #620	"検査結果セクション"    //  studySection
* #623  "入院中検査結果セクション"  //  hospitalStudySection
* #640	"社会歴・生活習慣セクション"    //  socialHistorySection
* #642  "社会歴・生活習慣セクション"    // socialHistorySection 入院時情報・退院時サマリー
* #713  "入院中治療セクション"  // hospitalProcedureSection
* #720	"処置セクション"    //  procedureSection
* #730	"手術セクション"    //  surgicalProcedureSection
* #740	"輸血歴セクション"  //  bloodInfustionHistorySection
* #810	"医療機器セクション"    //  medicalDeviceSection
* #830	"臨床研究参加セクション"    //  researchParticipationSection
* #910	"紹介先情報セクション"  //  referralToSection
* #920	"紹介元情報セクション"  //  referralFromSection
* #950	"紹介目的セクション"    //  referralPurposeSection

// 退院時サマリー 入院経路
CodeSystem: JP_codeSystem_eDischargeSummary_admitSource
Id: jp-codeSystem-eDischargeSummary-admitSource
Description: "入院経路コード　出典：厚労省DPC導入影響評価調査）"
* ^url = "http://jpfhir.jp/fhir/Common/CodeSystem/admit-Source"
* ^title = "入院経路コード　出典：厚労省DPC導入影響評価調査）"
* ^status = #active
* ^experimental = false
* ^content = #complete
* ^caseSensitive = false
* #0    "院内の他病棟からの転棟" 
* #1    "家庭からの入院"
* #4    "他の病院・診療所の病棟からの転院"
* #5    "介護施設・福祉施設に入所中"
* #8    "院内で出生"
* #9    "その他"

// 退院時サマリー 退院時転帰コード情報
CodeSystem: JP_codeSystem_eDischargeSummary_dischargeDisposition
Id: jp-codeSystem-eDischargeSummary-dischargeDisposition
Description: "退院時転帰コード情報　出典：厚労省DPC導入影響評価調査"
* ^url = "http://jpfhir.jp/fhir/Common/CodeSystem/discharge-disposition"
* ^title = "退院時転帰コード情報　出典：厚労省DPC導入影響評価調査）"
* ^status = #active
* ^experimental = false
* ^content = #complete
* ^caseSensitive = false
* #1    "傷病が治癒・軽快"
* #3    "傷病（白血病、潰瘍性大腸炎、クローン病等）が寛解"
* #4    "傷病が不変"
* #5    "傷病が増悪"
* #6    "傷病による死亡"
* #7    "傷病以外による死亡"
* #9    "その他（検査入院,正常分娩及び人間ドック含む）"


