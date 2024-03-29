package pkg_action

import (
	"github.com/AlecAivazis/survey/v2"
	"github.com/Minnek-Digital-Studio/cominnek/config"
	git_controller "github.com/Minnek-Digital-Studio/cominnek/controllers/git"
	"github.com/Minnek-Digital-Studio/cominnek/controllers/loading"
	"github.com/Minnek-Digital-Studio/cominnek/pkg/ask"
	"github.com/Minnek-Digital-Studio/cominnek/pkg/emitters"
	"github.com/Minnek-Digital-Studio/cominnek/pkg/git"
)

var mergeAfterPush bool
var pushEmmiter = new(emitters.Push)

func pushQuestion() {
	if config.AppData.Push.Merge == "" {
		ask.One(&survey.Confirm{
			Message: "Do you want to merge your changes after push?",
			Default: false,
		}, &mergeAfterPush)

		if !mergeAfterPush {
			return
		}

		loading.Start("Reading branches...")
		branches := git_controller.ListBranches()
		loading.Stop()

		ask.One(&survey.Select{
			Message: "Select a branch to merge your changes into:",
			Options: branches,
		}, &config.AppData.Push.Merge)
	}
}

func Push() {
	pushEmmiter.Init()
	if !config.AppData.Push.IgnoreCommit {
		config.AppData.Push.IgnoreCommit = !git_controller.CheckChanges()
	}

	if !config.AppData.Push.IgnoreCommit {
		Commit(false)
	}

	pushQuestion()

	if !config.AppData.Push.IgnoreCommit {
		executeCommit()
	}

	git.Push()

	if config.AppData.Push.Merge != "" {
		git.Merge(config.AppData.Push.Merge)
	}
}
