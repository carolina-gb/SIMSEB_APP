import 'package:flutter/material.dart';
import 'package:fluttertest/modules/my_requests/models/responses/requests_response.dart';
import 'package:fluttertest/modules/my_requests/services/requests_services.dart';
import 'package:fluttertest/modules/my_requests/widgets/search_widget.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/models/general_response.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/alert_template.dart';
import 'package:fluttertest/shared/widgets/card.dart';
import 'package:provider/provider.dart';

class MyRequestsWidget extends StatefulWidget {
  const MyRequestsWidget({
    super.key,
    required this.globalKey,
  });
  final GlobalKey globalKey;
  @override
  State<MyRequestsWidget> createState() => _MyRequestsWidgetState();
}

class _MyRequestsWidgetState extends State<MyRequestsWidget> {
  List<ReportItem> _allRequests = [];
  List<ReportItem> _filteredRequests = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _tryGetAllReports();
      setState(() {});
    });
  }

  Future<void> _tryGetAllReports() async {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);

    final emergencySvc = RequestsService();
    final GeneralResponse<ReportsResponse> resp =
        await emergencySvc.getAll(context);

    if (!resp.error && resp.data != null) {
      setState(() {
        _allRequests = resp.data!.data ?? [];
        _filteredRequests = List.from(_allRequests); // copia inicial
      });
    } else {
      _showEmergencyError(
        fp,
        title: 'Ups, ocurrió un problema',
        message: resp.message ??
            'No pudimos obtener tus reportes. Intenta de nuevo.',
      );
    }
  }

  /// 2. Filtro local
  void _filterRequests(String query) {
    final q = query.toLowerCase();

    setState(() {
      _filteredRequests = _allRequests.where((req) {
        return req
            .toJson()
            .values
            .any((v) => v.toString().toLowerCase().contains(q));
      }).toList();
    });
  }

  void _showEmergencyError(
    FunctionalProvider fp, {
    required String title,
    required String message,
  }) {
    final key = GlobalHelper.genKey();
    fp.showAlert(
      key: key,
      content: AlertGeneric(
        content: WarningAlert(
          keyToClose: key,
          title: title,
          message: message,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: SearchWidget(
              onFilter: _filterRequests,
            ),
          ),
          SizedBox(
              height: size.height * 0.68,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                clipBehavior: Clip.hardEdge,
                itemCount: _filteredRequests.length,
                itemBuilder: (context, index) {
                  final r = _filteredRequests[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: CardWidget(
                      numberRequest: r.caseNumber ?? '—',
                      detail: r.description ?? '—',
                      type: r.type?.showName ?? '—',
                      status: r.stage?.showName ?? '—',
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
