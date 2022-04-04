import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        transactionName TEXT,
        transactionAmount TEXT,
        transactionType TEXT,
        cardNumber TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE cards(
        cardNumber INTEGER PRIMARY KEY NOT NULL,
        cardName TEXT,
        creditLimit TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'cardDatabase.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String transactionName, String? transactionAmount, String transactionType, String cardNumber) async {
    final db = await SQLHelper.db();

    final data = {'transactionName': transactionName, 'transactionAmount': transactionAmount,'transactionType': transactionType, 'cardNumber': cardNumber};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Create new card
  static Future<int> createCard(int cardNumber, String? cardName, String creditLimit) async {
    final db = await SQLHelper.db();

    final data = {'cardNumber': cardNumber, 'cardName': cardName, 'creditLimit': creditLimit};
    final id = await db.insert('cards', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  // Read all cards
  static Future<List<Map<String, dynamic>>> getCards() async {
    final db = await SQLHelper.db();
    return db.query('cards', orderBy: "cardNumber");
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Read a single card by cardNumber
  static Future<List<Map<String, dynamic>>> getCard(int cardNumber) async {
    final db = await SQLHelper.db();
    return db.query('cards', where: "cardNumber = ?", whereArgs: [cardNumber], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String transactionName, String? transactionAmount, String transactionType, String cardNumber) async {
    final db = await SQLHelper.db();

    final data = {
      'transactionName': transactionName,
      'transactionAmount': transactionAmount,
      'transactionType': transactionType,
      'cardNumber' : cardNumber,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Update an card by cardNumber
  static Future<int> updateCard(
      int cardNumber, String? cardName, String creditLimit) async {
    final db = await SQLHelper.db();

    final data = {
      'cardNumber': cardNumber,
      'cardName': cardName,
      'creditLimit': creditLimit,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('cards', data, where: "cardNumber = ?", whereArgs: [cardNumber]);
    return result;
  }

  // Delete transaction
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // Delete card
  static Future<void> deleteCard(int cardNumber) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("cards", where: "cardNumber = ?", whereArgs: [cardNumber]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}