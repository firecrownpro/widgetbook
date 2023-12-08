import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

import 'arg_builder.dart';
import 'extensions.dart';

class ArgsClassBuilder {
  ArgsClassBuilder(this.type);

  final DartType type;

  Iterable<ParameterElement> get params {
    return (type.element as ClassElement)
        .constructors
        .first
        .parameters
        .whereNot((param) => param.name == 'key');
  }

  InvokeExpression instantiate(
    Expression Function(ParameterElement) assigner,
  ) {
    return InvokeExpression.newOf(
      refer(type.displayName),
      params //
          .where((param) => param.isPositional)
          .map(assigner)
          .toList(),
      params //
          .where((param) => param.isNamed)
          .lastBy((param) => param.name)
          .map(
            (_, param) => MapEntry(
              param.name,
              assigner(param),
            ),
          ),
    );
  }

  Class build() {
    return Class(
      (b) => b
        ..name = '${type.displayName}Args'
        ..extend = refer('StoryArgs<${type.displayName}>')
        ..fields.addAll(
          params.map(
            (param) => ArgBuilder(param).buildField(),
          ),
        )
        ..constructors.addAll([
          Constructor(
            (b) => b
              ..optionalParameters.addAll(
                params.map(
                  (param) => ArgBuilder(param).buildArgParam(),
                ),
              )
              ..initializers.addAll(
                params.map(
                  (param) => refer('this')
                      .property(param.name)
                      .assign(
                        refer(param.name)
                            .property('init')
                            .call([], {'name': literalString(param.name)}),
                      )
                      .code,
                ),
              ),
          ),
          Constructor(
            (b) => b
              ..name = 'fixed'
              ..optionalParameters.addAll(
                params.map(
                  (param) => ArgBuilder(param).buildFixedParam(),
                ),
              )
              ..initializers.addAll(
                params.map(
                  (param) => refer('this')
                      .property(param.name)
                      .assign(
                        InvokeExpression.newOf(
                          refer('Arg.fixed'),
                          [refer(param.name)],
                        ),
                      )
                      .code,
                ),
              ),
          ),
        ])
        ..methods.addAll(
          [
            Method(
              (b) => b
                ..name = 'list'
                ..type = MethodType.getter
                ..returns = refer('List<Arg>')
                ..annotations.add(refer('override'))
                ..lambda = true
                ..body = literalList(
                  params.map(
                    (param) => refer(param.name),
                  ),
                ).code,
            ),
            Method(
              (b) => b
                ..name = 'build'
                ..annotations.add(refer('override'))
                ..returns = refer('Widget')
                ..requiredParameters.add(
                  Parameter(
                    (b) => b
                      ..name = 'context'
                      ..type = refer('BuildContext'),
                  ),
                )
                ..optionalParameters.add(
                  Parameter(
                    (b) => b
                      ..name = 'group'
                      ..type = refer('Map<String, String>?'),
                  ),
                )
                ..body = instantiate(
                  (param) => refer('resolve').call([
                    refer(param.name),
                    refer('context'),
                    refer('group'),
                  ]),
                ).returned.statement,
            ),
          ],
        ),
    );
  }
}
