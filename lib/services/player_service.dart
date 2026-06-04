import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/player.dart';

class PlayerService {
  static const _playersKey = 'players';
  static const _activeIdsKey = 'active_player_ids';
  static const _nextIdKey = 'next_player_id';

  static Future<List<Player>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_playersKey);
    if (jsonString == null) {
      return _defaults();
    }
    final List<dynamic> list = jsonDecode(jsonString);
    return list.map((e) => Player.fromJson(e as Map<String, dynamic>)).toList();
  }

  static Future<void> saveAll(List<Player> players) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(players.map((p) => p.toJson()).toList());
    await prefs.setString(_playersKey, jsonString);
  }

  static Future<List<String>> getActivePlayerIds() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_activeIdsKey);
    if (jsonString == null) {
      final players = await loadAll();
      final ids = players.take(2).map((p) => p.id).toList();
      await setActivePlayerIds(ids);
      return ids;
    }
    final List<dynamic> list = jsonDecode(jsonString);
    return list.map((e) => e as String).toList();
  }

  static Future<void> setActivePlayerIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeIdsKey, jsonEncode(ids));
  }

  static Future<int> _nextId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt(_nextIdKey) ?? 2;
    await prefs.setInt(_nextIdKey, id + 1);
    return id + 1;
  }

  static Future<Player> addPlayer(String name) async {
    final players = await loadAll();
    final nextId = await _nextId();
    final player = Player(id: nextId.toString(), name: name);
    players.add(player);
    await saveAll(players);
    return player;
  }

  static Future<void> updatePlayer(String id, String name) async {
    final players = await loadAll();
    for (final p in players) {
      if (p.id == id) {
        p.name = name;
        break;
      }
    }
    await saveAll(players);
  }

  static Future<void> deletePlayer(String id) async {
    final players = await loadAll();
    players.removeWhere((p) => p.id == id);
    await saveAll(players);

    final activeIds = await getActivePlayerIds();
    activeIds.remove(id);
    await setActivePlayerIds(activeIds);
  }

  static Future<void> recordWin(String playerId) async {
    final players = await loadAll();
    for (final p in players) {
      if (p.id == playerId) {
        p.wins++;
        break;
      }
    }
    await saveAll(players);
  }

  static Future<void> recordLoss(String playerId) async {
    final players = await loadAll();
    for (final p in players) {
      if (p.id == playerId) {
        p.losses++;
        break;
      }
    }
    await saveAll(players);
  }

  static Future<void> recordDraw(String playerId) async {
    final players = await loadAll();
    for (final p in players) {
      if (p.id == playerId) {
        p.draws++;
        break;
      }
    }
    await saveAll(players);
  }

  static Future<void> resetAllScores() async {
    final players = await loadAll();
    for (final p in players) {
      p.wins = 0;
      p.losses = 0;
      p.draws = 0;
    }
    await saveAll(players);
  }

  static List<Player> _defaults() => [
        Player(id: '1', name: 'Player1'),
        Player(id: '2', name: 'Player2'),
      ];
}
