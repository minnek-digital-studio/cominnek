package github

import (
	"log"
	"strings"

	git_controller "github.com/Minnek-Digital-Studio/cominnek/controllers/git"
	"github.com/Minnek-Digital-Studio/cominnek/controllers/loading"
	"github.com/Minnek-Digital-Studio/cominnek/pkg/git"
)

func _checkBranch() []string {
	var branch []string
	currentBranch := git_controller.GetCurrentBranch()

	if currentBranch == "master" {
		log.Fatal("You can't create a pull request from the master branch")
	}

	if strings.Contains(currentBranch, "hotfix") || strings.Contains(currentBranch, "release"){
		branch = append(branch, "master")
		branch = append(branch, "develop")
	}

	return branch
}

func _createPullRequest(ticket string, baseBranch string) {
	loading.Start("Checking branch ")
	branchs := _checkBranch()
	loading.Stop()

	if len(branchs) > 1 {
		for _, branch := range branchs {
			CreatePullRequest(ticket, branch)
		}
	} else {
		CreatePullRequest(ticket, baseBranch)
	}
}

func Publish(msg string, body string, ctype string, scope string, ticket string) {
	if msg != "" {
		git.Add()
		git.Status()
		git.Commit(msg, body, ctype, scope)
	}
	git.PushPublish()
	_createPullRequest(ticket, "")
	log.Println("Publish complete")
}
