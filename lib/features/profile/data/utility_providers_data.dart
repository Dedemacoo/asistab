/// Türkiye'nin 81 ili için su, elektrik ve doğalgaz dağıtım şirketleri veritabanı.
/// Kaynak: EPDK, İSKİ, Türkiye Belediyeler Birliği kamuya açık verileri.

class UtilityProvider {
  final String name;
  final String type; // 'water', 'electricity', 'gas', 'internet', 'mobile'
  final String? website;

  const UtilityProvider({
    required this.name,
    required this.type,
    this.website,
  });
}

class CityUtilities {
  final String city;
  final String plate; // Plaka kodu (01-81)
  final List<UtilityProvider> waterProviders;
  final List<UtilityProvider> electricityProviders;
  final List<UtilityProvider> gasProviders;

  const CityUtilities({
    required this.city,
    required this.plate,
    required this.waterProviders,
    required this.electricityProviders,
    required this.gasProviders,
  });
}

/// Ulusal (tüm illerde geçerli) hizmet sağlayıcılar
const List<UtilityProvider> nationalMobileProviders = [
  UtilityProvider(name: 'Turkcell', type: 'mobile', website: 'turkcell.com.tr'),
  UtilityProvider(name: 'Vodafone', type: 'mobile', website: 'vodafone.com.tr'),
  UtilityProvider(name: 'Türk Telekom', type: 'mobile', website: 'turktelekom.com.tr'),
  UtilityProvider(name: 'NETGSM', type: 'mobile', website: 'netgsm.com.tr'),
];

const List<UtilityProvider> nationalInternetProviders = [
  UtilityProvider(name: 'Türk Telekom (ADSL/Fiber)', type: 'internet', website: 'turktelekom.com.tr'),
  UtilityProvider(name: 'Superonline', type: 'internet', website: 'superonline.com'),
  UtilityProvider(name: 'Millenicom', type: 'internet', website: 'millenicom.com.tr'),
  UtilityProvider(name: 'Kablonet', type: 'internet', website: 'kablonet.com.tr'),
];

