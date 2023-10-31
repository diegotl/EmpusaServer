# EmpusaServer
This is a Vapor server that provides an API for [Empusa](https://github.com/diegotl/Empusa/) app.

## Features
In order to reduce GitHub's API consumpton from client side (which can exceed rate limit very quick) this server was written to implement and enpoint that provides a list of all installable resources, as well as their latest versions and assets direct url.

This also provides the necessary files for the "Check for update" function, implemented with Sparkle.

## Usage
Clone the repository and either open Package.swift and run it through Xcode, or execute `swift run` in the root directory.
