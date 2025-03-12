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

# スタンプカードを表示させるために、東京23区の施設データを作成した
if Rails.env.development?
  chiyoda_ward_id = Ward.find_by(name_kana: "ちよだく")&.id
  chuo_ward_id = Ward.find_by(name_kana: "ちゅうおうく")&.id
  minato_ward_id = Ward.find_by(name_kana: "みなとく")&.id
  shinjuku_ward_id = Ward.find_by(name_kana: "しんじゅくく")&.id
  bunkyo_ward_id = Ward.find_by(name_kana: "ぶんきょうく")&.id
  taito_ward_id = Ward.find_by(name_kana: "たいとうく")&.id
  sumida_ward_id = Ward.find_by(name_kana: "すみだく")&.id
  koto_ward_id = Ward.find_by(name_kana: "こうとうく")&.id
  shinagawa_ward_id = Ward.find_by(name_kana: "しながわく")&.id
  meguro_ward_id = Ward.find_by(name_kana: "めぐろく")&.id
  ota_ward_id = Ward.find_by(name_kana: "おおたく")&.id
  setagaya_ward_id = Ward.find_by(name_kana: "せたがやく")&.id
  shibuya_ward_id = Ward.find_by(name_kana: "しぶやく")&.id
  nakano_ward_id = Ward.find_by(name_kana: "なかのく")&.id
  suginami_ward_id = Ward.find_by(name_kana: "すぎなみく")&.id
  toshima_ward_id = Ward.find_by(name_kana: "としまく")&.id
  kita_ward_id = Ward.find_by(name_kana: "きたく")&.id
  arakawa_ward_id = Ward.find_by(name_kana: "あらかわく")&.id
  itabashi_ward_id = Ward.find_by(name_kana: "いたばしく")&.id
  nerima_ward_id = Ward.find_by(name_kana: "ねりまく")&.id
  adachi_ward_id = Ward.find_by(name_kana: "あだちく")&.id
  katsushika_ward_id = Ward.find_by(name_kana: "かつしかく")&.id
  edogawa_ward_id = Ward.find_by(name_kana: "えどがわく")&.id

  facilities = [
    { ward_id: chiyoda_ward_id, name: "RAKU SPA 1010 神田", latitude: 35.6982851705848, longitude: 139.768004715329 },
    { ward_id: chuo_ward_id, name: "SPA&SAUNA コリドーの湯", latitude: 35.6709187123538, longitude: 139.760016164591 },
    { ward_id: minato_ward_id, name: "テルマー湯 西麻布", latitude: 35.661286475671, longitude: 139.72626156221 },
    { ward_id: shinjuku_ward_id, name: "テルマー湯 新宿店", latitude: 35.6952574759223, longitude: 139.705181662232 },
    { ward_id: bunkyo_ward_id, name: "東京ドーム天然温泉 Spa LaQua", latitude: 35.7074133097408, longitude: 139.752968573011 },
    { ward_id: taito_ward_id, name: "浅草ROXまつり湯", latitude: 35.7135775268661, longitude: 139.792732562244 },
    { ward_id: sumida_ward_id, name: "両国湯屋江戸遊", latitude: 35.6970489774558, longitude: 139.798422459116 },
    { ward_id: koto_ward_id, name: "天然温泉 泉天空の湯 有明ガーデン", latitude: 35.638945437041, longitude: 139.791583146854 },
    { ward_id: shinagawa_ward_id, name: "おふろの王様 大井町店", latitude: 35.6063355154929, longitude: 139.734160377515 },
    { ward_id: meguro_ward_id, name: "ぽかぽかランド鷹番の湯", latitude: 35.6303699821452, longitude: 139.689281816167 },
    { ward_id: ota_ward_id, name: "天然温泉平和島", latitude: 35.5849218308351, longitude: 139.740860244176 },
    { ward_id: setagaya_ward_id, name: "THE SPA 成城", latitude: 35.6544878633176, longitude: 139.615314916182 },
    { ward_id: shibuya_ward_id, name: "改良湯", latitude: 35.6531363248245, longitude: 139.709600701846 },
    { ward_id: nakano_ward_id, name: "たからゆ", latitude: 35.720812915056, longitude: 139.64813567759 },
    { ward_id: suginami_ward_id, name: "東京荻窪天然温泉 なごみの湯", latitude: 35.7054363361477, longitude: 139.618361846898 },
    { ward_id: toshima_ward_id, name: "東京染井温泉 SAKURA", latitude: 35.7386565457399, longitude: 139.739406938965 },
    { ward_id: kita_ward_id, name: "COCOFURO かが浴場", latitude: 35.7554448348128, longitude: 139.732001492954 },
    { ward_id: arakawa_ward_id, name: "梅の湯", latitude: 35.7475826558676, longitude: 139.761408416244 },
    { ward_id: itabashi_ward_id, name: "前野原温泉 さやの湯処", latitude: 35.7716071337583, longitude: 139.692766692964 },
    { ward_id: nerima_ward_id, name: "バーデーと天然温泉豊島園 庭の湯", latitude: 35.7439957502884, longitude: 139.648235059517 },
    { ward_id: adachi_ward_id, name: "大谷田温泉 明神の湯", latitude: 35.7787705415821, longitude: 139.847657123651 },
    { ward_id: katsushika_ward_id, name: "東京天然温泉 古代の湯", latitude: 35.7294226561583, longitude: 139.862684300891 },
    { ward_id: edogawa_ward_id, name: "スーパー銭湯 湯処葛西", latitude: 35.6565547013037, longitude: 139.881828292888 }
  ]

  facilities.each do |facility|
    Facility.find_or_create_by(facility)
  end
end
