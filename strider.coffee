# Description:
#   Hubot listener for Strider-CD webhook that parses results and chats to room.
#
# Dependencies:
#   None
#
# URLS:
#   POST /hubot/strider/:room
#
# Author:
#   Matt Johansen (@mattjay)

module.exports = (robot) ->
  robot.router.post '/hubot/strider/:room', (req, res) ->
    room = req.params.room
    data = JSON.parse req.body.payload
    test_results = data.test_results

    message = "Strider Build Finished.\n"

    if test_results.test_exitcode is 0
      message += "Tests passed!\n"
    else
      message += "Tests Failed! :(\n"

    if test_results.deploy_exitcode is 0
      message += "Deploy succeeded!\n"
    else
      message += "Didn't Deploy.\n"

    message += "Build Details: \n" +
    			"Start Time - #{test_results.start_time}\n" +
    			"Finish Time - #{test_results.finish_time}\n" +
    			"Repo URL - #{test_results.repo_url}\n" +
    			"GitHub Commit ID - #{test_results.github_commit_id}\n"

    robot.messageRoom message
    res.end
