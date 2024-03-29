package logger

import (
	"github.com/Minnek-Digital-Studio/cominnek/config"
	"github.com/fatih/color"
)

func addSpace(i int, args ...string) string {
	if i < len(args)-1 {
		return " "
	}

	return ""
}

func PrintLn(args ...string) {
	if config.Public.Logs {
		for i, arg := range args {
			print(arg, addSpace(i, args...))
		}
		println("")
	}
}

func Danger(args ...string) {
	if config.Public.Logs {
		print(color.HiRedString("❌ "))
		for i, arg := range args {
			print(color.HiRedString(arg), addSpace(i, args...))
		}

		println("")
	}
}

func Warning(args ...string) {
	if config.Public.Logs {
		print(color.HiYellowString("⚠️ "))
		for i, arg := range args {
			print(color.HiYellowString(arg), addSpace(i, args...))
		}

		println("")
	}
}

func Success(args ...string) {
	if config.Public.Logs {
		print(color.HiGreenString("✅ "))
		for i, arg := range args {
			print(color.HiGreenString(arg), addSpace(i, args...))
		}

		println("")
	}
}
