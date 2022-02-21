
package cJoyLoL

//go:generate cGoTestGenerator cJoyLoL cGoTest unit tests of cJoyLoL

// #include "joylol.h"
import "C"

import (
  tk "github.com/stephengaito/goIPythonKernelToolkit/goIPyKernel"
)

type JoyLoLState struct {
  // currently no state to maintain
}


func CreateJoyLoLState() *JoyLoLState {
  return &JoyLoLState{}
}

func (js *JoyLoLState) GetJoyLoLVersion() string {
  return "0.0.0"
}

func (js *JoyLoLState) GoEvalJoyLoLString(
  joylolCodeName, joylolCodeStr string,
) tk.Data {
  return tk.Data{
    Data: tk.MIMEMap{
      tk.MIMETypeText: joylolCodeStr,
    },
    Metadata:  tk.MIMEMap{},
    Transient: tk.MIMEMap{},
  }
}

func (js *JoyLoLState) LoadJoyLoLCode(
  joylolCodeName, joylolCodeStr string,
) (int64, error) {
  return 0, nil
}