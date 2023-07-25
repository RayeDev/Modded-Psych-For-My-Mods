import backend.*;
#if desktop
import backend.Discord.DiscordClient;
import backend.Discord;
#end
import backend.Paths;
import backend.Controls;
import backend.Controls.Control;
import backend.Conductor.BPMChangeEvent;
import backend.Achievements;
import backend.StageData;
import backend.Section.SwagSection;
import backend.Song.SwagSong;
import backend.Cache;
import backend.Conductor.Rating;
import backend.Song;
import backend.ClientPrefs;
import backend.WeekData;

import cutscenes.CutsceneHandler;
import cutscenes.DialogueBox;
import cutscenes.DialogueBoxPsych;

import objects.*;
import objects.Alphabet;
import objects.Character;
import objects.Character.Boyfriend;
import objects.NoteSplash;
import objects.Note.EventNote;
import objects.MenuCharacter;
import objects.MenuItem;

import shaders.*;
import shaders.WiggleEffect.WiggleEffectType;

import states.*;
import states.editors.*;
import states.TitleState;
import states.PlayState;
import states.editors.ChartingState;
import states.editors.MasterEditorMenu;
import states.editors.CharacterEditorState;

import substates.*;
import substates.GameOverSubstate;
import substates.PauseSubState;
import substates.GameplayChangersSubstate;
import substates.ResetScoreSubState;

import misc.FunkinLua;
import misc.PlayerSettings;