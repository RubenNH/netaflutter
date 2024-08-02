import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/patin_electrico_repo.dart';
import '../../data/models/patin_electrico_model.dart';
import '../cubit/patin_electrico_cubit.dart';
import '../cubit/patin_electrico_state.dart';

class PatinElectricoListView extends StatelessWidget {
  const PatinElectricoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatinCubit(
        patinRepository: RepositoryProvider.of<PatinElectricoRepository>(context),
      )..fetchPatinElectricos(),
      child: const PatinElectricoListViewBuilder(),
    );
  }
}

class PatinElectricoListViewBuilder extends StatelessWidget {
  const PatinElectricoListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final patinElectricoCubit = BlocProvider.of<PatinCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patin Electrico List'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: patinElectricoCubit.fetchPatinElectricos,
            child: const Text('Refresh'),
          ),
          Expanded(
            child: BlocBuilder<PatinCubit, PatinElectricoState>(
              builder: (context, state) {
                if (state is PatinElectricoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PatinElectricoLoaded) {
                  return ListView.builder(
                    itemCount: state.patinElectricos.length,
                    itemBuilder: (context, index) {
                      final patin = state.patinElectricos[index];
                      return ListTile(
                        title: Text(patin.marca),
                        subtitle: Text(patin.modelo),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editPatin(context, patin),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deletePatin(context, patin.id!),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is PatinElectricoError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No data'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addPatin(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addPatin(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final marcaController = TextEditingController();
        final modeloController = TextEditingController();
        final velocidadMaximaController = TextEditingController();
        final autonomiaController = TextEditingController();
        return AlertDialog(
          title: const Text('Add Patin Electrico'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: marcaController,
                decoration: const InputDecoration(labelText: 'Marca'),
              ),
              TextField(
                controller: modeloController,
                decoration: const InputDecoration(labelText: 'Modelo'),
              ),
              TextField(
                controller: velocidadMaximaController,
                decoration: const InputDecoration(labelText: 'Velocidad Maxima'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: autonomiaController,
                decoration: const InputDecoration(labelText: 'Autonomia'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newPatin = PatinElectricoModel(
                  marca: marcaController.text,
                  modelo: modeloController.text,
                  velocidadMaxima: int.tryParse(velocidadMaximaController.text) ?? 0,
                  autonomia: int.tryParse(autonomiaController.text) ?? 0,
                );
                BlocProvider.of<PatinCubit>(context).createPatinElectrico(newPatin);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editPatin(BuildContext context, PatinElectricoModel patin) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final marcaController = TextEditingController(text: patin.marca);
        final modeloController = TextEditingController(text: patin.modelo);
        final velocidadMaximaController = TextEditingController(text: patin.velocidadMaxima.toString());
        final autonomiaController = TextEditingController(text: patin.autonomia.toString());
        return AlertDialog(
          title: const Text('Edit Patin Electrico'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: marcaController,
                decoration: const InputDecoration(labelText: 'Marca'),
              ),
              TextField(
                controller: modeloController,
                decoration: const InputDecoration(labelText: 'Modelo'),
              ),
              TextField(
                controller: velocidadMaximaController,
                decoration: const InputDecoration(labelText: 'Velocidad Maxima'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: autonomiaController,
                decoration: const InputDecoration(labelText: 'Autonomia'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedPatin = PatinElectricoModel(
                  id: patin.id, // Ensure the ID is passed for the update
                  marca: marcaController.text,
                  modelo: modeloController.text,
                  velocidadMaxima: int.tryParse(velocidadMaximaController.text) ?? patin.velocidadMaxima,
                  autonomia: int.tryParse(autonomiaController.text) ?? patin.autonomia,
                );
                BlocProvider.of<PatinCubit>(context).updatePatinElectrico(updatedPatin);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deletePatin(BuildContext context, String patinId) {
    BlocProvider.of<PatinCubit>(context).deletePatinElectrico(patinId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Patin Electrico deleted successfully'),
      ),
    );
  }
}
