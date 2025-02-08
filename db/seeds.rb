# 東京都内区市町村(島は除く)
wards = [
  { name: "千代田区", name_kana: "ちよだく" },
  { name: "中央区", name_kana: "ちゅうおうく" },
  { name: "港区", name_kana: "みなとく" },
  { name: "新宿区", name_kana: "しんじゅくく" },
  { name: "文京区", name_kana: "ぶんきょうく" },
  { name: "台東区", name_kana: "たいとうく" },
  { name: "墨田区", name_kana: "すみだく" },
  { name: "江東区", name_kana: "こうとうく" },
  { name: "品川区", name_kana: "しながわく" },
  { name: "目黒区", name_kana: "めぐろく" },
  { name: "大田区", name_kana: "おおたく" },
  { name: "世田谷区", name_kana: "せたがやく" },
  { name: "渋谷区", name_kana: "しぶやく" },
  { name: "中野区", name_kana: "なかのく" },
  { name: "杉並区", name_kana: "すぎなみく" },
  { name: "豊島区", name_kana: "としまく" },
  { name: "北区", name_kana: "きたく" },
  { name: "荒川区", name_kana: "あらかわく" },
  { name: "板橋区", name_kana: "いたばしく" },
  { name: "練馬区", name_kana: "ねりまく" },
  { name: "足立区", name_kana: "あだちく" },
  { name: "葛飾区", name_kana: "かつしかく" },
  { name: "江戸川区", name_kana: "えどがわく" },
  { name: "八王子市", name_kana: "はちおうじし" },
  { name: "立川市", name_kana: "たちかわし" },
  { name: "武蔵野市", name_kana: "むさしのし" },
  { name: "三鷹市", name_kana: "みたかし" },
  { name: "青梅市", name_kana: "おうめし" },
  { name: "府中市", name_kana: "ふちゅうし" },
  { name: "昭島市", name_kana: "あきしまし" },
  { name: "調布市", name_kana: "ちょうふし" },
  { name: "町田市", name_kana: "まちだし" },
  { name: "小金井市", name_kana: "こがねいし" },
  { name: "小平市", name_kana: "こだいらし" },
  { name: "日野市", name_kana: "ひのし" },
  { name: "東村山市", name_kana: "ひがしむらやまし" },
  { name: "国分寺市", name_kana: "こくぶんじし" },
  { name: "国立市", name_kana: "くにたちし" },
  { name: "福生市", name_kana: "ふっさし" },
  { name: "狛江市", name_kana: "こまえし" },
  { name: "東大和市", name_kana: "ひがしやまとし" },
  { name: "清瀬市", name_kana: "きよせし" },
  { name: "東久留米市", name_kana: "ひがしくるめし" },
  { name: "武蔵村山市", name_kana: "むさしむらやまし" },
  { name: "多摩市", name_kana: "たまし" },
  { name: "稲城市", name_kana: "いなぎし" },
  { name: "羽村市", name_kana: "はむらし" },
  { name: "あきる野市", name_kana: "あきるのし" },
  { name: "西東京市", name_kana: "にしとうきょうし" },
  { name: "瑞穂町", name_kana: "みずほまち" },
  { name: "日の出町", name_kana: "ひのでまち" },
  { name: "檜原村", name_kana: "ひのはらむら" },
  { name: "奥多摩町", name_kana: "おくたままち" }
]

wards.each do |ward|
  Ward.find_or_create_by(ward)
end

# ローカルでの動作確認用に追加。後で全施設データを追記する。
if Rails.env.development?
  ward_id = Ward.find_by(name_kana: "としまく")&.id
  facilities = [
    { ward_id: ward_id, name: "タイムズ スパ・レスタ", latitude: 35.7291021729063, longitude: 139.71728243905798 },
    { ward_id: ward_id, name: "東京染井温泉 SAKURA", latitude: 35.73819540617037, longitude: 139.7393533446155 },
    { ward_id: ward_id, name: "五色湯", latitude: 35.725042790625494, longitude: 139.6959867355208 }
  ]

  facilities.each do |facility|
    Facility.find_or_create_by(facility)
  end
end
