# flutter_bionime

flutter_bionime整合了每日一句以及口罩庫存查詢功能

## 每日一句
進入首頁後呼叫daily_repository取得每日一句資料。

* 使用[universal_html](https://github.com/dint-dev/universal_html)爬蟲取得[每日一句](https://tw.feature.appledaily.com/collection/dailyquote)網頁內容，
  封裝成[daily_repository](https://github.com/bar99037/daily_repository)套件。

## 口罩庫存查詢
進入首頁後如果本地資料庫沒有資料，呼叫pharmacies_repository取得口罩地圖資料並寫入資料庫，反之則回傳本地資料庫內的口罩地圖資料。

* 使用[dio](https://github.com/flutterchina/dio)取得[口罩地圖資料](https://raw.githubusercontent.com/kiang/pharmacies/master/json/points.json)，
封裝成[pharmacies_repository](https://github.com/bar99037/pharmacies_repository)套件
* 搭配[Hive NoSql](https://github.com/hivedb/hive)資料庫保存pharmacies_repository取得的data

## 畫面截圖
![Imgur](https://i.imgur.com/ZyPI839.jpg) ![Imgur](https://i.imgur.com/Z0kAEs0.jpg)

## 多國語系
多國語系功能使用[easy_localization](https://github.com/aissat/easy_localization)套件實作，可切換繁體中文、簡體中文、English語系3個選項

![](https://i.imgur.com/pDDDgTZ.gif)

## 側滑刪除
![](https://i.imgur.com/MbFGvFH.gif)
