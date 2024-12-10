#!/bin/bash

generate_hex() {
  local length=$1
  openssl rand -hex $((length / 2))
}

generate_uuid() {
  uuidgen
}

file_path="$HOME/Library/Application Support/Cursor/User/globalStorage/storage.json"

if [ ! -r "$file_path" ]; then
  chmod 666 "$file_path"
fi

new_machine_id=$(generate_hex 64)
new_dev_device_id=$(generate_uuid)
new_mac_machine_id=$(generate_hex 64)

sed -i '' "s/\"telemetry.machineId\": \".*\"/\"telemetry.machineId\": \"$new_machine_id\"/" "$file_path"
sed -i '' "s/\"telemetry.devDeviceId\": \".*\"/\"telemetry.devDeviceId\": \"$new_dev_device_id\"/" "$file_path"
sed -i '' "s/\"telemetry.macMachineId\": \".*\"/\"telemetry.macMachineId\": \"$new_mac_machine_id\"/" "$file_path"

chmod 444 "$file_path"

echo "更新 Cursor ID 完成"
