# mbus-to-mqtt

A home assistant addon to translate mbus over TCP/IP to MQTT

## Background

I created this addon since I needed a good way to read the value of a power meter connected with M-bus and put the value in the home assistant energy dashboard

## Usage

First of all, you need a M-bus TCP/IP gateway. I use a PiiGAB 900s, but you can find cheaper gateways online.

When that is done, you need to install the addon, copy the github link and put it in the repo tab under addon store.

After that just reload and install the addon :D

## Configuration

When installed, you will see a configuration tab, bellow is a explination what each setting is

```text
  mqtt_user: The name of your MQTT user, for home assistant that is for example your dashboard login
  mqtt_pass: The password of said login
  mqtt_host: IP address of the MQTT proker, for example home assistant  (with mosquitto installed)
  mqtt_topic: The first part of the topic, will be followed with the M-bus meter secondary address. For example mbusmeters/FFFFFFFFFFFFFFFF
  mbus_address: The secondary address of the M-bus meter
  mbus_gateway: The IP address of the M-bus gateway
  mbus_gateway_port: The port to connect to of the M-bus gateway, OBS! Note that it must be a TCP port, NOT UDP
```

## Contribute

Anyone is more then welcome to contribute to the project, to contribute, please follow the following pattern:

1. fork
2. Write the code
3. Test it locally
4. Make a PR, please state the reason of the code, its function and how you tested it

## Found a bug?

Thank you! Please open an issue and state the problem and some notes so I can recreate the issue

## Honerable mention

I want to thank [Daniel Glaser / the78mole](https://github.com/the78mole) for the inspiration to create this project, I was looking for a solution to use M-bus in HA and found [this guide](https://the78mole.de/taking-your-m-bus-online-with-mqtt/) which helped me create this project

## Note

This is a very crude solution and I do not garantuee 24/7 uptime. Its a hobby project written in 1 hour and from the start only made for my own home
