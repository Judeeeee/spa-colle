unless Rails.env.test?
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
    { name: "大田区", name_kana: "おおたく" },
    { name: "世田谷区", name_kana: "せたがやく" },
    { name: "杉並区", name_kana: "すぎなみく" },
    { name: "豊島区", name_kana: "としまく" },
    { name: "北区", name_kana: "きたく" },
    { name: "板橋区", name_kana: "いたばしく" },
    { name: "練馬区", name_kana: "ねりまく" },
    { name: "足立区", name_kana: "あだちく" },
    { name: "葛飾区", name_kana: "かつしかく" },
    { name: "江戸川区", name_kana: "えどがわく" }
  ]

  wards.each do |ward|
    Ward.find_or_create_by(ward)
  end

  chiyoda_ward_id = Ward.find_by(name_kana: "ちよだく")&.id
  chuo_ward_id = Ward.find_by(name_kana: "ちゅうおうく")&.id
  minato_ward_id = Ward.find_by(name_kana: "みなとく")&.id
  shinjuku_ward_id = Ward.find_by(name_kana: "しんじゅくく")&.id
  bunkyo_ward_id = Ward.find_by(name_kana: "ぶんきょうく")&.id
  taito_ward_id = Ward.find_by(name_kana: "たいとうく")&.id
  sumida_ward_id = Ward.find_by(name_kana: "すみだく")&.id
  koto_ward_id = Ward.find_by(name_kana: "こうとうく")&.id
  shinagawa_ward_id = Ward.find_by(name_kana: "しながわく")&.id
  ota_ward_id = Ward.find_by(name_kana: "おおたく")&.id
  setagaya_ward_id = Ward.find_by(name_kana: "せたがやく")&.id
  suginami_ward_id = Ward.find_by(name_kana: "すぎなみく")&.id
  toshima_ward_id = Ward.find_by(name_kana: "としまく")&.id
  kita_ward_id = Ward.find_by(name_kana: "きたく")&.id
  itabashi_ward_id = Ward.find_by(name_kana: "いたばしく")&.id
  nerima_ward_id = Ward.find_by(name_kana: "ねりまく")&.id
  adachi_ward_id = Ward.find_by(name_kana: "あだちく")&.id
  katsushika_ward_id = Ward.find_by(name_kana: "かつしかく")&.id
  edogawa_ward_id = Ward.find_by(name_kana: "えどがわく")&.id

  facilities = [
    { ward_id: chiyoda_ward_id, name: "RAKU SPA 1010 神田", latitude: 35.698137, longitude: 139.767935 },
    { ward_id: chuo_ward_id, name: "SPA&SAUNA コリドーの湯", latitude: 35.6706907, longitude: 139.7599611 },
    { ward_id: chuo_ward_id, name: "HAMANOYUえど遊", latitude: 35.6844136, longitude: 139.7903575 },
    { ward_id: minato_ward_id, name: "テルマー湯 西麻布", latitude: 35.6608685, longitude: 139.7262187 },
    { ward_id: minato_ward_id, name: "アダムアンドイブ", latitude: 35.6567345, longitude: 139.7266524 },
    { ward_id: shinjuku_ward_id, name: "テルマー湯 新宿店", latitude: 35.694526, longitude: 139.7051388 },
    { ward_id: shinjuku_ward_id, name: "SOLA SPA新宿", latitude: 35.6959885, longitude: 139.7014923 },
    { ward_id: shinjuku_ward_id, name: "TOTOPA 都立明治公園店", latitude: 35.6746805, longitude: 139.7129305 },
    { ward_id: bunkyo_ward_id, name: "東京ドーム天然温泉 Spa LaQua", latitude: 35.7071868, longitude: 139.7529042 },
    { ward_id: taito_ward_id, name: "浅草ROXまつり湯", latitude: 35.7129856, longitude: 139.7926897 },
    { ward_id: sumida_ward_id, name: "両国湯屋江戸遊", latitude: 35.696865, longitude: 139.7984625 },
    { ward_id: koto_ward_id, name: "天然温泉 泉天空の湯 有明ガーデン", latitude: 35.6382832, longitude: 139.7915832 },
    { ward_id: koto_ward_id, name: "東京豊洲 万葉俱楽部", latitude: 35.6461872, longitude: 139.7831588 },
    { ward_id: shinagawa_ward_id, name: "おふろの王様 大井町店", latitude: 35.6057079, longitude: 139.7340746 },
    { ward_id: ota_ward_id, name: "天然温泉平和島", latitude: 35.5847386, longitude: 139.7408066 },
    { ward_id: ota_ward_id, name: "SPA&HOTEL和", latitude: 35.5637941, longitude: 139.7156378 },
    { ward_id: ota_ward_id, name: "天然温泉 泉天空の湯 羽田空港", latitude: 35.5434277, longitude: 139.7662127 },
    { ward_id: setagaya_ward_id, name: "THE SPA 成城", latitude: 35.6536514, longitude: 139.6154008 },
    { ward_id: suginami_ward_id, name: "東京荻窪天然温泉 なごみの湯", latitude: 35.7048095, longitude: 139.6183619 },
    { ward_id: suginami_ward_id, name: "高井戸天然温泉 美しの湯", latitude: 35.6845403, longitude: 139.6150727 },
    { ward_id: toshima_ward_id, name: "東京染井温泉 SAKURA", latitude: 35.7378558, longitude: 139.7391495 },
    { ward_id: toshima_ward_id, name: "タイムズ スパ・レスタ", latitude: 35.7289193, longitude: 139.7173039 },
    { ward_id: itabashi_ward_id, name: "前野原温泉 さやの湯処", latitude: 35.7707719, longitude: 139.692638 },
    { ward_id: nerima_ward_id, name: "バーデーと天然温泉豊島園 庭の湯", latitude: 35.7438303, longitude: 139.6481385 },
    { ward_id: adachi_ward_id, name: "大谷田温泉 明神の湯", latitude: 35.7781791, longitude: 139.8474426 },
    { ward_id: adachi_ward_id, name: "THE SPA 西新井", latitude: 35.7749066, longitude: 139.7898982 },
    { ward_id: katsushika_ward_id, name: "東京天然温泉 古代の湯", latitude: 35.7289702, longitude: 139.8628131 },
    { ward_id: edogawa_ward_id, name: "スーパー銭湯 湯処葛西", latitude: 35.655788, longitude: 139.8816996 },
    { ward_id: kita_ward_id, name: "ROSCO", latitude: 35.7382025, longitude: 139.7493614 }
  ]

  facilities.each do |facility|
    Facility.find_or_create_by(facility)
  end
end
