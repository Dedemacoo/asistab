import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/obligation_model.dart';
import '../providers/obligation_provider.dart';

class AddObligationBottomSheet extends ConsumerStatefulWidget {
  final ObligationModel? prefilledObligation;
  const AddObligationBottomSheet({super.key, this.prefilledObligation});

  @override
  ConsumerState<AddObligationBottomSheet> createState() => _AddObligationBottomSheetState();
}

class _AddObligationBottomSheetState extends ConsumerState<AddObligationBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  
  DateTime? _selectedDate;
  String _selectedCategory = 'Fatura';
  
  final List<String> _categories = ['Fatura', 'Abonelik', 'Garanti', 'Taşıt', 'Sağlık', 'Diğer'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.prefilledObligation?.title ?? '');
    _amountController = TextEditingController(
      text: widget.prefilledObligation != null && widget.prefilledObligation!.amount > 0 
        ? widget.prefilledObligation!.amount.toString() 
        : ''
    );
    _selectedDate = widget.prefilledObligation?.deadline;
    
    if (widget.prefilledObligation != null && _categories.contains(widget.prefilledObligation!.category)) {
      _selectedCategory = widget.prefilledObligation!.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yeni Belge/İşlem Ekle',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Başlık (Örn: İnternet Faturası)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Lütfen bir başlık girin' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: 'Kategori',
                        border: OutlineInputBorder(),
                      ),
                      items: _categories.map((c) {
                        return DropdownMenuItem(value: c, child: Text(c));
                      }).toList(),
                      onChanged: (val) {
                        setState(() { _selectedCategory = val!; });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Tutar (₺)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'Tutar girin' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now().add(const Duration(days: 3650)),
                  );
                  if (date != null) {
                    setState(() { _selectedDate = date; });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_selectedDate == null 
                        ? 'Son Ödeme/Bitiş Tarihi Seçin' 
                        : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _selectedDate != null) {
                      final newObligation = ObligationModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        userId: 'local_user',
                        title: _titleController.text,
                        category: _selectedCategory,
                        amount: double.tryParse(_amountController.text) ?? 0.0,
                        deadline: _selectedDate!,
                        riskScore: 0,
                        createdAt: DateTime.now(),
                      );
                      
                      ref.read(obligationProvider.notifier).addObligation(newObligation);
                      Navigator.pop(context);
                    } else if (_selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Lütfen tarih seçin')),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Kaydet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
