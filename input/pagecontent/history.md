<style type="text/css">

table {
  border: solid 1px black;
  border-collapse: collapse;
}
 
table td {
  border: solid 1px black;

}

table th {
  border: solid 1px black;
}
   h1 {
      counter-reset: chapter;
    }

    h2 {
      counter-reset: sub-chapter;
    }

    h3 {
      counter-reset: section;
    }

    h4 {
      counter-reset: sub-section;
    }

    h5 {
      counter-reset: composite;
    }

    h6 {
      counter-reset: sub-composite;
    }

    h1:before {
      color: black;
      counter-increment: bchapter;
      content:  " ";
    }

    h2:before {
      color: black;
      counter-increment: chapter;
      content: counter(chapter) ". ";
    }

    h3:before {
      color: black;
      counter-increment: sub-chapter;
      content: counter(chapter) "."counter(sub-chapter) ". ";
    }


    h4:before {
      color: black;
      counter-increment: section;
      content: counter(chapter) "."counter(sub-chapter) "."counter(section) " ";
    }

    h5:before {
      color: black;
      counter-increment: sub-section;
      content: counter(chapter) "."counter(sub-chapter) "."counter(section) "."counter(sub-section) " ";
    }

    h6:before {
      color: black;
      counter-increment: sub-sub-section;
      content: "　　"counter(sub-sub-section) "）";
    }

</style>

# 改訂履歴　（新しい順）

## 2024.02.29	Ver. 1.1.6
  - BundleのプロファイルをValidation時のエラーに対応するよう記述修正（仕様の変更はなし）。
  - 電子カルテ情報共有サービスの6情報仕様と共通するリソースについて、プロファイル記述を共通化（仕様の変更はなし）。

## 2024.02.12	Ver. 1.1.5
  - 仕様をPDF版（およびそれのHTML版）を参照する記載方式に変更。
  - 電子カルテ情報共有サービスの6情報仕様と共通するリソースについて仕様を6情報仕様を参照する方式に変更。

