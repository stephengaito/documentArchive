

package iPyJoyLoLAdaptor

import (
  "io"
  "go/ast"
  "reflect"
  //"github.com/stephengaito/goJoyLoL/cJoyLoL"
)

const (
  OptShowPrompt   = 1
  OptTrapPanic    = 2
  OptModuleImport = 4
  
)

type PackageMap map[string]Package

var Packages = make(PackageMap)

type Package struct {
  Name    string
  Binds   map[string]reflect.Value
  Types   map[string]reflect.Type
  Proxies map[string]reflect.Type
}

type IPyAdaptor struct {

}

func CompleteWords(
  code string,
  cursorPos int,
)  ( head string, completions []string, tail string) {
// see complete.go
  return "", []string{}, ""
}

func TailIdentifier(prefix string) string {
// see complete.go
  return ""
}

type JTypeKind interface {
}

type JType reflect.Type
//interface {
//  Implements(JType) bool
//  Kind() JTypeKind
//}

type Import struct {
  Types map[string]JType
}

type Interpreter struct {
  Comp *Compiler
}

type GlobalOptions struct {
  Options int
}

type Compiler struct {
  Stdout      io.Writer
  Stderr      io.Writer
  CompGlobals GlobalOptions
  Options     int
  Line        int
}

type Ast interface {
}

type Expr struct {
}

func AnyToAst(ast interface{}, name string) Ast {
  return nil
}

func (comp *Compiler) ParseBytes([]byte) []ast.Node {
  return nil
}

func (comp *Compiler) ImportPackageOrError(string, string) ( *Import, error) {
  return nil, nil
}

func (interp *Interpreter) DeclVar(string, interface{}, interface{} ) {
}

func (interp *Interpreter) CompileAst(form Ast) *Expr {
  return nil
}

func (interp *Interpreter) RunExpr(expr *Expr) ([]reflect.Value, []JType) {
  return nil, nil
}

type Value interface {
}

func Interface(Object) Object {
  return nil
}

type Object interface {
}

type Converter func (Object) Object

func (comp *Compiler) Converter(reflect.Type, JType) Converter {
  return nil
}

func ValueOf(Object) Object {
  return nil
}

func (interp *Interpreter) ValueOf(string) reflect.Value {
  return reflect.ValueOf(nil)
}

func NewInterpreter() *Interpreter {
  return nil
}

type Data struct {
  Data      map[string]interface{}
  Metadata  map[string]interface{}
  Transient map[string]interface{}
}

type DisplayType func(Data) error
