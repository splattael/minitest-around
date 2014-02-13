Feature: around hooks

  Stolen from: https://github.com/ruby/ruby-core/blob/master/features/hooks/around_hooks.feature

  Around hooks receive the example as a block argument, extended to behave like
  a proc.  This lets you define code that should be executed before and after
  the example. Of course, you can do the same thing with before and after hooks,
  and it's often cleaner to do so.

  Where around hooks shine is when you want to run an example in a block. For
  example, if your database library offers a transaction method that receives
  a block, you can use an around hook as described in the first scenario:

  WARNING: around hooks do not share state with the example the way before and
  after hooks do. This means that you can not share instance variables between
  around hooks and examples.

  Also, mock frameworks are set up and torn down within the context of running
  the example, so you can not interact with them directly in around hooks.

  Scenario: use the example as a proc within the block passed to around()
    Given a file named "example_spec.rb" with:
      """
      class Database
        def self.transaction
          puts "open transaction"
          yield
          puts "close transaction"
        end
      end

      describe "around filter" do
        around do |example|
          Database.transaction(&example)
        end

        it "gets run in order" do
          puts "run the example"
        end
      end
      """
    When I run `ruby example_spec.rb`
    Then the output should contain:
      """
      open transaction
      run the example
      close transaction
      """

  Scenario: invoke the example using call()
    Given a file named "example_spec.rb" with:
      """ruby
      describe "around hook" do
        around do |example|
          puts "around each before"
          example.call
          puts "around each after"
        end

        it "gets run in order" do
          puts "in the example"
        end
      end
      """
    When I run `ruby example_spec.rb`
    Then the output should contain:
      """
      around each before
      in the example
      around each after
      """

  Scenario: before/after hooks are wrapped by the around hook
    Given a file named "example_spec.rb" with:
      """ruby
      describe "around filter" do
        around do |example|
          puts "around each before"
          example.call
          puts "around each after"
        end

        before do
          puts "before each"
        end

        after do
          puts "after each"
        end

        it "gets run in order" do
          puts "in the example"
        end
      end
      """
    When I run `ruby example_spec.rb`
    Then the output should contain:
      """
      around each before
      before each
      in the example
      after each
      around each after
      """

  Scenario: implicitly pending examples are detected as Not yet implemented
    Given a file named "example_spec.rb" with:
      """ruby
      describe "implicit pending example" do
        around do |example|
          example.call
        end

        it "should be detected as Not yet implemented"
      end
      """
    When I run `ruby example_spec.rb`
    Then the output should contain "1 runs, 0 assertions, 0 failures, 0 errors, 1 skips"
    And the output should contain:
      """
      You have skipped tests
      """


  Scenario: explicitly pending examples are detected as pending
    Given a file named "example_spec.rb" with:
      """ruby
      describe "explicit pending example" do
        around do |example|
          example.call
        end

        it "should be detected as pending" do
          skip
          fail
        end
      end
      """
    When I run `ruby example_spec.rb`
    Then the output should contain "1 runs, 0 assertions, 0 failures, 0 errors, 1 skips"
    And the output should contain:
      """
      You have skipped tests
      """

  Scenario: multiple around hooks in the same scope
    Given a file named "example_spec.rb" with:
      """ruby
      describe "if there are multiple around hooks in the same scope" do
        around do |example|
          puts "first around hook before"
          example.call
          puts "first around hook after"
        end

        around do |example|
          puts "second around hook before"
          example.call
          puts "second around hook after"
        end

        it "they should all be run" do
          puts "in the example"
          assert true
        end
      end
      """
    When I run `ruby example_spec.rb`
    Then the output should contain "1 runs, 1 assertions, 0 failures, 0 errors, 0 skips"
    And the output should contain:
      """
      first around hook before
      second around hook before
      in the example
      second around hook after
      first around hook after
      """

  Scenario: around hooks in multiple scopes
    Given a file named "example_spec.rb" with:
    """ruby
    describe "if there are around hooks in an outer scope" do
      around do |example|
        puts "first outermost around hook before"
        example.call
        puts "first outermost around hook after"
      end

      around do |example|
        puts "second outermost around hook before"
        example.call
        puts "second outermost around hook after"
      end

      describe "outer scope" do
        around do |example|
          puts "first outer around hook before"
          example.call
          puts "first outer around hook after"
        end

        around do |example|
          puts "second outer around hook before"
          example.call
          puts "second outer around hook after"
        end

        describe "inner scope" do
          around do |example|
            puts "first inner around hook before"
            example.call
            puts "first inner around hook after"
          end

          around do |example|
            puts "second inner around hook before"
            example.call
            puts "second inner around hook after"
          end

          it "they should all be run" do
            puts "in the example"
          end
        end
      end
    end
    """
    When I run `ruby example_spec.rb`
    Then the output should contain "1 runs, 0 assertions, 0 failures, 0 errors, 0 skips"
    And the output should contain:
    """
    first outermost around hook before
    second outermost around hook before
    first outer around hook before
    second outer around hook before
    first inner around hook before
    second inner around hook before
    in the example
    second inner around hook after
    first inner around hook after
    second outer around hook after
    first outer around hook after
    second outermost around hook after
    first outermost around hook after
    """
