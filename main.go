//go:generate bash versioninfo.sh

package main

import (
	"fmt"
	"os"
	"runtime"
	"runtime/debug"

	"github.com/rodrigocfd/windigo/co"
	"github.com/rodrigocfd/windigo/ui"
)

const IDI_APPLICATION = 32512 // application icon index.

func main() {
	runtime.LockOSThread()

	info, ok := debug.ReadBuildInfo()
	if !ok {
		os.Exit(1)
	}
	version := info.Main.Version

	wnd := ui.NewMain(
		ui.OptsMain().
			ClassIconId(IDI_APPLICATION).
			Title(fmt.Sprintf("Windows PE Init %s", version)).
			Style(co.WS_TILEDWINDOW).
			ExStyle(co.WS_EX_TOPMOST).
			Size(ui.Dpi(640, 80)),
	)

	os.Exit(wnd.RunAsMain())
}
