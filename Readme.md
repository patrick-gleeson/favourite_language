# The challenge
We would like the candidate to build a simple web or command line application, which should allow users to enter an arbitrary GitHub username, and be presented with a best guess of the GitHub user's favourite programming language.

This can be computed by using the GitHub API to fetch all of the user's public GitHub repos, each of which includes the name of the dominant language for the repository.

Documentation for the GitHub API can be found at http://developer.github.com.

Any programming language and technology (within reason) can be used to complete the test.

# Usage
`bundle install` then `rspec --format doc` to verify tests and view documentation.

`rubocop` to verify style adherence.

`rails s` then visit `localhost:3000` to view in action.
