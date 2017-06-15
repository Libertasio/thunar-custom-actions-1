<?xml version="1.0" encoding="UTF-8"?>
<!-- 
En/Decryption of files with GPG
include(tuca.m4)dnl
-->
<actions>
<action>
	<icon>gcr-gnupg</icon>
	<name xml:lang="de">Symmetrisch verschlüsseln mit GPG</name>
	<name xml:lang="en">Encrypt symmetrically with GPG</name>
	<command>TUCA_CMD(dnl
    PASSWORD=$(TUCA_PASSWORD(TUCA_TRANSLATE(File password))) || exit;dnl
    TUCA_PROGRESSBAR(dnl
        TUCA_LOOP(dnl
            TUCA_CREATE_FILE(dnl
                echo $PASSWORD | TUCA_GPG2() --batch --yes --passphrase-fd 0 --symmetric --armor -o TUCA_OUT() TUCA_IN(),dnl
                TUCA_FILE(),dnl input
                TUCA_FILE().asc,dnl output
                ),dnl
            TUCA_TRANSLATE(Encrypting),dnl loop description
            )dnl
        )dnl
    )</command>
    <description xml:lang="de">Die ausgewählten Dateien werden symmetrisch mit einem Password mit GPG verschlüsselt.</description>
    <description xml:lang="en">Each selected file is encrypted symmetrically with one given password with GPG.</description>
	<patterns>*</patterns>
	<audio-files/>
	<image-files/>
	<other-files/>
	<text-files/>
	<video-files/>
</action>
<action>
	<icon>gcr-gnupg</icon>
	<name xml:lang="de">Asymmetrisch verschlüsseln mit GPG</name>
	<name xml:lang="en">Encrypt asymmetrically with GPG</name>
	<command>TUCA_CMD(dnl
    RECIPIENT_KEY="$(TUCA_GPG2() --list-public-keys | TUCA_GPG2K_PARSER() |dnl 
        TUCA_ZENITY() --list --print-column=1 dnl
        --column="TUCA_TRANSLATE(Public Key)" dnl
        --column="TUCA_TRANSLATE(Name)" dnl
        --column="TUCA_TRANSLATE(Email)")";dnl
    TUCA_GPG_AGENT() --pinentry-program="TUCA_PINENTRY_GTK_2()";dnl
    TUCA_PROGRESSBAR(dnl
        TUCA_LOOP(dnl
            TUCA_CREATE_FILE(dnl
                TUCA_GPG2() --batch --yes --recipient "$RECIPIENT_KEY" dnl
                    --encrypt --armor --trust-model always dnl
                    --output TUCA_OUT() TUCA_IN(),dnl
                TUCA_FILE(),dnl input
                TUCA_FILE().gpg,dnl output
                ),dnl
            TUCA_TRANSLATE(Encrypting),dnl loop description
            )dnl
        )dnl
    )</command>
    <description xml:lang="de">Die ausgewählten Dateien werden asymmetrisch mit GPG verschlüsselt.</description>
    <description xml:lang="en">Each selected file is encrypted asymmetrically with GPG.</description>
	<patterns>*</patterns>
	<audio-files/>
	<image-files/>
	<other-files/>
	<text-files/>
	<video-files/>
</action>
<action>
	<icon>gcr-gnupg</icon>
	<name xml:lang="de">Entschlüsseln mit GPG</name>
	<name xml:lang="en">Decrypt with GPG</name>
	<command>TUCA_CMD(dnl
    TUCA_GPG_AGENT() --pinentry-program="TUCA_PINENTRY_GTK_2()";dnl
    TUCA_PROGRESSBAR(dnl
        TUCA_LOOP(dnl
            TUCA_CREATE_FILE(dnl
                TUCA_GPG2() --batch --yes --decrypt -o TUCA_OUT() TUCA_IN() || dnl
                TUCA_ERROR(TUCA_TRANSLATE(Could not decrypt $TUCA_FILE_BASE_VAR(). Wrong password?));dnl
                ,dnl command
                TUCA_FILE(),dnl input
                $(dirname TUCA_FILE())/$(basename TUCA_FILE() | TUCA_PERL() -pe 's#\.\w+<~$~>##g'),dnl output name
                ),dnl
            TUCA_TRANSLATE(Decrypting),dnl loop description
            )dnl
        )dnl
    )</command>
    <description xml:lang="de">Die ausgewählten Dateien werden mit GPG entschlüsselt.</description>
    <description xml:lang="en">Each selected file is decrypted with GPG.</description>
	<patterns>*.asc;*.pgp;*.gpg</patterns>
	<other-files/>
</action>
</actions>

