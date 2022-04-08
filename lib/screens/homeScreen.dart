import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_manager_beta/Custom_icons.dart';
import 'package:credit_card_manager_beta/db_functions/db_functions.dart';
import '../ListView_option_Category.dart';
import '../home_widget_all.dart';
import '../main.dart';
import '../Add_or_Update_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  var dateRange;
  var _selectedStartDate;
  var _selectedEndDate;
  Map<String, double> dataMap = {};
  var DataMap;

  bool _favoriteVisible = false;
  String? dropdownvalue;
  Map<int, String> monthsofYearsMap = {};

  int _incomeTot = 0;
  int _expenseTot = 0;
  int _savingsTot = 0;
  int _savingsOverall = 0;

  var currentMonth = DateTime.now().month;
  var currentMonthText;
  String DisplayDate = '';
  late var monthLastDate;
  late var monthFirstDate;
  var startText;
  var endText;

  Future<void> getTotalSavings() async {
    monthFirstDate = await getFirstDate(_overall, currentMonth);
    monthLastDate = await getLastDate();
    final List ls = monthFirstDate;

    if (ls.isNotEmpty) {
      _selectedStartDate = monthFirstDate[0]['date'].toString();
      _selectedEndDate = monthLastDate[0]['date'].toString();
    }

    currentMonthText = (DateFormat('MMM')
        .format(DateTime(0, int.parse('$currentMonth'.toString()))));
    final entireData = await GroupByCategory(Tsavings: true);
    final List la = entireData;
    if (la.isEmpty) {
      setState(() {
        _savingsOverall = 0;
      });
    } else {
      for (var i = 0; i < entireData.length; i++) {
        String item = entireData[i]['category'];
        if (item == '1') {
          _incomeTot = entireData[i]['tot_amount']!;
        }
        if (item == '2') {
          _expenseTot = entireData[i]['tot_amount']!;
        }
      }
      _savingsOverall = _incomeTot - _expenseTot;
    }
    setState(() {
      _savingsOverall;
    });
    getAllitemWidget();
  }

  int _incomeTotal = 0;
  int _expenseTotal = 0;

  getAllitemWidget() async {
    _incomeTotal = 0;
    _expenseTotal = 0;
    final entireData = _selectedStartDate != null
        ? await GroupByCategory(
            startDate: _selectedStartDate,
            endDate: _selectedEndDate,
          )
        : await GroupByCategory(overall: _overall);

    for (var i = 0; i < entireData.length; i++) {
      String item = entireData[i]['category'];
      if (item == '1') {
        _incomeTotal = entireData[i]['tot_amount']!;
      }
      if (item == '2') {
        _expenseTotal = entireData[i]['tot_amount']!;
      }
    }

    setState(() {
      _incomeTot = _incomeTotal;
      _expenseTot = _expenseTotal;

      _savingsTot = _incomeTot - _expenseTot;
    });
  }

  Map<String, Object?> __selectedcontent = {};
  bool _isUpdateClicked = false;
  bool _isAddorUpdate = false;
  int _card = 0;
  bool _overall = false;
  bool _addButton = false;
  bool _percentInd = false;
  int? currentIndex;
  int _cardList = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
      super.setState(() {});
    });
  }

  @override
  void initState() {
    getTotalSavings();
    setState(() {});
    _card = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    startText = _selectedStartDate != null
        ? DateFormat('MMM dd').format(DateTime.parse(_selectedStartDate))
        : null;
    endText = _selectedStartDate != null
        ? DateFormat('MMM dd').format(DateTime.parse(_selectedEndDate))
        : null;

    _selectedStartDate == null
        ? _savingsOverall == 0
            ? DisplayDate = "There is No Data"
            : DisplayDate = "No Data in Current Month"
        : DisplayDate = '''$startText - $endText''';

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.primary_color,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Overall_inkwell_main(size, context),
                    const SizedBox(
                      height: 20,
                    ),
                    scrollView_container(size, context),
                  ],
                ),
                _cardList >= 1
                    ? list_widget(
                        dataMap: DataMap,
                        size: size,
                        toggleisUpdateClicked: toggleisUpdateClicked,
                        card: _cardList,
                        percentIndicator: _percentInd,
                        isOverall: _overall,
                        startDate: _selectedStartDate,
                        endDate: _selectedEndDate,
                        favoriteVisible: _favoriteVisible,
                      )
                    : (_card >= 1 || _isUpdateClicked) &&
                            _favoriteVisible == false
                        ? category_cards(
                            selectedcontent: __selectedcontent,
                            size: size,
                            card: _card,
                            add: _isAddorUpdate,
                            toggleAddorUpdateClicked: toggleAddorUpdateClicked,
                          )
                        : home_content_all_widget(
                            size,
                            toggleisUpdateClicked,
                            _overall,
                            _favoriteVisible,
                            _selectedStartDate,
                            _selectedEndDate),
              ],
            ),
            _addButton == true ? addButton_container(context) : Container(),
            bottomNavigation_buttons(size),
          ],
        ),
      ),
    );
  }

  Stack Overall_inkwell_main(Size size, BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Tooltip(
            message: "Tap here Switch to Overall",
            child: InkWell(
              onTap: () {
                setState(() {
                  currentIndex = null;
                  currentMonth = 0;
                  _overall = true;
                  _card = 0;
                  _cardList = 0;
                  _isUpdateClicked = false;
                  _isAddorUpdate = false;
                  _selectedStartDate = null;
                  getTotalSavings();
                });
              },
              child: Container(
                width: size.width * 0.8,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: Styles.primary_black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Custom_icons.savings,
                          color: Styles.primary_black,
                          size: 27,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Total Savings',
                          style: TextStyle(
                              fontFamily: 'nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Styles.primary_black),
                        ),
                      ],
                    ),
                    Text(
                      "Rs.$_savingsOverall",
                      style: const TextStyle(
                          fontFamily: 'nunito',
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Styles.primary_black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Stack scrollView_container(Size size, BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.width,
          height: 200,
          color: Colors.white,
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: _overall == false
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Tooltip(
                                  message:
                                      "tap to Select a new date range! current date range is ",
                                  child: InkWell(
                                      onTap: () {
                                        currentMonth = 0;
                                        pickDateRange(context);
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today_sharp,
                                            size: 20,
                                            color: Styles.primary_black,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            DisplayDate,
                                            style: Styles.normal17.copyWith(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                dateRange != null
                                    ? Tooltip(
                                        message:
                                            "tap to go default range! defaut date range is current month. ",
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                currentMonth =
                                                    DateTime.now().month;

                                                DisplayDate =
                                                    '''$startText - $endText''';
                                                dateRange = null;
                                                _selectedStartDate = null;
                                              });
                                              getTotalSavings();
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                              size: 22,
                                            )),
                                      )
                                    : Container(),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ],
                    )
                  : Tooltip(
                      message: "Viewing entire Data",
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Overall",
                                  style: Styles.normal20
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
            ),
            main_Scrollview_container(),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ],
    );
  }

  Container main_Scrollview_container() {
    return Container(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _overall == false
              ? const SizedBox(
                  width: 30,
                )
              : Container(),
          _overall == false
              ? Tooltip(
                  message: " ",
                  child: InkWell(
                    onTap: () {},
                    child: Stack(children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Styles.custom_savings_blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Styles.primary_black.withOpacity(0.3),
                              spreadRadius: 0.5,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        width: 140,
                        height: 140,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Custom_icons.savings,
                              size: 36,
                              color: Styles.primary_black,
                            ),
                            const Text(
                              "Savings",
                              style: Styles.normal17,
                            ),
                            Text(
                              "Rs.$_savingsTot",
                              style: Styles.bold25,
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                )
              : Container(),
          const SizedBox(
            width: 30,
          ),
          Tooltip(
            message: "Expense Chart Button",
            child: InkWell(
              onTap: () {
                setState(() {
                  _favoriteVisible = false;
                  _addButton = false;
                  _percentInd = false;
                  _cardList = 2;
                  _percentInd = true;
                  currentIndex = null;
                });
              },
              child: Stack(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Styles.custom_expense_red,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Styles.primary_black.withOpacity(0.3),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    width: 140,
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Custom_icons.expense,
                          size: 36,
                          color: Styles.primary_black,
                        ),
                        const Text(
                          "Expense",
                          style: Styles.normal17,
                        ),
                        Text(
                          "Rs.$_expenseTotal",
                          style: Styles.bold25,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Tooltip(
            message: "Income Chart Button",
            child: InkWell(
              onTap: () {
                setState(() {
                  _favoriteVisible = false;
                  _addButton = false;
                  _percentInd = false;
                  _cardList = 1;
                  _percentInd = true;
                  currentIndex = null;
                });
              },
              child: Stack(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Styles.custom_income_green,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Styles.primary_black.withOpacity(0.3),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    width: 140,
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Custom_icons.income,
                          size: 36,
                          color: Styles.primary_black,
                        ),
                        const Text(
                          "Income",
                          style: Styles.normal17,
                        ),
                        /*  _overall == false
                                                  ? */
                        Text(
                          "Rs.$_incomeTotal",
                          style: Styles.bold25,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }

  Container addButton_container(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 90),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                ImageIcon(
                  AssetImage("assets/export/Union 1.png"),
                  size: 300,
                ),
              ],
            ),
            height: 150,
            width: 300, /* color: Styles.primary_black */
          ),
          Container(
            width: 280,
            height: 100,
            /* color: Colors.red,  */
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isAddorUpdate = true;
                          _card = 1;
                          _addButton = false;
                          _cardList = 0;
                          _isUpdateClicked = false;
                          __selectedcontent = {};
                        });
                      },
                      child: Tooltip(
                        message: "Add your new ",
                        child: Container(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(
                                  Custom_icons.income,
                                  size: 24,
                                  color: Styles.primary_black,
                                ),
                                Text(
                                  "Income",
                                  style: Styles.normal17,
                                )
                              ],
                            ),
                          ),
                          height: 40,
                          width: 130,
                          decoration: const BoxDecoration(
                            color: Styles.custom_income_green,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _cardList = 0;
                          _isAddorUpdate = true;
                          _card = 2;
                          _addButton = false;
                          _isUpdateClicked = false;
                          __selectedcontent = {};
                        });
                      },
                      child: Tooltip(
                        message: "Add your new ",
                        child: Container(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(
                                  Custom_icons.expense,
                                  size: 24,
                                  color: Styles.primary_black,
                                ),
                                Text(
                                  "Expense",
                                  style: Styles.normal17,
                                )
                              ],
                            ),
                          ),
                          height: 40,
                          width: 130,
                          decoration: const BoxDecoration(
                            color: Styles.custom_expense_red,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned bottomNavigation_buttons(Size size) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: size.width,
        height: size.height * .075,
        child: Stack(
          children: [
            Center(
              heightFactor: 0.2,
              child: FloatingActionButton(
                  backgroundColor: Styles.primary_black,
                  child: Tooltip(
                    message: "Add new item +",
                    child: Icon(
                      Icons.add,
                      size: size.width * .1,
                    ),
                  ),
                  elevation: 0.2,
                  onPressed: () {
                    setState(() {
                      __selectedcontent = {};
                      _isAddorUpdate = true;
                      _addButton == false
                          ? _addButton = true
                          : _addButton = false;

                      _card = 0;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(hours: 24 * 3)),
      end: DateTime.now(),
    );
    final newDateRange = await showDateRangePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;
    dateRange = newDateRange;

    _selectedStartDate = DateFormat('yyyy-MM-dd').format(dateRange!.start);
    _selectedEndDate = DateFormat('yyyy-MM-dd').format(dateRange!.end);
    var _selectedFirst = DateFormat('MMM dd').format(dateRange!.start);
    var _selectedEnd = DateFormat('MMM dd').format(dateRange!.end);

    if (dateRange != null) {
      getAllitemWidget();
      setState(() {
        DisplayDate = "$_selectedFirst - $_selectedEnd";
      });
    }
  }

  Future<dynamic> _showAbout() {
    return showDialog(
      context: context,
      builder: (context) {
        return AboutDialog(
          applicationName: "MoneyX",
          applicationVersion: "Version 1.0.0",
          applicationIcon: Image.asset(
            'assets/export/simple_logo.png',
            width: 50.0,
            height: 50.0,
          ),
        );
      },
    );
  }

  void toggleisUpdateClicked(Map<String, Object?> _selectedcontent,
      {bool? fav}) {
    if (fav == true) {
      setState(() {
        _selectedcontent = {};
      });
    }

    if (_selectedcontent.isEmpty) {
      _incomeTot = 0;
      _expenseTot = 0;
      getTotalSavings();
    } else {
      setState(() {
        _card = int.parse(_selectedcontent['category'] as String);
        __selectedcontent = _selectedcontent;
        _cardList = 0;
        _addButton = false;
        _isAddorUpdate = false;
        _favoriteVisible = false;
        _isUpdateClicked ? _isUpdateClicked = false : _isUpdateClicked = true;
      });
    }
  }

  void toggleAddorUpdateClicked(String category) {
    setState(() {
      _cardList = int.parse(category);
      currentIndex = int.parse(category) - 1;
      _percentInd = false;
      _card = 0;
      getTotalSavings();
    });
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 10);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 10);
    path.arcToPoint(
      Offset(size.width * 0.60, size.width * .02),
      radius: Radius.circular(size.width * .1005),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 10);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
