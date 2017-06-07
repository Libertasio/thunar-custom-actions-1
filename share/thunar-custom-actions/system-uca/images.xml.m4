<?xml version="1.0" encoding="UTF-8"?>
<!-- 
Image manipulation Thunar custom actions
include(tuca.m4)dnl
-->
<actions>
<action>
	<icon>edit-redo</icon>
	<name xml:lang="de">im Uhrzeigersinn drehen</name>
	<name xml:lang="en">turn clockwise</name>
	<command>TUCA_LOOP(convert -rotate 90 TUCA_FILE TUCA_TEMP)</command>
	<description xml:lang="en">The selected images are turned clockwise.</description>
	<description xml:lang="de">Die ausgewählten Bilder werden im Uhrzeigersinn gedreht.</description>
	<patterns>*</patterns>
	<image-files/>
</action>
<action>
	<icon>edit-undo</icon>
	<name xml:lang="de">gegen den Uhrzeigersinn drehen</name>
	<name xml:lang="en">turn anti-clockwise</name>
	<command>TUCA_LOOP(convert -rotate 270 TUCA_FILE TUCA_TEMP)</command>
	<description xml:lang="en">The selected images are turned anti-clockwise.</description>
	<description xml:lang="de">Die ausgewählten Bilder werden gegen den Uhrzeigersinn gedreht.</description>
	<patterns>*</patterns>
	<image-files/>
</action>
<action>
	<icon>applications-graphics-symbolic</icon>
	<name xml:lang="de">in Graustufen umwandeln</name>
	<name xml:lang="en">convert to grayscale</name>
	<command>TUCA_LOOP(convert TUCA_FILE -set colorspace Gray -separate -average TUCA_TEMP)</command>
	<description xml:lang="de">arithmetische Mittelung aller Farbkanäle</description>
	<description xml:lang="en">The selected images are converted to grayscale by averaging the RGB-channels.</description>
	<patterns>*</patterns>
	<startup-notify/>
	<image-files/>
</action>
<action>
	<icon>image-missing</icon>
	<name xml:lang="de">Transparenz entfernen</name>
	<name xml:lang="en">remove transparency</name>
	<command>TUCA_LOOP(convert TUCA_FILE -alpha off TUCA_TEMP)</command>
	<description xml:lang="de">Bei den ausgewählten Bildern wird der Alphakanal entfernt.</description>
	<description xml:lang="en">The alpha channel is removed from the selected images.</description>
	<patterns>*</patterns>
	<image-files/>
</action>
<action>
	<icon>window-restore-symbolic</icon>
	<name xml:lang="de">auf halbe Größe skalieren</name>
	<name xml:lang="en">resize to 50% width</name>
	<command>TUCA_LOOP(convert TUCA_FILE -resize 50%% TUCA_TEMP)</command>
	<description xml:lang="de">Breite und Höhe der ausgewählten Bilder werden halbiert.</description>
	<description xml:lang="en">Width and height of the selected images are halved.</description>
	<patterns>*</patterns>
	<image-files/>
</action>
<action>
	<icon>window-restore-symbolic</icon>
	<name xml:lang="de">auf 75% Größe skalieren</name>
	<name xml:lang="en">resize to 75% width</name>
	<command>TUCA_LOOP(convert TUCA_FILE -resize 75%% TUCA_TEMP)</command>
	<description xml:lang="de">Breite und Höhe der ausgewählten Bilder werden auf 75% verringert.</description>
	<description xml:lang="en">Width and height of the selected images are shrinked to 75%.</description>
	<patterns>*</patterns>
	<image-files/>
</action>
</actions>
