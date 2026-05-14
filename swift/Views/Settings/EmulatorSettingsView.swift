// EmulatorSettingsView.swift — EE/IOP/VU/boot/speedhack settings
// SPDX-License-Identifier: GPL-3.0+

import SwiftUI

struct EmulatorSettingsView: View {
    @State private var settings = SettingsStore.shared

    var body: some View {
        Form {
            Section {
                Toggle(isOn: Binding(
                    get: { settings.eeCoreType == 0 },
                    set: { settings.eeCoreType = $0 ? 0 : 1 }
                )) {
                    HStack {
                        Text("EE Core")
                        Spacer()
                        Text(settings.eeCoreType == 0 ? "JIT" : "Interpreter")
                            .foregroundStyle(.secondary)
                            .font(.callout)
                    }
                }
                Toggle(isOn: $settings.iopRecompiler) {
                    HStack {
                        Text("IOP")
                        Spacer()
                        Text(settings.iopRecompiler ? "JIT" : "Interpreter")
                            .foregroundStyle(.secondary)
                            .font(.callout)
                    }
                }
                Toggle(isOn: $settings.vu0Recompiler) {
                    HStack {
                        Text("VU0")
                        Spacer()
                        Text(settings.vu0Recompiler ? "JIT" : "Interpreter")
                            .foregroundStyle(.secondary)
                            .font(.callout)
                    }
                }
                Toggle(isOn: $settings.vu1Recompiler) {
                    HStack {
                        Text("VU1")
                        Spacer()
                        Text(settings.vu1Recompiler ? "JIT" : "Interpreter")
                            .foregroundStyle(.secondary)
                            .font(.callout)
                    }
                }
                Text("Changes take effect on next VM boot.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } header: {
                Text("CPU Recompiler")
            }

            Section("Boot") {
                Toggle("Fast Boot", isOn: $settings.fastBoot)
                Text("Skips BIOS intro. Some games require this OFF.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Section("Memory") {
                Toggle("Fastmem", isOn: $settings.fastmem)
                Text("Direct memory mapping for EE. Disable if 3D graphics are broken. Requires restart.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Section {
                Stepper("EE Cycle Rate: \(settings.eeCycleRate > 0 ? "+\(settings.eeCycleRate)" : "\(settings.eeCycleRate)")", value: $settings.eeCycleRate, in: -3...3)
                Text("0 = Default. -1/-2 = slightly less EE work (more stable, good for most games). +1/+2 = overclock EE (faster but may crash).")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Toggle("Fast CDVD", isOn: $settings.fastCDVD)
                Text("Speeds up disc reads. Recommended ON — disabling may fix rare loading freezes.")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Toggle("VU1 Instant", isOn: $settings.vu1Instant)
                Text("Runs VU1 calculations instantly rather than cycle-accurate. Big FPS boost on most games.")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Toggle("Wait Loop Detection", isOn: $settings.waitLoop)
                Text("Skips idle CPU loops. Reduces heat and improves FPS in most games.")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Toggle("INTC Stat Hack", isOn: $settings.intcStat)
                Text("Fixes vblank timing loop. Small speedup with no compatibility cost on most games.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } header: {
                Text("Speedhacks")
            } footer: {
                Text("Changes take effect on next VM boot.")
            }

            Section {
                Button("Reset Emulator to Defaults") {
                    settings.resetEmulatorDefaults()
                }
                .foregroundStyle(.red)
            }
        }
        .navigationTitle("Emulator")
        .navigationBarTitleDisplayMode(.inline)
    }
}
