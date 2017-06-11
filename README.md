# System-wide Thunar custom actions

The [Thunar file browser](http://docs.xfce.org/xfce/thunar/start) has this awesome [custom actions](http://docs.xfce.org/xfce/thunar/custom-actions) feature which can make working with Thunar pretty productive and personal.

Unfortunately, Thunar is not very flexible when it comes to the storing location of these custom actions: There is only one file `~/.config/Thunar/uca.xml` that can contain custom actions for that specific user. As far as I know, there is no possibility to define **system-wide** custom actions that apply to every user.

To have the same Thunar custom actions across your machines, you may synchronize the `uca.xml` file e.g. with Dropbox or [Syncthing](https://syncthing.net/). But still, I always find myself copy-pasting when I want to _share_ my custom actions with other people.

This is an attempt to realize **system-wide Thunar custom actions** that can easily be **updated and maintained**.

## How does it work?

At its heart, `thunar-custom-actions` is actually just the script (Makefile) `bin/uca-apply` that instructs the Python script `bin/uca-manip` to **merge** or **remove** the custom actions provided by `thunar-custom-actions` (the files `share/thunar-custom-actions/system-uca/*.xml`) into [the|each] user's Thunar configuration `~/.config/Thunar/uca.xml`.

The [Debian package](#debian-package) takes care of the actions provided by `thunar-custom-actions` automatically:

- **adding** them to the users' configurations on **package installation**
- **removing** them from the users' configurations on **package removal**
- **removing** the old, then **adding** the new actions on **package update**

The [manual installation](#manual-install) requires the user to do this himself.

The action merging/removal process is designed to **NOT touch the actions that were there before**! It *should* leave them totally untouched. So you *should* be safe to just try `thunar-custom-actions` and if you don't like it, uninstall it again without causing any damage to your configuration. But as always, you are encouraged to **backup your `~/.config/Thunar/uca.xml` file** before using `thunar-custom-actions` if you care about your already-defined custom actions.

## What can it do?

There are currently actions for:

- **rotating** images
- **shrinking** images
- **grayscaling** images
- **filling transparent areas** in images with a given color
- **converting** images to an A4 multi-page **PDF** document
- **concatenating** PDF documents into one
- **shrinking** PDF file sizes
- **de/encrypting** arbitrary files with GPG
- **finding big elements** in a folder
- **creating symbolic links** to files
 
Everything with a beautiful **progress bar** realized with `zenity`.
Of course, I tried to make everything work regardless of ugly characters (e.g. whitespace) in the filename.

![thunar-custom-actions-v0 0 8-ss1](https://user-images.githubusercontent.com/19148271/26882399-95e61d6a-4b9a-11e7-8ab3-de5eb34b3fb9.png)

![thunar-custom-actions-v0 0 8-ss2](https://user-images.githubusercontent.com/19148271/26882400-967bb906-4b9a-11e7-999c-0142a802dd22.png)

## Installation

I am testing `thunar-custom-actions` regularly on several different machines running **Xubuntu 16.04 LTS**. But as soon as you got it installed properly, it should work regardless of the system used. If you encounter any problems installing or using `thunar-custom-actions`, feel free to open a [new Issue here on GitHub](https://github.com/nobodyinperson/thunar-custom-actions/issues/new) and describe your problem.

<a name="debian-package"></a>
### Debian package

`thunar-custom-actions` is best installed via the Debian package obtainable at the [releases page](https://github.com/nobodyinperson/thunar-custom-actions/releases). Download the `*.deb`-package and install it like so:

```bash
sudo dpkg -i thunar-custom-actions-*.deb
```

### Apt repository (automatic updates)

If you use my [apt repository](http://apt.nobodyinperson.de), installation is even easier:

```bash
sudo apt-get update && sudo apt-get install thunar-custom-actions
```

Also, you will get automatic updates when using my repository.

<a name="manual-install"></a>
### By hand

You can also install `thunar-custom-actions` by hand. You may want to do that if you don't have root privileges on your machine, or you are using a distribution that does not utilise the `.deb` software package format.

```bash
# clone the repository
git clone https://github.com/nobodyinperson/thunar-custom-actions
cd thunar-custom-actions
./configure --prefix=$HOME/.local PASSWDFILE=/etc/passwd
make
make install
```

To merge the actions provided by `thunar-custom-actions` into your Thunar configuration, run:

```bash
uca-apply update
```

If you don't want them anymore, run:

```bash
uca-apply remove
```

To uninstall `thunar-custom-actions`, run from the git repository root:

```bash
make uninstall
```

To upgrade to the latest development version, run from the repository root:

```bash
uca-apply remove
make uninstall
git pull
./configure --prefix=$HOME/.local PASSWDFILE=/etc/passwd
make
make install
uca-apply update
```

## Troubleshooting

#### There are no new actions after the installation!

Close all `thunar` instances, run `thunar -q` from the terminal and then retry.

## How to contribute

Contributions are very welcome.

### Translations

This project uses **gettext** for localisation. The translation catalogues (`*.po`-files) can be found under the `locale` directory structured in the usual way. You may use the awesome translation program [poedit](https://github.com/vslavik/poedit) to edit them.

If you wanted to add a whole new language, do the following:

1. Clone the repository: `git clone https://github.com/nobodyinperson/thunar-custom-actions && cd thunar-custom-actions`
2. Create an empty new catalogue for your language, (e.g. Czech `cs`): `mkdir -p locale/cs/LC_MESSAGES && touch locale/cs/LC_MESSAGES/thunar-custom-actions.po`.
3. Configure the project with `./configure`.
4. Now we have a `Makefile` to build the project with `make`.
5. The newly created message catalogue can now be filled with e.g. [poedit](https://github.com/vslavik/poedit): `poedit locale/cs/LC_MESSAGES/thunar-custom-actions.po`.
6. After filling the message catalogue you may build and install the project as usual.
7. File a Pull Request on GitHub so I can include the new language into the code base.

If you encounter problems with translations not being applied, re-add the `thunar-custom-actions`: `uca-apply remove && uca-apply update`

### Custom actions

If you want to see one of your own custom actions come with `thunar-custom-actions`, take a look at the files under `share/thunar-custom-actions/system-uca`, add your changes there and then file a Pull Request. Alternatively, if you don't know how to do that or don't understand my system, you may also open a [new Issue here on GitHub](https://github.com/nobodyinperson/thunar-custom-actions/issues/new).
