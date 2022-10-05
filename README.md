# nagano_cakeとは
長野県にある小さな洋菓子店「ながのCAKE」の商品を通販するためのECサイトです。


# アプリケーションの詳細な説明・実装機能について
* 注文に応じて製作する受注生産型
* 1日の受注量に制限は設けていない
* 送料は1配送につき全国一律800円
* 本来は軽減税率により宅配物は税率8%だが、今回は10%で統一している
* 友人や家族へのプレゼントなど、注文者の住所以外にも商品の発送が可能
* 支払方法はクレジットカード、銀行振込から選択可能


### １.用語の定義
<table>
 <thead>
  <tr>
   <th>用語</th>
   <th>意味</th>
  </tr>
 <thead>
 
 <tbody>
  <tr>
   <td>顧客</td>
   <td>ながのCAKEの商品を購入する人（客）</td>
  </tr>
  
  <tr>
   <td>会員</td>
   <td>ECサイトにユーザ登録している顧客</td>
  </tr>
  
  <tr>
   <td>ECサイト</td>
   <td>顧客が利用するサイト</td>
  </tr>
  
  <tr>
   <td>管理サイト</td>
   <td>店で働く事務員・パティシエ等が利用するサイト（管理者用サイト）</td>
  </tr>
  
  <tr>
   <td>注文ステータス</td>
   <td>注文の状態遷移を表す（後述）</td>
  </tr>
  
  <tr>
   <td>製作ステータス</td>
   <td>注文に紐付く注文商品の状態遷移を表す（後述）</td>
  </tr>
  
　　　　<tr>
   <td>販売ステータス</td>
   <td>
    商品の販売状況を表す</br>
    販売中、販売停止中の2パターンがある</br>
    販売停止中の商品はECサイト上「売切れ」と表示される
   </td>
  </tr>
  
  <tr>
   <td>会員ステータス</td>
   <td>有効・退会の2パターンがある</td>
  </tr>
  
  <tr>
   <td>ジャンル</td>
   <td>
    商品の種類</br>
    現状、ケーキ、プリン、焼き菓子、キャンディの4ジャンルがある
   </td>
  </tr>
  
  <tr>
   <td>注文個数</td>
   <td>
    1回の注文に紐付く注文個数の合計</br>
    例）商品Aを3個、商品Bを2個注文→注文個数は5個
   </td>
  </tr>
  
  <tr>
   <td>商品小計</td>
   <td>
    商品単価（税込）×個数</br>
    例）1,200円（税込）の商品を2個購入＝商品小計は2,400円　
   </td>
  </tr>
 </tbody>
</table>


### ２.各種ステータス
<table>
 <thead>
  <tr>
   <th>ステータス名</th>
   <th>用途</th>
   <th>ステータス</th>
   <th>設定タイミング</th>
  </tr>
 </thead>
 
 <tbody>
  <tr>
   <td rowspan=5>注文ステータス</td>
   <td rowspan=5>注文状況を表す</br>
   会員の購入履歴にも表示する</td>
   <td>入金待ち</td>
   <td>注文時にデフォルトで設定される</td>
  </tr>
  
  <tr>
   <td>入金確認</td>
   <td>管理者側が入金を確認したら更新する</td>
  </tr>
  
  <tr>
   <td>製作中</td>
   <td>紐づく注文商品の製作ステータスが</br>
   1つでも「製作中」になったら自動更新</td>
  </tr>
  
  <tr>
   <td>発送準備中</td>
   <td>紐づく注文商品の製作ステータスが</br>
   全て「製作完了」になったら自動更新</td>
  </tr>
  
  <tr>
   <td>発送済み</td>
   <td>管理者側が発送完了時に更新する</td>
  </tr>
  
  <tr>
   <td rowspan=4>製作ステータス</td>
   <td rowspan=4>各商品の製作状況を表す</br>
   管理者側でのみ使用する</td>
   <td>着手不可</td>
   <td>注文時にデフォルトで設定される</td>
  </tr>
  
  <tr>
   <td>製作待ち</td>
   <td>紐づく注文ステータスが</br>
   「入金確認」になったら自動更新</td>
  </tr>
  
  <tr>
   <td>製作中</td>
   <td>製作着手する際に管理者側が更新する</td>
  </tr>
  
  <tr>
   <td>製作完了</td>
   <td>製作が完了した際に管理者側が更新する</td>
  </tr>
 </tbody>
