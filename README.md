# Crystal
A simple, lightweight, Godot and Knit-like framework.

## Why Crystal?
I don't know. This framework was tailored to my needs.

## Features
* Easily create and use Controllers
* Allows Tree-like structure of Controllers
* Similar to Godot's scripting API

# API

### Crystal (Service)
The main runner for the Crystal framework.

Methods:

| Method | Description |
| ------ | ----------- |
| `Crystal.new()` | Creates a new Controller. |
| `Crystal.run()` | Runs the Crystal framework and Controllers. |

Properties:

| Property | Description |
| ------ | ----------- |
| `Crystal.Controllers` | The list of Controllers. |

### Controllers
The controllers are the individual components of the framework.

Lifecycle Hooks:

| Hook | Description |
| ------ | ----------- |
| `Controller._init()` | Called when `Crystal.Run()` gets called |
| `Controller._ready()` | Called when the Controller is ready to be used. |
| `Controller._render()` | Called when `RunService.RenderStepped()` is emitted. |
| `Controller._step()` | Called when `RunService.Stepped()` is emitted. |
| `Controller._beat()` | Called when `RunService.Heartbeat()` is emitted. |