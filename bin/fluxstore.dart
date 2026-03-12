import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Fluxstore CLI');
    print('Usage: fluxstore <command> [arguments]');
    print('');
    print('Available commands:');
    print('  version    Display the version of Fluxstore');
    print('  info       Display project information');
    return;
  }

  final command = arguments[0].toLowerCase();

  switch (command) {
    case 'version':
      print('Fluxstore v1.0.0+1');
      break;
    case 'info':
      print('Project: Fluxstore');
      print('Description: A high-performance Flutter e-commerce application.');
      print('Author: dartforgeyash');
      break;
    default:
      print('Unknown command: $command');
      print('Run "fluxstore" for a list of available commands.');
      exit(1);
  }
}
