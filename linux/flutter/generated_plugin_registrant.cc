//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <core_retail/core_retail_plugin.h>
#include <flutter_secure_storage_linux/flutter_secure_storage_linux_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) core_retail_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "CoreRetailPlugin");
  core_retail_plugin_register_with_registrar(core_retail_registrar);
  g_autoptr(FlPluginRegistrar) flutter_secure_storage_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterSecureStorageLinuxPlugin");
  flutter_secure_storage_linux_plugin_register_with_registrar(flutter_secure_storage_linux_registrar);
}