/// 81 il bazında kamu hizmetleri
const Map<String, CityUtilities> turkeyUtilities = {
  'Adana': CityUtilities(
    city: 'Adana', plate: '01',
    waterProviders: [UtilityProvider(name: 'ASKİ (Adana)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Toroslar EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Aksa Doğalgaz', type: 'gas')],
  ),
  'Adıyaman': CityUtilities(
    city: 'Adıyaman', plate: '02',
    waterProviders: [UtilityProvider(name: 'Adıyaman Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Dicle EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Adıyaman Doğalgaz', type: 'gas')],
  ),
  'Afyonkarahisar': CityUtilities(
    city: 'Afyonkarahisar', plate: '03',
    waterProviders: [UtilityProvider(name: 'Afyon Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Gediz EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Aksa Doğalgaz', type: 'gas')],
  ),
  'Ağrı': CityUtilities(
    city: 'Ağrı', plate: '04',
    waterProviders: [UtilityProvider(name: 'Ağrı Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Ağrı Doğalgaz', type: 'gas')],
  ),
  'Amasya': CityUtilities(
    city: 'Amasya', plate: '05',
    waterProviders: [UtilityProvider(name: 'Amasya Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Yeşilırmak EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Amasya Doğalgaz', type: 'gas')],
  ),
  'Ankara': CityUtilities(
    city: 'Ankara', plate: '06',
    waterProviders: [UtilityProvider(name: 'ASKİ (Ankara)', type: 'water', website: 'aski.gov.tr')],
    electricityProviders: [UtilityProvider(name: 'Başkent EDAŞ', type: 'electricity', website: 'baskentedas.com.tr')],
    gasProviders: [UtilityProvider(name: 'BAŞKENTGAZ', type: 'gas', website: 'baskentgaz.com.tr')],
  ),
  'Antalya': CityUtilities(
    city: 'Antalya', plate: '07',
    waterProviders: [UtilityProvider(name: 'ASAT (Antalya)', type: 'water', website: 'asat.gov.tr')],
    electricityProviders: [UtilityProvider(name: 'Akdeniz EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Aksa Doğalgaz', type: 'gas')],
  ),
  'Artvin': CityUtilities(
    city: 'Artvin', plate: '08',
    waterProviders: [UtilityProvider(name: 'Artvin Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Fırat EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Artvin Doğalgaz (Planlama Aşaması)', type: 'gas')],
  ),
  'Aydın': CityUtilities(
    city: 'Aydın', plate: '09',
    waterProviders: [UtilityProvider(name: 'Aydın Su ve Kanalizasyon İdaresi', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Gediz EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Bosphorus Gaz', type: 'gas')],
  ),
  'Balıkesir': CityUtilities(
    city: 'Balıkesir', plate: '10',
    waterProviders: [UtilityProvider(name: 'BASKİ (Balıkesir)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'UEDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Bilecik': CityUtilities(
    city: 'Bilecik', plate: '11',
    waterProviders: [UtilityProvider(name: 'Bilecik Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'UEDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Bingöl': CityUtilities(
    city: 'Bingöl', plate: '12',
    waterProviders: [UtilityProvider(name: 'Bingöl Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Bingöl Doğalgaz', type: 'gas')],
  ),
  'Bitlis': CityUtilities(
    city: 'Bitlis', plate: '13',
    waterProviders: [UtilityProvider(name: 'Bitlis Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Bitlis Doğalgaz', type: 'gas')],
  ),
  'Bolu': CityUtilities(
    city: 'Bolu', plate: '14',
    waterProviders: [UtilityProvider(name: 'Bolu Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Başkent EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Burdur': CityUtilities(
    city: 'Burdur', plate: '15',
    waterProviders: [UtilityProvider(name: 'Burdur Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Akdeniz EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Aksa Doğalgaz', type: 'gas')],
  ),
  'Bursa': CityUtilities(
    city: 'Bursa', plate: '16',
    waterProviders: [UtilityProvider(name: 'BUSKİ (Bursa)', type: 'water', website: 'buski.gov.tr')],
    electricityProviders: [UtilityProvider(name: 'UEDAŞ', type: 'electricity', website: 'uedas.com.tr')],
    gasProviders: [UtilityProvider(name: 'Bursagaz', type: 'gas', website: 'bursagaz.com.tr')],
  ),
  'Çanakkale': CityUtilities(
    city: 'Çanakkale', plate: '17',
    waterProviders: [UtilityProvider(name: 'Çanakkale Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'UEDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Çankırı': CityUtilities(
    city: 'Çankırı', plate: '18',
    waterProviders: [UtilityProvider(name: 'Çankırı Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Başkent EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Çankırı Doğalgaz', type: 'gas')],
  ),
  'Çorum': CityUtilities(
    city: 'Çorum', plate: '19',
    waterProviders: [UtilityProvider(name: 'Çorum Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Yeşilırmak EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Denizli': CityUtilities(
    city: 'Denizli', plate: '20',
    waterProviders: [UtilityProvider(name: 'DESKİ (Denizli)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Gediz EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Bosphorus Gaz', type: 'gas')],
  ),
  'Diyarbakır': CityUtilities(
    city: 'Diyarbakır', plate: '21',
    waterProviders: [UtilityProvider(name: 'DİSKİ (Diyarbakır)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Dicle EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Diyarbakır Doğalgaz', type: 'gas')],
  ),
  'Edirne': CityUtilities(
    city: 'Edirne', plate: '22',
    waterProviders: [UtilityProvider(name: 'Edirne Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'TREDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Edirne Doğalgaz', type: 'gas')],
  ),
  'Elazığ': CityUtilities(
    city: 'Elazığ', plate: '23',
    waterProviders: [UtilityProvider(name: 'Elazığ Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Fırat EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Elazığ Doğalgaz', type: 'gas')],
  ),
  'Erzincan': CityUtilities(
    city: 'Erzincan', plate: '24',
    waterProviders: [UtilityProvider(name: 'Erzincan Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Erzincan Doğalgaz', type: 'gas')],
  ),
  'Erzurum': CityUtilities(
    city: 'Erzurum', plate: '25',
    waterProviders: [UtilityProvider(name: 'ESKİ (Erzurum)', type: 'water', website: 'eski.gov.tr')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'GAZDAŞ (Erzurum)', type: 'gas', website: 'gazdas.com.tr')],
  ),
  'Eskişehir': CityUtilities(
    city: 'Eskişehir', plate: '26',
    waterProviders: [UtilityProvider(name: 'ESKİ (Eskişehir)', type: 'water', website: 'eski.gov.tr')],
    electricityProviders: [UtilityProvider(name: 'Başkent EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'ESGAZ (Eskişehir)', type: 'gas')],
  ),
  'Gaziantep': CityUtilities(
    city: 'Gaziantep', plate: '27',
    waterProviders: [UtilityProvider(name: 'GASKİ (Gaziantep)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Toroslar EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Gaziantep Doğalgaz', type: 'gas')],
  ),
  'Giresun': CityUtilities(
    city: 'Giresun', plate: '28',
    waterProviders: [UtilityProvider(name: 'Giresun Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Fırat EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Giresun Doğalgaz', type: 'gas')],
  ),
  'Gümüşhane': CityUtilities(
    city: 'Gümüşhane', plate: '29',
    waterProviders: [UtilityProvider(name: 'Gümüşhane Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Fırat EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Gümüşhane Doğalgaz', type: 'gas')],
  ),
  'Hakkari': CityUtilities(
    city: 'Hakkari', plate: '30',
    waterProviders: [UtilityProvider(name: 'Hakkari Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Hakkari Doğalgaz', type: 'gas')],
  ),
  'Hatay': CityUtilities(
    city: 'Hatay', plate: '31',
    waterProviders: [UtilityProvider(name: 'HATSu (Hatay)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Toroslar EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Aksa Doğalgaz', type: 'gas')],
  ),
  'Isparta': CityUtilities(
    city: 'Isparta', plate: '32',
    waterProviders: [UtilityProvider(name: 'Isparta Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Akdeniz EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Aksa Doğalgaz', type: 'gas')],
  ),
  'Mersin': CityUtilities(
    city: 'Mersin', plate: '33',
    waterProviders: [UtilityProvider(name: 'MESKİ (Mersin)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Toroslar EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Aksa Doğalgaz', type: 'gas')],
  ),
  'İstanbul': CityUtilities(
    city: 'İstanbul', plate: '34',
    waterProviders: [UtilityProvider(name: 'İSKİ (İstanbul)', type: 'water', website: 'iski.istanbul')],
    electricityProviders: [UtilityProvider(name: 'BEDAŞ', type: 'electricity', website: 'bedas.gov.tr'), UtilityProvider(name: 'ENERJİSA (İstanbul)', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'İGDAŞ', type: 'gas', website: 'igdas.com.tr')],
  ),
  'İzmir': CityUtilities(
    city: 'İzmir', plate: '35',
    waterProviders: [UtilityProvider(name: 'İZSU (İzmir)', type: 'water', website: 'izsu.gov.tr')],
    electricityProviders: [UtilityProvider(name: 'Gediz EDAŞ', type: 'electricity', website: 'gedizedas.com')],
    gasProviders: [UtilityProvider(name: 'İzmirgaz', type: 'gas', website: 'izmirgaz.com.tr')],
  ),
  'Kars': CityUtilities(
    city: 'Kars', plate: '36',
    waterProviders: [UtilityProvider(name: 'Kars Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'GAZDAŞ (Kars)', type: 'gas')],
  ),
  'Kastamonu': CityUtilities(
    city: 'Kastamonu', plate: '37',
    waterProviders: [UtilityProvider(name: 'Kastamonu Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Yeşilırmak EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Kayseri': CityUtilities(
    city: 'Kayseri', plate: '38',
    waterProviders: [UtilityProvider(name: 'KASKİ (Kayseri)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Toroslar EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'KAYSERIGAZ', type: 'gas')],
  ),
  'Kırklareli': CityUtilities(
    city: 'Kırklareli', plate: '39',
    waterProviders: [UtilityProvider(name: 'Kırklareli Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'TREDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Kırşehir': CityUtilities(
    city: 'Kırşehir', plate: '40',
    waterProviders: [UtilityProvider(name: 'Kırşehir Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Başkent EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Kırşehir Doğalgaz', type: 'gas')],
  ),
  'Kocaeli': CityUtilities(
    city: 'Kocaeli', plate: '41',
    waterProviders: [UtilityProvider(name: 'İSU (Kocaeli)', type: 'water', website: 'izmitsu.gov.tr')],
    electricityProviders: [UtilityProvider(name: 'Energisa (Kocaeli)', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'IZGAZ (Kocaeli)', type: 'gas', website: 'izgaz.com.tr')],
  ),
  'Konya': CityUtilities(
    city: 'Konya', plate: '42',
    waterProviders: [UtilityProvider(name: 'KOSKİ (Konya)', type: 'water', website: 'koski.gov.tr')],
    electricityProviders: [UtilityProvider(name: 'Meram EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Konya Doğalgaz', type: 'gas')],
  ),
  'Kütahya': CityUtilities(
    city: 'Kütahya', plate: '43',
    waterProviders: [UtilityProvider(name: 'Kütahya Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Gediz EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Malatya': CityUtilities(
    city: 'Malatya', plate: '44',
    waterProviders: [UtilityProvider(name: 'MASKİ (Malatya)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Fırat EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Aksa Doğalgaz', type: 'gas')],
  ),
  'Manisa': CityUtilities(
    city: 'Manisa', plate: '45',
    waterProviders: [UtilityProvider(name: 'MASKİ (Manisa)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Gediz EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Bosphorus Gaz', type: 'gas')],
  ),
  'Kahramanmaraş': CityUtilities(
    city: 'Kahramanmaraş', plate: '46',
    waterProviders: [UtilityProvider(name: 'KAHSu (Kahramanmaraş)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Toroslar EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Aksa Doğalgaz', type: 'gas')],
  ),
  'Mardin': CityUtilities(
    city: 'Mardin', plate: '47',
    waterProviders: [UtilityProvider(name: 'MARSu (Mardin)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Dicle EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Mardin Doğalgaz', type: 'gas')],
  ),
  'Muğla': CityUtilities(
    city: 'Muğla', plate: '48',
    waterProviders: [UtilityProvider(name: 'MUSKİ (Muğla)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Akdeniz EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Bosphorus Gaz', type: 'gas')],
  ),
  'Muş': CityUtilities(
    city: 'Muş', plate: '49',
    waterProviders: [UtilityProvider(name: 'Muş Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Muş Doğalgaz', type: 'gas')],
  ),
  'Nevşehir': CityUtilities(
    city: 'Nevşehir', plate: '50',
    waterProviders: [UtilityProvider(name: 'Nevşehir Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Toroslar EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Niğde': CityUtilities(
    city: 'Niğde', plate: '51',
    waterProviders: [UtilityProvider(name: 'Niğde Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Toroslar EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Ordu': CityUtilities(
    city: 'Ordu', plate: '52',
    waterProviders: [UtilityProvider(name: 'ORAS (Ordu)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Yeşilırmak EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Ordu Doğalgaz', type: 'gas')],
  ),
  'Rize': CityUtilities(
    city: 'Rize', plate: '53',
    waterProviders: [UtilityProvider(name: 'Rize Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Fırat EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Rize Doğalgaz', type: 'gas')],
  ),
  'Sakarya': CityUtilities(
    city: 'Sakarya', plate: '54',
    waterProviders: [UtilityProvider(name: 'SASKİ (Sakarya)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Akenerji (Sakarya)', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'IZGAZ (Sakarya)', type: 'gas')],
  ),
  'Samsun': CityUtilities(
    city: 'Samsun', plate: '55',
    waterProviders: [UtilityProvider(name: 'SASKİ (Samsun)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Yeşilırmak EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Samsun Gaz', type: 'gas')],
  ),
  'Siirt': CityUtilities(
    city: 'Siirt', plate: '56',
    waterProviders: [UtilityProvider(name: 'Siirt Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Dicle EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Siirt Doğalgaz', type: 'gas')],
  ),
  'Sinop': CityUtilities(
    city: 'Sinop', plate: '57',
    waterProviders: [UtilityProvider(name: 'Sinop Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Yeşilırmak EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Sinop Doğalgaz', type: 'gas')],
  ),
  'Sivas': CityUtilities(
    city: 'Sivas', plate: '58',
    waterProviders: [UtilityProvider(name: 'SİVASGAZ (Sivas)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Yeşilırmak EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Sivas Doğalgaz', type: 'gas')],
  ),
  'Tekirdağ': CityUtilities(
    city: 'Tekirdağ', plate: '59',
    waterProviders: [UtilityProvider(name: 'TESKİ (Tekirdağ)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'TREDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Tokat': CityUtilities(
    city: 'Tokat', plate: '60',
    waterProviders: [UtilityProvider(name: 'Tokat Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Yeşilırmak EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Trabzon': CityUtilities(
    city: 'Trabzon', plate: '61',
    waterProviders: [UtilityProvider(name: 'TİSKİ (Trabzon)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Fırat EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Trabzon Doğalgaz', type: 'gas')],
  ),
  'Tunceli': CityUtilities(
    city: 'Tunceli', plate: '62',
    waterProviders: [UtilityProvider(name: 'Tunceli Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Tunceli Doğalgaz', type: 'gas')],
  ),
  'Şanlıurfa': CityUtilities(
    city: 'Şanlıurfa', plate: '63',
    waterProviders: [UtilityProvider(name: 'ŞUSKİ (Şanlıurfa)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Dicle EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Şanlıurfa Doğalgaz', type: 'gas')],
  ),
  'Uşak': CityUtilities(
    city: 'Uşak', plate: '64',
    waterProviders: [UtilityProvider(name: 'Uşak Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Gediz EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Van': CityUtilities(
    city: 'Van', plate: '65',
    waterProviders: [UtilityProvider(name: 'VASKİ (Van)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Van Doğalgaz', type: 'gas')],
  ),
  'Yozgat': CityUtilities(
    city: 'Yozgat', plate: '66',
    waterProviders: [UtilityProvider(name: 'Yozgat Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Başkent EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Zonguldak': CityUtilities(
    city: 'Zonguldak', plate: '67',
    waterProviders: [UtilityProvider(name: 'Zonguldak Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Başkent EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Aksaray': CityUtilities(
    city: 'Aksaray', plate: '68',
    waterProviders: [UtilityProvider(name: 'Aksaray Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Toroslar EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Bayburt': CityUtilities(
    city: 'Bayburt', plate: '69',
    waterProviders: [UtilityProvider(name: 'Bayburt Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Bayburt Doğalgaz', type: 'gas')],
  ),
  'Karaman': CityUtilities(
    city: 'Karaman', plate: '70',
    waterProviders: [UtilityProvider(name: 'Karaman Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Meram EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Karaman Doğalgaz', type: 'gas')],
  ),
  'Kırıkkale': CityUtilities(
    city: 'Kırıkkale', plate: '71',
    waterProviders: [UtilityProvider(name: 'Kırıkkale Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Başkent EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Kırıkkale Doğalgaz', type: 'gas')],
  ),
  'Batman': CityUtilities(
    city: 'Batman', plate: '72',
    waterProviders: [UtilityProvider(name: 'Batman Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Dicle EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Batman Doğalgaz', type: 'gas')],
  ),
  'Şırnak': CityUtilities(
    city: 'Şırnak', plate: '73',
    waterProviders: [UtilityProvider(name: 'Şırnak Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Dicle EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Şırnak Doğalgaz', type: 'gas')],
  ),
  'Bartın': CityUtilities(
    city: 'Bartın', plate: '74',
    waterProviders: [UtilityProvider(name: 'Bartın Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Yeşilırmak EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Ardahan': CityUtilities(
    city: 'Ardahan', plate: '75',
    waterProviders: [UtilityProvider(name: 'Ardahan Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'GAZDAŞ (Ardahan)', type: 'gas')],
  ),
  'Iğdır': CityUtilities(
    city: 'Iğdır', plate: '76',
    waterProviders: [UtilityProvider(name: 'Iğdır Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Aras EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Iğdır Doğalgaz', type: 'gas')],
  ),
  'Yalova': CityUtilities(
    city: 'Yalova', plate: '77',
    waterProviders: [UtilityProvider(name: 'YASKİ (Yalova)', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'UEDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Bursagaz', type: 'gas')],
  ),
  'Karabük': CityUtilities(
    city: 'Karabük', plate: '78',
    waterProviders: [UtilityProvider(name: 'Karabük Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Yeşilırmak EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
  'Kilis': CityUtilities(
    city: 'Kilis', plate: '79',
    waterProviders: [UtilityProvider(name: 'Kilis Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Toroslar EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Aksa Doğalgaz', type: 'gas')],
  ),
  'Osmaniye': CityUtilities(
    city: 'Osmaniye', plate: '80',
    waterProviders: [UtilityProvider(name: 'Osmaniye Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Toroslar EDAŞ', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Aksa Doğalgaz', type: 'gas')],
  ),
  'Düzce': CityUtilities(
    city: 'Düzce', plate: '81',
    waterProviders: [UtilityProvider(name: 'Düzce Su ve Kanalizasyon', type: 'water')],
    electricityProviders: [UtilityProvider(name: 'Akenerji (Düzce)', type: 'electricity')],
    gasProviders: [UtilityProvider(name: 'Enerya Gaz', type: 'gas')],
  ),
};
