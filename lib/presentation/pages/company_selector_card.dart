import 'package:flutter/material.dart';
import 'package:hantera/domain/entities/company.dart';

class CompanySelectorCard extends StatelessWidget {
  final List<Company> companies;
  final Company selectedCompany;
  final ValueChanged<Company> onCompanySelected;

  const CompanySelectorCard({
    super.key,
    required this.companies,
    required this.selectedCompany,
    required this.onCompanySelected,
  });

  void _showCompanySelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: companies.map((company) {
            return ListTile(
              title: Text(company.name),
              onTap: () {
                onCompanySelected(company);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Selected Company'),
        subtitle: Text(selectedCompany.name),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: () => _showCompanySelection(context),
      ),
    );
  }
}