</table>


### ３.会員側実装機能
* 顧客は会員登録、ログイン・ログアウト、退会ができる
* 会員のログインはメールアドレスとパスワードで行える
* 会員がログインしている場合、ページのヘッダーにユーザ名が表示される
* サイトの閲覧はログインなしで行える
* 商品をカートに入れ、1度に複数種類、複数商品の購入ができる</br>
また、カート内の商品は個数変更・削除が可能
* カートへの商品追加はログインなしでは行えない
* クレジットカード情報はシステム上保持しない
* 会員は配送先の複数登録が可能

* 会員はマイページから下記が行える
  * ユーザ情報の閲覧・編集
  * 注文履歴の閲覧
  * 配送先の閲覧・編集
  
* 注文履歴一覧には下記の情報が表示される
  * 注文日
  * 配送先
  * 支払金額（商品合計＋送料）
  * 注文ステータス

* 注文履歴詳細には下記の情報が表示される
  * 注文日
  * 配送先
  * 支払方法
  * 注文ステータス
  * 商品の注文内容詳細（商品名、単価、個数、小計）
  * 請求情報（商品合計、送料、支払金額）

* 会員登録時、下記の情報をユーザ情報として入力できる
  * 名前（姓・名）
  * 名前（カナ姓・カナ名）
  * 郵便番号
  * 住所
  * 電話番号
  * メールアドレス
  * パスワード

* 商品は税込価格で表示される（税率10%）


### ４.管理者側(店側)実装機能
* 管理者用メールアドレスとパスワードでログインできる
* 商品について、下記が行える
  * 新規追加、編集、閲覧
  * 販売停止（売切れ表示）

* 商品情報は下記項目を保持
  * 商品名
  * 商品説明文
  * ジャンル
  * 税抜価格
  * 商品画像
  * 販売ステータス

* 会員登録されているユーザ情報の閲覧、編集、退会処理が行える
* ユーザの注文履歴が一覧・詳細表示でき、下記の情報が表示される

  【注文履歴一覧】
  * 購入日時
  * 購入者
  * 注文個数
  * 注文ステータス
  
  【注文履歴詳細】
  * 購入者
  * 注文日
  * 配送先
  * 支払方法
  * 料金（商品合計、送料、請求金額合計）
  * 注文ステータス
  * 各注文商品詳細（商品名、単価(税込)、数量、小計）
  * 各注文商品の製作ステータス

* 注文ごとに注文ステータスの更新、注文商品ごとに製作ステータスの更新ができる


# 開発環境
cloud9

# 使用について
### 【顧客側】
* ログインなしで下記ページは閲覧可能
  * トップページ
  * Aboutページ
  * 商品一覧ページ
  * 商品詳細ページ（商品のカート追加には会員登録が必要）

* 会員登録、ログインを行う
* 商品を閲覧し、カートに入れる
* 注文情報を選択・確認し、注文を確定する

### 【管理者側】
* ECサイトのトップページのURLに「/admin/sign_in」を付け足し、管理者用のログインページへ移動する
* 下記情報でログインする（nagano_cake/db/seeds.rbに記述）
　　　　　*　email: kannri@k.jp
　　　　　*　password: kannripass

* 商品一覧ページ右上の「＋」ボタンを押下すると、商品新規登録ページへ画面遷移する
* 商品登録後は、登録商品の詳細ページへ遷移する
* 登録した商品はサイトトップページの新着商品と商品一覧へ追加される
* 顧客側で注文すると、管理者側の注文履歴一覧に注文が追加される
* 入金確認後、注文履歴詳細ページにて注文ステータスを「入金確認」に更新する
* 注文履歴詳細ページにて、製作ステータスを注文商品の製作着手時に「製作中」、製作完了時は「製作完了」に更新する
* 会員一覧→会員詳細ページにて、顧客情報の編集や会員ステータスの切替が可能

# 作成者
高屋未来（https://github.com/mikitakaya）
