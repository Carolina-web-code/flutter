//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <core_retail/core_retail_plugin_c_api.h>
#include <flutter_secure_storage_windows/flutter_secure_storage_windows_plugin.h>
#include <nsd_windows/nsd_windows_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  CoreRetailPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CoreRetailPluginCApi"));
  FlutterSecureStorageWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterSecureStorageWindowsPlugin"));
  NsdWindowsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("NsdWindowsPluginCApi"));
}
