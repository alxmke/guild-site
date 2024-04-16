## Install Guild AI

If you're familiar with installing Python packages using `pip`, simply install the `guildai` package.

``` command
pip install guildai
```

Alternatively, to install to the [user install directory](https://pip.pypa.io/en/stable/cli/pip_install/), run:

``` command
pip install guildai --user
```

For detailed installation instructions, see [*Install Guild AI*](/install).

When Guild is installed, check the environment:

``` command
guild check
```

For help troubleshooting, see [*Get Help with Guid AI*](/help).

## Get Command Help

Guild's primary interface is the [command line](/docs/cli). Commands are run using the format `guild COMMAND`. Use the `--help` option to show information for a command.

Show all Guild commands:

``` command
guild --help
```

See [*Guild AI Commands*](/commands) for a complete reference.

## Command Completion

Guild provides command completion on bash, zsh, and fish shells. To install support for command completion, run:

``` command
guild completion --install
```

Open a new terminal to enable completion. You can test completion by typing `guild` followed by a space and then press Tab twice. This shows a list of available commands. If you type a partial command, Guild automatically complets the command if it can. Otherwise it shows commands that match your input.

## Create a Sample Training Script

In the steps below, you create a sample training script and run it to generate experiments.

Create a new project directory:

``` command
mkdir guild-start
```

:::info Note
You can name this directory anything you want. The examples that follow use `guild-start` to denote the project directory for this guide.
:::

Change to the project directory:

``` command
cd guild-start
```

In the project directory, create a file named `train.py` that contains this Python code:

``` python
import numpy as np

# Hyperparameters
x = 0.1
noise = 0.1

# Simulated training loss
loss = (np.sin(5 * x) * (1 - np.tanh(x ** 2)) + np.random.randn() * noise)

print("loss: %f" % loss)
```

*Sample script `train.py` --- adapted from [Bayesian optimization with skopt](https://scikit-optimize.github.io/stable/auto_examples/bayesian-optimization.html)*

This script simulates a loss function. It accepts hyperparameters *`x`* and *`noise`* and prints the resulting *`loss`*.

The project directory should look like this:

> <span data-guild-class="ls-dir-open">guild-start</span>
<span data-guild-class="ls-file ls-1">train.py</span>

## Run the Script

Use Guild to run `train.py`:

``` command
guild run train.py
```

``` output
You are about to run train.py
  noise: 0.1
  x: 0.1
Continue? (Y/n)
```

Press **Enter** to start the operation.

Guild runs `train.py`, which prints a simulated loss.

When Guild runs a script, it generates a new experiment, or [*run*](/docs/runs). Each run tracks experiment details including results.

:::info Highlight
Guild lets you track experiments without changing your scripts. This saves time and keeps your source independent of an experiment tracking system.
:::

These are the steps that Guild performs when it runs a script:

- **Inspect the script for [*flags*](/docs/flags).** A flag is a user-configurable setting used by your script. In this case, Guild detects two hyperparameters: *`noise`* and *`x`*. By default, Guild treats global constants in Python scripts as flags. This behavior can be controlled through [explicit configuration](/docs/flags#flags-interface), which you learn about later.

- **Generate a new [*run directory*](/docs/runs#run-directory).** This is where all run-related files are stored. Guild uses a unique identifier, or *run ID* to ensure that each run is isolated from other runs.

- **Copy project source code.** To ensure that changes to your project code do not effect in-process runs, Guild copies required source code to the run directory. By default, Guild copies text files under a certain size. You can control this behavior using a [Guild file](/docs/guild-files). For more information, see [Guild File Reference](/reference/guildfile#source-code).

- **Run the script within the run directory**. Guild starts a new operating system process, just as you would when you run the script yourself (e.g. by typing `python train.py`). Guild runs the script *inside the run directory*. This ensures that script-generated files are written for the unique run and not to the project directory.

:::caution Important
Guild runs all scripts from the run directory, which is empty by default. ***If your script attempts to reads files located in your project directory, it won't find them.*** You must use a [Guild File](/docs/guildfile) to tell Guild which files your script needs. These are defined as *dependencies*. For more information, see [Dependencies](/docs/dependencies).
:::

- **Capture output and log scalars**. As your script runs, Guild monitors its output to look for *scalars*. A scalar is a numeric value associated with a key and, optionally, a step. Guild logs scalars within the run directory. For more information, see [Scalars](/docs/scalars).

## View Results

Start the [Guild View](/docs/view) application:

``` command
guild view
```

Guild starts the application, and opens a tab in your browser. Guild View runs in the background in the command terminal.

Use Guild View to browse runs, view run details including metadata, files, and log output. You can compare run results and run artifacts in TensorBoard.

![view-start|685x500](./assets/view-start.png)

<span data-guild-class="caption">Guild View --- a web based application for viewing runs and comparing results</span>

Return to the command terminal and press **Ctrl-C** to stop Guild View.

### View Results from the Terminal

When working in a command line environment, it's convenient to use the terminal to view run results.

From your terminal, use [`guild runs`](/commands/runs) to list the current runs:

``` command
guild runs
```

``` output
[1:68f4da74]  train.py  2020-01-14 08:42:54  completed  noise=0.1 x=0.1
```

Guild lists runs, showing the run ID, operation name, start time, status, and label. As you generate more runs, they appear in this list.

Information about each run is saved in a [*run directory*](/docs/runs#run-directory), including metadata, flag inputs, and results.

Use [`guild runs info`](/commands/runs-info) to show information about a run:

``` command
guild runs info
```

<details>
  <summary>Show Output</summary>

  ```
id: 68f4da7428bd49b5a8946863909f84dc
operation: train.py
from: ~/Projects/guild-start
status: completed
started: 2020-01-14 08:42:54
stopped: 2020-01-14 08:42:54
marked: no
label: noise=0.1 x=0.1
sourcecode_digest: 9d846ffb2022c9540d7b01a160617881
vcs_commit:
run_dir: ~/.guild/runs/68f4da7428bd49b5a8946863909f84dc
command: /usr/bin/python -um guild.op_main train --noise 0.1 --x 0.1
exit_status: 0
pid:
flags:
    noise: 0.1
    x: 0.1
scalars:
    loss: 0.388010 (step 0)
  ```

</details>


By default, Guild shows information for the latest run.

:::info Highlight
Guild captures detailed information for each run so you have a complete record of each result. This information is useful for making informed decisions and tracking changes to your model.
:::

### Project Source Code

Guild saves project *source code* for each run.

To list source code, include the `--sourcecode` option with [`guild ls`](/commands/ls):

``` command
guild ls --sourcecode
```

``` output
~/.guild/runs/68f4da7428bd49b5a8946863909f84dc:
  .guild/sourcecode/
  .guild/sourcecode/train.py
```

:::info Highlight
Guild snapshots the source code at the time the operation is run so you have an accurate record of what executed. You don't have to commit your code to a repository before starting a run. You can freely modify your project source while operations are running.
:::

Use the `--sourcecode` option with [`guild cat`](/commands/cat) to view source code associated with a run :

``` command
guild cat --sourcecode --path train.py
```

<details>
    <summary>Show Output</summary>

```
import numpy as np

# Hyperparameters
x = 0.1
noise = 0.1

# Simulated training loss
loss = (np.sin(5 * x) * (1 - np.tanh(x ** 2)) + np.random.randn() * noise)

print("loss: %f" % loss)
```

</details>

You can also open source code files in your system editor with [`guild open`](/commands/open):

``` command
guild open --sourcecode --path train.py
```

Guild opens the copy `train.py` used for the run with the default system program for `py` files.

![code-start|653x500](./assets/view-start.png)

<span data-guild-class="caption">View a run file in a system program with [`guild open`](/commands/open)</span>

## Summary

In this section, you use Guild AI to capture experiments for a sample training script.

:::info Highlights

- Guild lets you track experiments without changing your code.
- Guild is easy to install and use. It doesn't require databases or external systems.
- Guild captures details about your work that you use to optimize performance, catch mistakes, and resolve problems.

:::

In the next section, you use Guild's built-in hyperparameter tuning support to find values for *`x`* that minimize *`loss`* for the sample training script.