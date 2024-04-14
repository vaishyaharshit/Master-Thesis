# LTE BAchelor's/MAster's Thesis (BaMa) template (and FP)

This template lives on https://git.lte.e-technik.uni-erlangen.de/lehre-public/bama_latex_vorlage. An account can be created by [Benedikt Brütting](https://www.lte.tf.fau.de/person/benedikt-bruetting/).

[:rocket: Releases](https://git.lte.e-technik.uni-erlangen.de/lehre-public/bama_latex_vorlage/-/releases)

## :file_cabinet: git

Git is a very popular version control system for text documents. Tons of information can be found on the Internet.

- :leftwards_arrow_with_hook: Track changes and restore old versions
- :floppy_disk: Store documents on a server and locally
- :busts_in_silhouette: Collaborate with others and merge changes from multiple users

Git organizes projects in repositories. One of them is the LTE Bama template. We will now create a derived version and clone it to your local machine.

**:computer: Setup**

- Install on your Linux/[Windows](https://gitforwindows.org/)/Mac
- Launch the git command line
- Get a ssh key which identifies your machine

Use the instructions on the [SSH Keys settings page](https://git.lte.e-technik.uni-erlangen.de/-/profile/keys). As also explained on the website a new key can be generated using `ssh-keygen -t ed25519 -C "email_address@fau.de"`. The password can be left blank otherwise it is required for every interaction with the server. The public key has to be added on the website.

**:hammer: Fork the template**

Create a copy of the template which is editable for writing the thesis. Therefore open the [templates repository](https://git.lte.e-technik.uni-erlangen.de/lehre-public/bama_latex_vorlage) and hit the `Fork` button.

It is recommended to make your new repository only visible for yourself using `Settings -> General -> Visibility, project features, permissions`.

**:incoming_envelope: Create a local copy**

Keep using the git command line and navigate to the folder where you want to store the local copy. Then clone the repository `git clone url` with the url shown on the webpage of your fork when pressing the blue `Clone` button on the top right (`https://git.lte.e-technik.uni-erlangen.de/lehre-public/bama_latex_vorlage.git`). Outside the institutes network the LTE gitlab can only be accessed via https and not ssh, therefore https may be beneficial.

The new folder contains a `.git` folder. It stores version information. Do not delete it.

Git supports multiple branches of one repository. They can contain changes made by different people until they have made all necessary changes and they can be merged again. Creating a new branch for your thesis makes it easy to merge updates of the template to your thesis. Create a new branch using e.g. `git branch bachelor` and switch to it `git checkout bachelor`.

**:pencil2: Working with git**

You are now ready to make changes to the thesis. Afterwards you can add the changes to the git history and the online repository. Note that git is not equally well suited for all types of files:

- :smiley: All sorts of text files.
- :unamused: Binary images are ok if they are not huge and do not change regularly.
- :rage: Binary files like MS Office documents are unsuited for use with git since no incremental information can be stored and thus the repositories size quikly increases. Compilation results (pdfs in this case) are normally also excluded from the repository.

command | purpose
--- | ---
:star: `git status` | Show the current branch and changes which will (not) be applied.
:star: `git add filename` / `git add .` | Marks a file or folder as to be included in the next version. `.` is the abbreviation for the current folder and can be used for adding all files. Unwanted files can be excluded using `.gitignore` files.
:star: `git commit -m 'some commit message'` | Adds a new commit (new version) including the `added` changes with a short explanation.
`git reset --hard HEAD` | :warning: Discards all changes since the last commit. They can NOT be restored.
`git log` | Shows previous commits and there keys. Exit with q.
`git branch` | Create a new branch.
`git checkout target` | Switches to another branch or a commit using its sha key.
`git merge source` | Merges the source branch into the current branch.
:star: `git pull origin branchname` | Gets (fetches) new commits from the server `origin` and merges! them to the corresponding local branch. Important when working on multiple machines.
`git fetch origin` | Only gets (fetches) new commits from the server `origin`.
`git remote -v` | Shows known urls of remote repositories.
`git remote add upstream url` | Adds a new remote repository under the name `upstream`.
`git remote --set-url upstream url` | Changes the url of the repository `upstream`.

**:sunglasses: Non-Elementary git usage**

The template can be updated or modified by including its repository to your thesis. It can be added under the name `upstream` using the following command: `git remote add upstream git@git.lte.e-technik.uni-erlangen.de:lehre-public/bama_latex_vorlage`.

To update the template fetch changes from the template `git fetch upstream master` and merge them into your thesis `git checkout bachelor`, `git merge upstream/master`. If you are unsure about the process consider making a backup.

To propose changes to the template prepare a merge request:
1. Make sure to have set `upstream`
2. Make sure not to overwrite your thesis branch !! (make a copy if you are not sure)
3. Update the current branch with `git fetch upstream` + `git checkout origin current` + `git merge upstream/current`
4. Make a branch `git branch myfancyfix`
5. Switch to new branch `git checkout myfancyfix`
6. Make your improvements
7. git add, commit, and push to origin as you always do
8. Open your forked project on the gitlab site `-> Merge requests -> New merge request` select `myfancyfix` as origin and `lehre_public/current` as target
9. Wait for someone to accept or ask you something about your merge request
10. Update your project from upstream to get the new updates

## :package: Compiling the LaTeX template

If you have obtained your local copy you are ready to compile the document. There are more possibilities how to compile the document, but we have already used the following:

**texlive + TeXstudio on Manjaro Linux / Ubuntu (WSL) / Windows**

- install texlive from their website or your Linux distributions repositories
- install texstudio from their website or your Linux distributions repositories

As the commands for compilation are inserted in `thesis.tex` this file can be opened and compiled by TeXstudio without further setup.

**miktex portable with TeXmaker on Windows**

I had issues with several packages under miktex until they worked properly so the recommended version is texlive.

- install miktex from their website (for the portable mode you have to rename the installer)

Use the `make.bat` file in the command line using `make.bat thesis` to compile the document. As you probably have other paths than I do you have to adjust the file.

**VS Code with Latex Workshop**

It is strongly recommended to use texlive with Latex Workshop. VS Code settings are included in the `.vscode` folder and should be loaded automatically. For more information, see [Latex Workshop](https://github.com/James-Yu/LaTeX-Workshop/wiki).

**CIP Pool**

LTEs computer pool may have several installations of TeX available. Windows and also TeXstudio chooses the one which is listed first in the `%PATH%` variable. The content of the variable is shown by running `echo %PATH%` in the `cmd`. You may add the absolute path of your preferred TeX distribution to the commands used by TeXstudio under `Optionen` -> `TeXstudio konfigurieren` -> `Befehle`. The bama template may only work with a recent distribution.

**Manual compilation steps**

- `lualatex -shell-escape ${filename}.tex`
- `biber ${filename}` 
- `lualatex -shell-escape ${filename}.tex`
- `makeindex ${filename}.idx` (index is not included in the template anymore)
- `lualatex -shell-escape ${filename}.tex`

## :closed_book: Bibliography data

Bibliography data for citation is stored in the file [`bibliography.bib`](https://git.lte.e-technik.uni-erlangen.de/lehre-public/bama_latex_vorlage/-/blob/future/bibliography/bibliography.bib). It can be edited with a text editor however it is more comfortable using a special application like JabRef or kbibtex which support:

- Import of citations from IEEExplore and similar
- Import of citations from clipboard
- Import of citations from LTE thesis (drag and drop a thesis into JabRef)
- Categories for organizing sources
- Linking of pdfs for easy access

The template is setup to link the URL and/or DOI of the reference into the PDF. The title of a publication in the reference sections will be clickable for easy access of the source.

## :factory: Using the LaTeX template

First of all you should check if the original version compiles correctly. Then you can start editing:

**thesis.tex**

Is the main document that you need to compile.

1. Set the variables at the beginning of the file according to your thesis, but note that these variables will also be included in the metadata of the pdf so they may not support special characters or LaTeX code. You can check the metadata with a pdf viewer.
2. You can include additional packages or use one of the headers available with the template in the `header` folder.
3. Include your chapters. For some chapters there are include statements already prepared. Of course you can also create other chapter files.

**header/**

contains package include instructions and settings for more specialized packages. You may use and improve them. Consider making a merge request if you have enhanced them.

**chapter/lte.tex**

contains furhter information about the template and hints for creating your thesis.

**graphics/**

folder for binary images. An overview of LaTeX suited image formats:

filetype | suitability
--- | ---
pdf with embedded LaTeX | Vector graphics with support for LaTeX commands and matches fonts, Causes sometimes scaling issues
pdf | Vector graphics with only fixed fonts
pgf | Commands for drawing graphics directly in TeX using the pgf package. Supports LaTeX commands and matches fonts. Good option for exporting from pythons matplotlib.
svg | Need to be converted.
jpg, png, tif, ... | Pixel graphics are always a bad choice except for photographies.

**standalones/**

[Standalone](https://www.ctan.org/pkg/standalone) is a LaTeX package that allows to create e.g. diagrams in seperate documents and include them later in the large document. The template contains the example `filter`. It can be build seperately for fast compilation. When compiling the complete `thesis` they will also be updated.

:bulb: standalone supports including diagrams as tex and pdf. pdf build option only works if the standalone document is in the same folder or a subfolder of the main document.

For drawing diagrams the packages [pgf (low level)](https://www.ctan.org/pkg/pgf), [tikz (higher level)](https://www.ctan.org/pkg/pgf), [circuitikz (circuits)](https://www.ctan.org/pkg/circuitikz) and [pgfplots (diagrams)](https://www.ctan.org/pkg/pgfplots) are commonly used.

You may also include them in your [presentation](https://github.com/FAU-AMMN/fau-beamer) without having to copy the standalones sources.

:bulb: If font sizes of standalone and final document do not match text appears resized. Consider adjusting the default font sizes in both main documents to be the same.

## :pencil2: Tips & Tricks

Important tips and hints for writing your thesis can be gathered from reading Jens Kirchners slides living also on the gitlab [Abschlussarbeiten am LTE](https://git.lte.e-technik.uni-erlangen.de/lehre-public/abschlussarbeiten-am-lte)

## :blue_book: Finishing the thesis

Pre-print checklist:

- Table of contents is fully populated and page numbers look correct.
- Bibliography is fully populated.
- No empty sections :smirk:
- Make sure to have set the `final` flag (No date in footer)
- :point_right: Nerds only: Check if the document fullfills the PDF/A-2b standard (Adobe Acrobat Pro can do that, as well as some other tools)

Printing:

- Printing is done by your supervisor at LTE and you save the money for printing :dollar:
- Sign the declaration
- The binding of the thesis can be done in a local copy shop. Cost is about 10 €.
- Burn a CD with a digital copy and generated data and insert it onto the last page of one copy.

Handing in:

- One copy goes to the secretariat and gets a stamp which confirms in time hand-in the other is kept by the supervisor.

Presentataion:

- Held after hand-in.
- Template available on github: [fau-beamer](https://github.com/FAU-AMMN/fau-beamer)

## :paperclip: Questions or Remarks

For resolving problems with the template use the following procedure:

- Check this readme
- Check the comments in `thesis.tex` and the demo text.
- Check the [issues](https://git.lte.e-technik.uni-erlangen.de/lehre-public/bama_latex_vorlage/-/issues) of the repository on the LTE gitlab server
- Try to locate the issue or even fix it. Package documentations on [ctan](https://www.ctan.org) and [stackexchange](https://stackoverflow.com/) are your friends :beers:
- Ask your supervisor for help
- Create a new issue (preferred) or write an e-mail

Sharing solutions helps other students :+1:. Consider making a merge request or sharing the information in form of an issue or an e-mail.
