import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../providers/user_provider.dart';
import '../../data/utility_providers_data.dart';
import '../../../obligations/domain/obligation_model.dart';
import '../../../obligations/presentation/providers/obligation_provider.dart';

class IntegrationsScreen extends ConsumerStatefulWidget {
  const IntegrationsScreen({super.key});

  @override
  ConsumerState<IntegrationsScreen> createState() => _IntegrationsScreenState();
}

class _IntegrationsScreenState extends ConsumerState<IntegrationsScreen> {
  bool _isLoadingLocation = false;
  String? _selectedCity;

  final List<String> _allCities = turkeyUtilities.keys.toList()..sort();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(userProvider);
      if (user?.selectedCity != null) {
        setState(() => _selectedCity = user!.selectedCity);
      }
    });
  }

  Future<void> _detectCityFromGps() async {
    if (kIsWeb) {
      AppSnackBar.showInfo(context, 'Web\'de GPS konum tespiti desteklenmiyor. Lütfen şehrinizi manuel seçin.');
      return;
    }

    setState(() => _isLoadingLocation = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          AppSnackBar.showError(context, '📍 Konum servisi kapalı. Lütfen ayarlardan açın.');
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            AppSnackBar.showError(context, '📍 Konum izni reddedildi. Lütfen manuel olarak şehir seçin.');
          }
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.low),
      );

      final city = _getCityFromCoordinates(position.latitude, position.longitude);
      if (city != null && mounted) {
        setState(() => _selectedCity = city);
        ref.read(userProvider.notifier).updateUser(selectedCity: city);
        AppSnackBar.showSuccess(context, 'Konumunuz tespit edildi: $city');
      } else if (mounted) {
        AppSnackBar.showError(context, 'Konumunuz Türkiye sınırları içinde tespit edilemedi.');
      }
    } catch (e) {
      if (mounted) {
        AppSnackBar.showError(context, 'Konum alınamadı: ${e.toString()}');
      }
    } finally {
      if (mounted) setState(() => _isLoadingLocation = false);
    }
  }

  /// Enlem/Boylam koordinatına göre yaklaşık il tespiti.
  /// Büyük şehirler için merkez koordinat bazlı en yakın il bulunur.
  String? _getCityFromCoordinates(double lat, double lon) {
    // Türkiye koordinat sınırları
    if (lat < 35.8 || lat > 42.2 || lon < 25.6 || lon > 44.8) return null;

    const cityCoords = <String, List<double>>{
      'İstanbul': [41.01, 28.97],
      'Ankara': [39.93, 32.85],
      'İzmir': [38.42, 27.14],
      'Bursa': [40.19, 29.06],
      'Antalya': [36.90, 30.70],
      'Konya': [37.87, 32.49],
      'Gaziantep': [37.06, 37.38],
      'Şanlıurfa': [37.16, 38.79],
      'Diyarbakır': [37.91, 40.22],
      'Mersin': [36.81, 34.64],
      'Kayseri': [38.73, 35.49],
      'Eskişehir': [39.78, 30.52],
      'Denizli': [37.77, 29.09],
      'Samsun': [41.29, 36.33],
      'Trabzon': [41.00, 39.72],
      'Kocaeli': [40.85, 29.88],
      'Malatya': [38.35, 38.31],
      'Manisa': [38.61, 27.43],
      'Erzurum': [39.91, 41.27],
      'Sakarya': [40.69, 30.43],
      'Van': [38.50, 43.38],
      'Tekirdağ': [40.98, 27.51],
      'Muğla': [37.21, 28.36],
      'Balıkesir': [39.65, 27.89],
      'Kahramanmaraş': [37.59, 36.94],
      'Hatay': [36.20, 36.16],
      'Aydın': [37.85, 27.84],
      'Kırıkkale': [39.85, 33.51],
      'Ordu': [40.98, 37.88],
      'Afyonkarahisar': [38.76, 30.54],
      'Aksaray': [38.37, 34.03],
      'Adana': [37.00, 35.32],
      'Adıyaman': [37.76, 38.28],
      'Ağrı': [39.72, 43.05],
      'Amasya': [40.65, 35.83],
      'Artvin': [41.18, 41.82],
      'Bartın': [41.63, 32.34],
      'Batman': [37.89, 41.13],
      'Bayburt': [40.25, 40.22],
      'Bilecik': [40.14, 29.98],
      'Bingöl': [38.89, 40.49],
      'Bitlis': [38.40, 42.12],
      'Bolu': [40.74, 31.61],
      'Burdur': [37.72, 30.29],
      'Çanakkale': [40.15, 26.41],
      'Çankırı': [40.60, 33.61],
      'Çorum': [40.55, 34.96],
      'Düzce': [40.84, 31.16],
      'Edirne': [41.68, 26.56],
      'Elazığ': [38.68, 39.22],
      'Erzincan': [39.75, 39.49],
      'Giresun': [40.91, 38.39],
      'Gümüşhane': [40.46, 39.48],
      'Hakkari': [37.57, 43.74],
      'Iğdır': [39.92, 44.04],
      'Isparta': [37.76, 30.55],
      'Karabük': [41.20, 32.63],
      'Karaman': [37.18, 33.22],
      'Kars': [40.61, 43.10],
      'Kastamonu': [41.38, 33.78],
      'Kilis': [36.72, 37.12],
      'Kırklareli': [41.73, 27.22],
      'Kırşehir': [39.14, 34.17],
      'Kütahya': [39.42, 29.98],
      'Mardin': [37.31, 40.74],
      'Muş': [38.74, 41.51],
      'Nevşehir': [38.62, 34.72],
      'Niğde': [37.97, 34.68],
      'Osmaniye': [37.07, 36.25],
      'Rize': [41.02, 40.52],
      'Siirt': [37.93, 41.95],
      'Sinop': [42.03, 35.15],
      'Sivas': [39.75, 37.02],
      'Şırnak': [37.52, 42.46],
      'Tokat': [40.31, 36.55],
      'Tunceli': [39.11, 39.55],
      'Uşak': [38.68, 29.41],
      'Yalova': [40.65, 29.27],
      'Yozgat': [39.82, 34.81],
      'Zonguldak': [41.46, 31.80],
      'Ardahan': [41.11, 42.70],
    };

    String? nearestCity;
    double minDistance = double.infinity;

    cityCoords.forEach((city, coords) {
      final dLat = lat - coords[0];
      final dLon = lon - coords[1];
      final distance = dLat * dLat + dLon * dLon;
      if (distance < minDistance) {
        minDistance = distance;
        nearestCity = city;
      }
    });

    return nearestCity;
  }

  void _showCityPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _CityPickerSheet(
        selectedCity: _selectedCity,
        cities: _allCities,
        onCitySelected: (city) {
          setState(() => _selectedCity = city);
          ref.read(userProvider.notifier).updateUser(selectedCity: city);
          Navigator.pop(ctx);
        },
      ),
    );
  }

  void _connectInstitution(String name) {
    final user = ref.read(userProvider);
    final current = List<String>.from(user?.connectedInstitutions ?? []);
    
    if (current.contains(name)) {
      // Bağlantıyı Kes
      current.remove(name);
      ref.read(userProvider.notifier).updateUser(connectedInstitutions: current);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$name bağlantısı kaldırıldı.'), backgroundColor: Colors.orange),
      );
      return;
    }

    // Abone numarası sorma dialogu (Bağlantı Kurma Simülasyonu)
    final _aboneController = TextEditingController();
    bool _isSimulating = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Row(
                children: [
                  Icon(Icons.link, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(child: Text('$name Bağlantısı', style: const TextStyle(fontSize: 18))),
                ],
              ),
              content: _isSimulating
                  ? const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Kurum sistemine bağlanılıyor...'),
                        Text('Fatura bilgileriniz sorgulanıyor...', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Lütfen faturanızın üzerindeki abone veya sözleşme numarasını girin.'),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _aboneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Abone No',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: const Icon(Icons.numbers),
                          ),
                        ),
                      ],
                    ),
              actions: _isSimulating
                  ? []
                  : [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('İptal', style: TextStyle(color: Colors.grey)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_aboneController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Lütfen abone numarasını girin.')),
                            );
                            return;
                          }
                          
                          setDialogState(() => _isSimulating = true);
                          
                          // API Gecikmesi simülasyonu
                          await Future.delayed(const Duration(seconds: 2));
                          
                          if (!mounted) return;
                          
                          // Başarılı senaryo: Kurumu bağla
                          current.add(name);
                          ref.read(userProvider.notifier).updateUser(connectedInstitutions: current);
                          
                          // Yeni bir Fatura (Obligation) oluştur
                          final now = DateTime.now();
                          final dueDate = now.add(const Duration(days: 10)); // 10 gün sonra
                          final fakeAmount = (100 + (now.millisecond % 400)).toDouble(); // 100 - 500 arası rastgele
                          
                          final newObligation = ObligationModel(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            userId: user?.id.toString() ?? 'guest',
                            title: '$name Faturası',
                            category: 'Fatura',
                            amount: fakeAmount,
                            deadline: dueDate,
                            riskScore: 30, // Ortalama bir risk puanı atıyoruz
                            createdAt: now,
                          );
                          
                          await ref.read(obligationProvider.notifier).addObligation(newObligation);
                          
                          if (!mounted) return;
                          Navigator.pop(ctx);
                          
                          AppSnackBar.showSuccess(context, '$name başarıyla bağlandı! Güncel fatura: ${fakeAmount.toStringAsFixed(2)} ₺');
                        },
                        child: const Text('Bağla ve Sorgula'),
                      ),
                    ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final connectedInstitutions = user?.connectedInstitutions ?? [];
    final cityData = _selectedCity != null ? turkeyUtilities[_selectedCity] : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kurum Entegrasyonları'),
        actions: [
          // GPS Buton
          IconButton(
            onPressed: _isLoadingLocation ? null : _detectCityFromGps,
            tooltip: 'Konumumu Otomatik Bul',
            icon: _isLoadingLocation
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.my_location),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Şehir Seçici Kartı
          GestureDetector(
            onTap: _showCityPicker,
            child: GlassContainer(
              blur: 20,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              border: Border.fromBorderSide(
                BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),
              ),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Icon(Icons.location_city, color: Theme.of(context).colorScheme.primary, size: 28),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Bulunduğunuz İl', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(
                            _selectedCity ?? 'İl Seçin',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _selectedCity == null ? Colors.grey : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded, size: 28),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn().slideY(begin: -0.1),

          const SizedBox(height: 16),

          if (_selectedCity == null) ...[
            // İl seçilmemişse yönlendirme
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue, size: 40),
                  const SizedBox(height: 12),
                  const Text(
                    'Bulunduğunuz ili seçin veya konumunuzu otomatik tespit edin.\nSizin bölgenize özel kurumlar listelenecek.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _detectCityFromGps,
                    icon: const Icon(Icons.gps_fixed),
                    label: const Text('Konumumu Otomatik Tespit Et'),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms),
          ] else if (cityData != null) ...[
            // Şehre özel kurumlar
            _buildSection(context, '💧 Su İdaresi', cityData.waterProviders, connectedInstitutions, Colors.blue),
            _buildSection(context, '⚡ Elektrik Dağıtımı', cityData.electricityProviders, connectedInstitutions, Colors.yellow.shade700),
            _buildSection(context, '🔥 Doğalgaz Dağıtımı', cityData.gasProviders, connectedInstitutions, Colors.orange),
            _buildSection(context, '📱 Mobil Operatörler', nationalMobileProviders, connectedInstitutions, Colors.green),
            _buildSection(context, '🌐 İnternet Sağlayıcıları', nationalInternetProviders, connectedInstitutions, Colors.purple),
            const SizedBox(height: 80),
          ],
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<UtilityProvider> providers,
    List<String> connected,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
          ),
        ),
        ...providers.asMap().entries.map((entry) {
          final i = entry.key;
          final p = entry.value;
          final isConnected = connected.contains(p.name);
          return _buildCard(context, p, isConnected, color)
              .animate()
              .fadeIn(delay: (100 * i).ms)
              .slideX(begin: 0.05);
        }),
      ],
    );
  }

  Widget _buildCard(BuildContext context, UtilityProvider provider, bool isConnected, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassContainer(
        height: 72,
        blur: 15,
        color: isConnected
            ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
            : (isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.03)),
        border: Border.fromBorderSide(
          BorderSide(
            color: isConnected
                ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
                : Colors.transparent,
          ),
        ),
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: isConnected ? Theme.of(context).colorScheme.primary : color.withOpacity(0.8),
            child: Icon(
              _iconForType(provider.type),
              color: Colors.white,
              size: 20,
            ),
          ),
          title: Text(provider.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          subtitle: Text(_labelForType(provider.type), style: const TextStyle(fontSize: 12)),
          trailing: isConnected
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 20),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () => _connectInstitution(provider.name),
                      child: const Text('Kes', style: TextStyle(color: Colors.red, fontSize: 12)),
                    ),
                  ],
                )
              : TextButton(
                  onPressed: () => _connectInstitution(provider.name),
                  child: const Text('Bağla'),
                ),
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'water': return Icons.water_drop;
      case 'electricity': return Icons.electric_bolt;
      case 'gas': return Icons.local_fire_department;
      case 'mobile': return Icons.phone_iphone;
      case 'internet': return Icons.wifi;
      default: return Icons.business;
    }
  }

  String _labelForType(String type) {
    switch (type) {
      case 'water': return 'Su ve Atıksu İdaresi';
      case 'electricity': return 'Elektrik Dağıtım Şirketi';
      case 'gas': return 'Doğalgaz Dağıtım Şirketi';
      case 'mobile': return 'GSM Operatörü';
      case 'internet': return 'İnternet Servis Sağlayıcısı';
      default: return 'Kurum';
    }
  }
}

/// İl Seçim Bottom Sheet
class _CityPickerSheet extends StatefulWidget {
  final String? selectedCity;
  final List<String> cities;
  final void Function(String) onCitySelected;

  const _CityPickerSheet({
    required this.selectedCity,
    required this.cities,
    required this.onCitySelected,
  });

  @override
  State<_CityPickerSheet> createState() => _CityPickerSheetState();
}

class _CityPickerSheetState extends State<_CityPickerSheet> {
  late List<String> _filtered;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = widget.cities;
    _searchController.addListener(() {
      final q = _searchController.text.toLowerCase();
      setState(() {
        _filtered = widget.cities.where((c) => c.toLowerCase().contains(q)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Tutma çubuğu
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text('İl Seçin', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          // Arama
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'İl ara...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (ctx, i) {
                final city = _filtered[i];
                final isSelected = city == widget.selectedCity;
                return ListTile(
                  title: Text(city, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                  trailing: isSelected ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary) : null,
                  onTap: () => widget.onCitySelected(city),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
