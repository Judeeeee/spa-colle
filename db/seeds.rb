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
    { ward_id: chiyoda_ward_id, name: "RAKU SPA 1010 神田", latitude: 35.698137, longitude: 139.767935 },
    { ward_id: chuo_ward_id, name: "SPA&SAUNA コリドーの湯", latitude: 35.6706907, longitude: 139.7599611 },
    { ward_id: minato_ward_id, name: "テルマー湯 西麻布", latitude: 35.6608685, longitude: 139.7262187 },
    { ward_id: shinjuku_ward_id, name: "テルマー湯 新宿店", latitude: 35.694526, longitude: 139.7051388 },
    { ward_id: bunkyo_ward_id, name: "東京ドーム天然温泉 Spa LaQua", latitude: 35.7071868, longitude: 139.7529042 },
    { ward_id: taito_ward_id, name: "浅草ROXまつり湯", latitude: 35.7129856, longitude: 139.7926897 },
    { ward_id: sumida_ward_id, name: "両国湯屋江戸遊", latitude: 35.696865, longitude: 139.7984625 },
    { ward_id: koto_ward_id, name: "天然温泉 泉天空の湯 有明ガーデン", latitude: 35.6382832, longitude: 139.7915832 },
    { ward_id: shinagawa_ward_id, name: "おふろの王様 大井町店", latitude: 35.6057079, longitude: 139.7340746 },
    { ward_id: meguro_ward_id, name: "ぽかぽかランド鷹番の湯", latitude: 35.6298472, longitude: 139.6893677 },
    { ward_id: ota_ward_id, name: "天然温泉平和島", latitude: 35.5847386, longitude: 139.7408066 },
    { ward_id: setagaya_ward_id, name: "THE SPA 成城", latitude: 35.6536514, longitude: 139.6154008 },
    { ward_id: shibuya_ward_id, name: "改良湯", latitude: 35.6530753, longitude: 139.7095256 },
    { ward_id: nakano_ward_id, name: "たからゆ", latitude: 35.7201862, longitude: 139.6480499 },
    { ward_id: suginami_ward_id, name: "東京荻窪天然温泉 なごみの湯", latitude: 35.7048095, longitude: 139.6183619 },
    { ward_id: toshima_ward_id, name: "東京染井温泉 SAKURA", latitude: 35.7378558, longitude: 139.7391495 },
    { ward_id: kita_ward_id, name: "COCOFURO かが浴場", latitude: 35.7549577, longitude: 139.7318728 },
    { ward_id: arakawa_ward_id, name: "梅の湯", latitude: 35.746782, longitude: 139.7614943 },
    { ward_id: itabashi_ward_id, name: "前野原温泉 さやの湯処", latitude: 35.7707719, longitude: 139.692638 },
    { ward_id: nerima_ward_id, name: "バーデーと天然温泉豊島園 庭の湯", latitude: 35.7438303, longitude: 139.6481385 },
    { ward_id: adachi_ward_id, name: "大谷田温泉 明神の湯", latitude: 35.7781791, longitude: 139.8474426 },
    { ward_id: katsushika_ward_id, name: "東京天然温泉 古代の湯", latitude: 35.7289702, longitude: 139.8628131 },
    { ward_id: edogawa_ward_id, name: "スーパー銭湯 湯処葛西", latitude: 35.655788, longitude: 139.8816996 }
  ]

  facilities.each do |facility|
    Facility.find_or_create_by(facility)
  end
end
