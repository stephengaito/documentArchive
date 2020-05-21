//go:generate esc -o joyLoLCode.go -pkg goIPyJoyLoLAdaptor lib/IPyJoyLoLData.joy
//go:generate cGoTestGenerator goIPyJoyLoLAdaptor goIPyJoyLoLAdaptor ANSI-C tests

package goIPyJoyLoLAdaptor

import (
  //"unsafe"
  "fmt"
  "os"
  "time"
  
  tk "github.com/stephengaito/goIPythonKernelToolkit/goIPyKernel"
)

const (
	// Version defines the goIPyJoyLoL version.
	Version string = "1.0.0"
)

// GoAdaptor represents any state required by the adaptor.
///
type GoAdaptor struct {

  // AdaptorIdFormat is a string which together with the ExecCounter and 
  // ExecSubCounter forms the ExecName to uniquely identify this kernel for 
  // a human user. 
  //
  AdaptorIdFormat string

  // The JoyLoL State
  //
  JoyLoL *JoyLoLState
}

// Create a new adaptor.
//
func NewGoAdaptor() *GoAdaptor {

  // Start by creating the adaptor id format for use by the EvaluateCode 
  // method. 
  //
  adaptorIdFormat := fmt.Sprintf(
    "IPyJoyLoL-%s-%d-%%d.%%d",
    time.Now().Format("2006/01/02-15:04:05"),
    os.Getpid(),
  )
  
  // now create the ruby state..
  //
  rubyState := CreateRubyState()

  // now load the IPyJoyLoLData.joy code (for the GoEvalRubyString)
  //
  codePath := "/lib/IPyJoyLoLData.joy"
  IPyJoyLoLDataCode, err := FSString(false, codePath)
  if err != nil {
    panic("Could not load IPyJoyLoLData.joy from the internal fileSystem!")
  }
  _, err = rubyState.LoadRubyCode("IPyJoyLoLData.joy", IPyJoyLoLDataCode)
  if err != nil {
    panic("Could not load IPyJoyLoLData.joy into running Ruby!")
  }
  
  IPyJoyLoLDebugging = false
  
  return &GoAdaptor{
    AdaptorIdFormat: adaptorIdFormat,
    Ruby:            rubyState,
  }
}

// GetKernelInfo returns the KernelInfo for this kernel implementation.
//
func (adaptor *GoAdaptor) GetKernelInfo() tk.KernelInfo {
  return tk.KernelInfo{
    ProtocolVersion:       tk.ProtocolVersion,
    Implementation:        "goIPyJoyLoL",
    ImplementationVersion: Version,
    Banner:                fmt.Sprintf("Go kernel: goIPyJoyLoL - v%s", Version),
    LanguageInfo:          tk.KernelLanguageInfo{
      Name:          "joyLoL",
      Version:       adaptor.JoyLoL.GetRubyVersion(),
      FileExtension: ".joy",
    },
    HelpLinks: []tk.HelpLink{
      {Text: "Ruby", URL: "https://golang.org/"},
      {Text: "goIPyJoyLoL", URL: "https://github.com/stephengaito/goJoyLoL/goIPyJoyLoL"},
    },
  }
}
  
// Get the possible completions for the word at cursorPos in the code. 
//
// Not currently implemented for the IPyJoyLoL kernel.
//
func (adaptor *GoAdaptor) GetCodeWordCompletions(
  code string,
  cursorPos int,
) (int, int, []string) {
  return 0, 0, make([]string, 0)
}

// Setup the Display callback by recording the msgReceipt information
// for later use by what ever callback implements the "Display" function. 
//
// Not currently implemented for the IPyJoyLoL kernel.
//
func (adaptor *GoAdaptor) SetupDisplayCallback(receipt tk.MsgReceipt) {
}
  
// Teardown the Display callback by removing the current msgReceipt
// information and setting things back to what ever default the 
// implementation uses.
//
// Not currently implemented for the IPyJoyLoL kernel.
//
func (adaptor *GoAdaptor) TeardownDisplayCallback() {
}
  
// Evaluate (and remove) any implmenation specific special commands BEFORE 
// the code gets evaluated by the interpreter. The `outErr` variable 
// contains the stdOut and stdErr which can be used to capture the stdOut 
// and stdErr of any external commands run by these special commands. 
//
// Not currently implemented for the IPyJoyLoL kernel.
//
func (adaptor *GoAdaptor) EvaluateRemoveSpecialCommands(
  outErr tk.OutErr,
  code string,
) string {
  return code
}

// Evaluate the code and return the results as a Data object.
//
func (adaptor *GoAdaptor) EvaluateCode(
  execCounter int,
  execSubCounter int,
  code string,
) (rtnData tk.Data, err error) {
  adaptorIdStr :=
    fmt.Sprintf(adaptor.AdaptorIdFormat, execCounter, execSubCounter)
  
  dataObj := adaptor.JoyLoL.GoEvalJoyLoLString(adaptorIdStr, code)
  return dataObj, nil
}
