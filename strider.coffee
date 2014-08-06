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

    message = "Strider Build Finished - #{data.project}:#{data.branch}\n"

    if data.test_exitcode is 0
      message += "Tests passed!\n"
    else
      message += "Tests Failed!  :(\n"

    if data.deploy_exitcode is 0
      message += "Deploy succeeded!\n"
    else
      message += "Didn't Deploy.\n"

    message += "Build Details: \n" +
    			"Finish Time - #{data.finish_time}\n" +
    			"Repo URL - #{data.repo_url}\n" +
    			"GitHub Commit ID - #{data.github_commit_id}\n"

    robot.messageRoom room, message
    res.end 'OK'
