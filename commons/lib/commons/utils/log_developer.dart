import 'dart:developer';

class LoggerDev {
  static error(Object? value,[String identifier = 'ERROR']) {
    if (value == null) {
      log('🚨$identifier:  null 🚨');
    } else {
      log('🚨$identifier:  ${value.toString()} 🚨');
    }
  }

  static warning(Object? value,[String identifier = 'WARNING']) {
    if (value == null) {
      log('⚠️$identifier:  null ⚠️');
    } else {
      log('⚠️$identifier:  ${value.toString()} ⚠️');
    }
  }

  static ok(Object? value,[String identifier = 'OK']) {
    if (value == null) {
      log('✅$identifier:  null ⚠✅');
    } else {
      log('✅$identifier:  ${value.toString()} ✅');
    }
  }

}
