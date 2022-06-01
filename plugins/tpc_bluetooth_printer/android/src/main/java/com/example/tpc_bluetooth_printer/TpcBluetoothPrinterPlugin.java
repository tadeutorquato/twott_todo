///based on https://github.com/muratmjdci/flutter_cblue
package com.example.tpc_bluetooth_printer;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.os.Handler;
import android.os.ParcelUuid;

import androidx.annotation.NonNull;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * TpcBluetoothPrinterPlugin
 */
public class TpcBluetoothPrinterPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private OutputStream outputStream;
    private InputStream inStream;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "tpc_bluetooth_printer");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        BluetoothAdapter bluetooth;
        String selectedDeviceMacAddress;
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);

        } else if (call.method.equals("bluetoothPrint")) {
            String textToPrint = call.argument("textToPrint");
            selectedDeviceMacAddress = call.argument("macAddress");
            bluetooth = BluetoothAdapter.getDefaultAdapter();

            if (bluetooth != null) {

                if (bluetooth.isEnabled()) {

                    Set<BluetoothDevice> pairedDevices = bluetooth.getBondedDevices();

                    if (pairedDevices.size() > 0) {
                        // There are paired devices. Get the name and address of each paired device.
                        for (BluetoothDevice device : pairedDevices) {
                            String deviceHardwareAddress = device.getAddress(); // MAC address
                            if (deviceHardwareAddress.equals(selectedDeviceMacAddress)) {
                                bluetooth.cancelDiscovery();
                                ParcelUuid[] uuids = device.getUuids();
                                try {
                                    final BluetoothSocket socket = device.createRfcommSocketToServiceRecord(uuids[0].getUuid());
                                    socket.connect();
                                    outputStream = socket.getOutputStream();
                                    inStream = socket.getInputStream();

                                    write(textToPrint);

                                    final Handler handler = new Handler();
                                    handler.postDelayed(new Runnable() {
                                        @Override
                                        public void run() {
                                            try {
                                                socket.close(); // Socket closed
                                                result.success("Impressão concluída!");
                                            } catch (IOException e) {
                                                result.error("IMPR-0001", "Houve um erro ao encerrar conexão.", null);
                                            }

                                        }
                                    }, 10000);
                                } catch (IOException e) {
                                  result.error("IMPR-0002", "Não foi possível conectar a impressora pareada.", e);
                                }

                            }
                        }
                    } else {
                        result.error("IMPR-0003", "Nenhuma impressora pareada.", null);
                    }
                } else {
                    result.error("IMPR-0004", "Bluetooth desabilitado.", null);
                }
            }
        } else if (call.method.equals("checkStatus")) {
            bluetooth = BluetoothAdapter.getDefaultAdapter();
            selectedDeviceMacAddress = call.argument("macAddress");
            boolean isMatched = false;
            BluetoothDevice _device = null;
            if (bluetooth != null) {
                if (bluetooth.isEnabled()) {
                    Set<BluetoothDevice> pairedDevices = bluetooth.getBondedDevices();
                    if (pairedDevices.size() > 0) {
                        for (BluetoothDevice device : pairedDevices) {
                            String deviceHardwareAddress = device.getAddress(); // MAC address

                            if (deviceHardwareAddress.equals(selectedDeviceMacAddress)) {
                                isMatched = true;
                                _device = device;
                            }

                        }
                        if (isMatched) {
                            try {
                                ParcelUuid[] uuids = _device.getUuids();
                                final BluetoothSocket socket = _device.createRfcommSocketToServiceRecord(uuids[0].getUuid());
                                socket.connect();

                                final Handler handler = new Handler();
                                handler.postDelayed(new Runnable() {
                                    @Override
                                    public void run() {
                                        try {
                                            socket.close(); // Socket closed
                                            result.success(true);
                                        } catch (IOException e) {
                                            result.error("IMPR-0001", "Houve um erro ao encerrar conexão.", null);
                                        }
                                    }
                                }, 10000);
                            } catch (IOException e) {
                                result.error("IMPR-0002", "Não foi possível conectar a impressora pareada.", null);
                            }
                        }
                        else {
                            result.error("IMPR-0404", "Nenhuma impressora encontrada.", null);
                        }
                    } else {
                        result.error("IMPR-0003", "Nenhuma impressora pareada.", null);
                    }
                } else {
                    result.error("IMPR-0004", "Bluetooth desabilitado.", null);
                }
            }
        } else if (call.method.equals("listPrinters")) {
            bluetooth = BluetoothAdapter.getDefaultAdapter();
            if (bluetooth != null) {
                if (bluetooth.isEnabled()) {
                    Set<BluetoothDevice> pairedDevices = bluetooth.getBondedDevices();
                    if (pairedDevices.size() > 0) {
                        List<Map> lista = new ArrayList<Map>();
                        for (BluetoothDevice device : pairedDevices) {
                            lista.add(Map.of("address",device.getAddress(), "name",device.getName()));
                        }
                        result.success(lista);
                    } else {
                        result.error("IMPR-0003", "Nenhuma impressora pareada.", null);
                    }
                } else {
                    result.error("IMPR-0004", "Bluetooth desabilitado.", null);
                }
            }
        } else {
            result.notImplemented();
        }
    }

    public void write(String s) throws IOException {
        outputStream.write(s.getBytes());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }
}

