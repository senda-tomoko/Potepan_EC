# CircleCIの設定

ここでは、CircleCI上でのRSpec・Rubocopの実行、及びHerokuへの自動デプロイの設定を進めていきます。<br>
CircleCIとの連携後、以下のようなフローで最終課題を提出することになりますので、まずはそのイメージだけでも掴んでおいてください。

1. ローカル環境での実装内容をcommitする
2. Github上のリモートリポジトリへpushする
3. PRを作成する（※PRを作成済みであれば、pushするだけでCIが動きます）
4. RSpec・RubocopがCircleCI上で実行される
5. RSpec・Rubocopともに問題なければ、最新のコードがHeroku上へデプロイされる

## GitHubと連携してみよう

まずは、GitHubとCircleCIを連携させていきましょう。

[サインアップページ](https://circleci.com/signup/)にアクセスし、`Sign up`をクリックしてください。

![サインアップページ](https://res.cloudinary.com/he3zvdcui/image/upload/v1697594545/CircleCi/01_siginup_nugbto.png)

以下のような画面に遷移しますので、「No, I'm setting up CircleCI for my team」の方を選択してください。

![サインアップページ](https://res.cloudinary.com/he3zvdcui/image/upload/v1701745121/CircleCi/02_siginup_form_rcex5o.png)

フォーム画面に遷移しますので、任意のメールアドレスとパスワードを設定してください。
（※Githubで使用しているものと同一のメールアドレスをお勧めします。）

![サインアップフォーム](https://res.cloudinary.com/he3zvdcui/image/upload/v1697594545/CircleCi/02_siginup_form_t99xcg.png)

無事登録できれば、続いては簡単なアンケートページに遷移しますので、それぞれ以下の通りご回答ください。

![アンケート](https://res.cloudinary.com/he3zvdcui/image/upload/v1701745233/CircleCi/03_welcome_eak1n6.png)

`Let's Go`ボタンをクリックすると、リポジトリサービスとの連携画面に遷移します。
ここでは特に手続きは行いませんので、[アカウント設定ページ](https://app.circleci.com/settings/user/account)にアクセスしてください。

以下のような画面が表示されると思います。

![アカウント設定](https://res.cloudinary.com/he3zvdcui/image/upload/v1701745617/CircleCi/04_user_setting_jc1nwy.png)

「Bitbucket」の上下に「Github」の項目が表示されていれば、そのセクションの「Connect」をクリックしてください。<br>
「Github」の項目が表示されていなければ、「Refresh permissions」ボタンをクリックした後、ページ下部のリンク（「Received instructions ... Click to be redirected」）をクリックしてください。<br>
「Confirm OAuth App Authorization」というモーダルが表示されますので、「Authorize with OAuth」ボタンをクリックしてください。

![OAuth認証](https://res.cloudinary.com/he3zvdcui/image/upload/v1701746633/CircleCi/05_authorize_with_oauth_bumdpi.png)

しばらくすると以下のようなCircleCIの認証画面に遷移しますので、`Authorize circleci`ボタンをクリックしてください。

![CircleCIの認証](https://res.cloudinary.com/he3zvdcui/image/upload/v1697594544/CircleCi/05_authorize_circleci_skg9ks.png)

認証が完了すると以下のようなモーダルが表示されますので、「Select Organization」で`potepancamp`を、「Select Repository」でご自身のリポジトリを選択し、「Set Up Project」ボタンをクリックしてください。

![組織を選択する](https://res.cloudinary.com/he3zvdcui/image/upload/v1701746787/CircleCi/06_select_an_organization_cpbmtt.png)

サインアップ後、画面左上のドロップダウンメニューをクリックしてください。

![CircleCI ホーム画面](../images/CI/03_home.png)

以下の画像の通り、ご自身のユーザー（ここでは`potepan-dev`）とポテパンキャンプの２つが表示されていれば、サインアップは完了です。

![CircleCI ホーム画面](../images/CI/04_home.png)

続いて、サイドバーの「Projects」メニューをクリックしてください。<br>
ご自身のリポジトリ名のプロジェクトが表示されていると思いますので、そちらをクリックしてください。<br>
設定が問題なく完了していると、以下のようにCircleCI上でCIが動き始めます。

![CircleCI Start Building](../images/CI/07_start-building.png)

しばらくすると、CIの実行結果が画面上で確認できるようになります。
（※この時点では設定が足りていないため、失敗していても問題ありません。）

![CircleCI Build Failed](../images/CI/08_build-failed.png)

また、Github上でPull Requestを作成することで、自動的にCircleCI上でCIが実行されるようにもなっています。

![CircleCI On Pull Request](../images/CI/09_on-pull-request.png)

こちらでCircleCI上でRSpec・Rubocopを実行できるようになりましたので、続いて、CircleCIとHerokuの連携を進めていきましょう。

<br>

## Herokuと連携してみよう

### 事前準備

CircleCIからHerokuへ自動でデプロイする前に、まずはローカル環境からHeroku CLIを使って手動でデプロイできるようにしておく必要があります。<br>
手動デプロイの手順は、[ローカルからHerokuにデプロイする設定](../deploy/heroku.md)にてご説明していますので、まだご覧になっていない方はこちらを先に完了させておいてください。

### Herokuとの連携の流れ

ここではCirckeCIでテストが通った後、自動的にHerokuにデプロイするための設定を行います。

まずCircleCIにHerokuの認証情報を追加しましょう。

HerokuのWebページにログインし、右上の自分のアイコンから`Account settings`を選択してください。

![heroku personal](../images/CI/10_heroku_personal.png)

`API Key`セクションにある`Reveal`ボタンをクリックすると表示されるトークンをコピーしておきます。

![heroku apu key](../images/CI/11_heroku_api_key.png)

続いて、CircleCI上でPipelines画面の右上にある歯車アイコンをクリックしてください。

![CircleCI Project Settings](../images/CI/12_project-setting.png)

左メニューから`Environment Variable`を選択し、`Add Variables`ボタンをクリックするとポップアップが表示されます。

`Name`に`HEROKU_API_KEY`、`Value`に先ほどコピーしたHerokuのAPI Keyを入力し、`Add Variable`をクリックしてください。

![circleci_env_var](../images/CI/13_circleci_env_var.png)

次に、[ローカルからHerokuにデプロイする設定](../deploy/heroku.md)で取得したHerokuアプリ名とAWSの認証情報を追加していきます。

先ほどと同様にして、CircleCIの歯車アイコンから`Add Variables`を選択し、`HEROKU_APP_NAME`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`、という名前でそれぞれ環境変数を追加してください。

以上で設定は完了です!

これでCircleCIからHerokuにデプロイする準備が整いました。
