#pragma rtGlobals=3		// Use modern global access method and strict wave access.#pragma hide = 1//****************************************************************//****************************************************************////	NeuroMatic: data aquisition, analyses and simulation software that runs with the Igor Pro environment//	Copyright (C) 2017 Jason Rothman////    This program is free software: you can redistribute it and/or modify//    it under the terms of the GNU General Public License as published by//    the Free Software Foundation, either version 3 of the License, or//    (at your option) any later version.////    This program is distributed in the hope that it will be useful,//    but WITHOUT ANY WARRANTY; without even the implied warranty of//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the//    GNU General Public License for more details.////    You should have received a copy of the GNU General Public License//    along with this program.  If not, see <https://www.gnu.org/licenses/>.////	Contact Jason@ThinkRandom.com//	www.NeuroMatic.ThinkRandom.com////****************************************************************//****************************************************************////	NeuroMatic Menu Functions////****************************************************************//****************************************************************Menu "NeuroMatic"	Submenu StrVarOrDefault( NMDF + "NMMenuDataFolder" , "\\M1(Data Folder" )		StrVarOrDefault( NMDF + "NMMenuDataFolderList" , "" ), /Q, NMMenuFolderCall()	End		Submenu StrVarOrDefault( NMDF + "NMMenuDataWaves" , "\\M1(Data Waves" )		StrVarOrDefault( NMDF + "NMMenuDataWavesList" , "" ), /Q, NMMenuDataWavesCall()	End		Submenu StrVarOrDefault( NMDF + "NMMenuClampStim" , "\\M1(Clamp Data" )		StrVarOrDefault( NMDF + "NMMenuClampStimList" , "" ), /Q, NMMenuClampStimCall()	End		Submenu StrVarOrDefault( NMDF + "NMMenuAnalysis" , "\\M1(Analysis" )		StrVarOrDefault( NMDF + "NMMenuAnalysisList" , "" ), /Q, NMMenuAnalysisCall()	End		Submenu StrVarOrDefault( NMDF + "NMMenuShortcuts" , "\\M1(Keyboard Shortcuts" )		StrVarOrDefault( NMDF + "NMMenuShortcutsList" , "" ), /Q, NMMenuSetsCall()	End		"-"		Submenu StrVarOrDefault( NMDF + "NMMenuTabs" , "\\M1(Tabs" )		StrVarOrDefault( NMDF + "NMMenuTabsList" , "" ), /Q, NMMenuTabsCall()	End		Submenu StrVarOrDefault( NMDF + "NMMenuConfigs" , "\\M1(Configurations" )		StrVarOrDefault( NMDF + "NMMenuConfigsList" , "" ), /Q, NMMenuConfigsCall()	End		Submenu StrVarOrDefault( NMDF + "NMMenuWindows" , "\\M1(Windows" )		StrVarOrDefault( NMDF + "NMMenuWindowsList" , "" ), /Q, NMMenuWindowsCall()	End		Submenu "Procedures"		"Unhide", /Q, NMCall( "Unhide Procedures" )		"Hide", /Q, NMCall( "Hide Procedures" )		"Kill", /Q, NMCall( "Kill Procedures" )		"Find Deprecated Functions", /Q, NMCall( "Find Deprecated" )		"-"				Submenu "Misc"			NMMenuProceduresList( "misc" ), /Q, NMMenuProceduresCall()		End				Submenu "Tabs"			NMMenuProceduresList( "tabs" ), /Q, NMMenuProceduresCall()		End				Submenu "Model"			NMMenuProceduresList( "model" ), /Q, NMMenuProceduresCall()		End				Submenu "Clamp"			NMMenuProceduresList( "clamp" ), /Q, NMMenuProceduresCall()		End				Submenu "Paper"			NMMenuProceduresList( "paper" ), /Q, NMMenuProceduresCall()		End			End		"-"		StrVarOrDefault( NMDF + "NMMenuOn","Turn On" ), /Q, NMMenuOnToggle()	StrVarOrDefault( NMDF + "NMMenuUpdate","" ), /Q, NMCall( "Update" )	"Webpage", /Q, NMCall( "Webpage" )	"Contact", /Q, NMCall( "Contact" )	"Demo", /Q, NMCall( "Demo" )	"About", /Q, NMCall( "About" )End // NeuroMatic Menu//****************************************************************//****************************************************************Function NMMenuFolderCall()	GetLastUserMenuInfo // sets S_value, V_value, etc.		NMFolderCall( S_value )	End // NMMenuFolderCall//****************************************************************//****************************************************************Function NMMenuClampStimCall()	String stimDF = SubStimName( "" )	GetLastUserMenuInfo // sets S_value, V_value, etc.		if ( StringMatch( S_value, stimDF ) )		return SubStimCall( "Details" )	endif		strswitch( S_value )		case "Notes Table":		case "Print Notes":			return NMCall( S_value )	endswitch		return SubStimCall( S_value )End // NMMenuClampStimCall//****************************************************************//****************************************************************Function /S NMMenuDataWavesCall()	GetLastUserMenuInfo // sets S_value, V_value, etc.		strswitch( S_value )		case "Rename":			return NMFolderCall( "Rename Waves" )		case "Make":			return NMMainCall( "Make", "" )		default:			NMFileCall( S_value )	endswitch		End // NMMenuDataWavesCall//****************************************************************//****************************************************************Function NMMenuAnalysisCall()	GetLastUserMenuInfo // sets S_value, V_value, etc.		strswitch( S_value )		case "Stability | Stationarity":			return NMCall( "Stability" )		case "Significant Difference":			return NMCall( "KSTest" )		case "Convert Gauss Width":		case "Print Output Wave List":		case "Print Output Window List":			return NMCall( S_value )	endswitch		End // NMMenuAnalysisCall//****************************************************************//****************************************************************Function NMMenuSetsCall()	GetLastUserMenuInfo // sets S_value, V_value, etc.		strswitch( S_value )		case "Next Wave":			return NMCall( "Next Wave" )		case "Previous Wave":			return NMCall( "Previous Wave" )		default:			if ( strsearch( S_value, "Checkbox", 0 ) > 0 )				NMCall( "Set" + num2istr( V_value - 3) + " Toggle" )			endif	endswitch	End // NMMenuSetsCall		//****************************************************************//****************************************************************Function NMMenuTabsCall()	GetLastUserMenuInfo // sets S_value, V_value, etc.		return NMCall( S_value + " Tab" )End // NMMenuTabsCall//****************************************************************//****************************************************************		Function NMMenuConfigsCall()	GetLastUserMenuInfo // sets S_value, V_value, etc.		strswitch( S_value )		case "Save":			if ( NMConfigsAutoOpenSave )				NMConfigsSaveToPackages()				return 0			else				return NMConfigCall( "Save" )			endif		case "Save As":			return NMConfigCall( "Save" )		default:			return NMConfigCall( S_value )	endswitchEnd // NMMenuConfigsCall		//****************************************************************//****************************************************************		Function NMMenuWindowsCall()	GetLastUserMenuInfo // sets S_value, V_value, etc.		strswitch( S_value )		case "Make NM Panel":			return NMCall( "NM Panel" )		case "Save NM Panel Position":			return NMCall( "NM Panel Save Position" )		case "Move Progress Window":			return NMCall( "Progress XY" )		case "Reset Window Cascade":			return NMCall( "Reset Cascade" )		case "Display Channel Graphs":			return NMCall( "Chan Graphs On" )		case "Reposition Channel Graphs":			return NMCall( "Chan Graphs Reposition" )		case "Reposition Command Window":			return NMCall( "Reposition Command Window" )	endswitchEnd // NMMenuWindowsCall//****************************************************************//****************************************************************		Function NMMenuProceduresCall()	GetLastUserMenuInfo // sets S_value, V_value, etc.		Execute /Z "SetIgorOption IndependentModuleDev = 1"	DisplayProcedure /W=$S_valueEnd // NMMenuProceduresCall//****************************************************************//****************************************************************Function NMMenuBuild()	Variable icnt	String folderList = "", clampList = "", dataList = "", analysisList = ""	String tabsList = "", configsList = "", windowList = "", shortcutsList = ""	String setName, tabName, stimDF, notesDF,  ostr = "\\M1("		String tabList = TabNameList( NMTabControlList() )		Variable on = NMVarGet( "NMOn" )		if ( on )		ostr = ""		folderList = "Open Data Files;Open All Data Files Inside Subfolders;File Name Replace Strings;-;New;Close;Save;Duplicate;Rename;Change;Check NM Globals;-;Save All;Close All;-;Set Open Path;Set Save Path;"	endif		SetNMstr( NMDF + "NMMenuDataFolder", ostr + "Data Folder" )	SetNMstr( NMDF + "NMMenuDataFolderList", folderList )		if ( on )			stimDF = SubStimName( "" )		notesDF = GetDataFolder( 1 ) + "Notes:"			if ( ( strlen( stimDF ) > 0 ) && DataFolderExists( stimDF ) )					SetNMstr( NMDF + "NMMenuClampStim", "Clamp Data" )			clampList = stimDF + ";-;Pulse Table;ADC Table;DAC Table;TTL Table;Stim Waves;"						if ( ( strlen( notesDF ) > 0 ) && DataFolderExists( notesDF ) )				clampList += "-;Notes Table;Print Notes;"			endif					else					SetNMstr( NMDF + "NMMenuClampStim", "\\M1(Clamp Data" )			clampList = "No Stim;"					endif			else			SetNMstr( NMDF + "NMMenuClampStim", "\\M1(Clamp Data" )		endif		SetNMstr( NMDF + "NMMenuClampStimList", clampList )		if ( on )		dataList = "Load;Load From Folder;File Name Replace Strings;-;Reload;Save;Rename;Make;"	endif		SetNMstr( NMDF + "NMMenuDataWaves", ostr + "Data Waves" )	SetNMstr( NMDF + "NMMenuDataWavesList", dataList )		if ( on )		analysisList = "Stability | Stationarity;Significant Difference;Convert Gauss Width;-;Print Output Wave List;Print Output Window List;"	endif		SetNMstr( NMDF + "NMMenuAnalysis", ostr + "Analysis" )	SetNMstr( NMDF + "NMMenuAnalysisList", analysisList )		if ( on )		tabsList = "Add;Remove;"	endif		SetNMstr( NMDF + "NMMenuTabs", ostr + "Tabs" )	SetNMstr( NMDF + "NMMenuTabsList", tabsList )		if ( on )		if ( NMConfigsAutoOpenSave )			configsList = "Edit;Save;Save As;Open;Reset;"		else			configsList = "Edit;Save;Open;Reset;Turn Auto Configs On;"		endif	endif		SetNMstr( NMDF + "NMMenuConfigs", ostr + "Configurations" )	SetNMstr( NMDF + "NMMenuConfigsList", configsList )		if ( on )		windowList = "Make NM Panel;Save NM Panel Position;Move Progress Window;Reset Window Cascade;Reposition Command Window;-;Display Channel Graphs;Reposition Channel Graphs;"	endif		SetNMstr( NMDF + "NMMenuWindows", ostr + "Windows" )	SetNMstr( NMDF + "NMMenuWindowsList", windowList )		if ( on )		SetNMstr( NMDF + "NMMenuOn", "Turn Off" )		SetNMstr( NMDF + "NMMenuUpdate", "Reinitialize" )	else		SetNMstr( NMDF + "NMMenuOn", "Turn On" )		SetNMstr( NMDF + "NMMenuUpdate", "" )	endif		if ( on )			shortcutsList = "Next Wave/0;Previous Wave/9;"				setName = NMSetsDisplayName( 0 )					if ( strlen( setName ) > 0 )			shortcutsList += setName + " Checkbox/1;"		endif				setName = NMSetsDisplayName( 1 )						if ( strlen( setName ) > 0 )			shortcutsList += setName + " Checkbox/2;"		endif				setName = NMSetsDisplayName( 2 )						if ( strlen( setName ) > 0 )			shortcutsList += setName + " Checkbox/3;"		endif			endif		SetNMstr( NMDF + "NMMenuShortcuts", ostr + "Keyboard Shortcuts" )	SetNMstr( NMDF + "NMMenuShortcutsList", shortcutsList )		for ( icnt = 0 ; icnt < ItemsInList( tabList ) ; icnt += 1 )			tabName = StringFromList( icnt, tabList )				if ( exists( "NMMenuBuild" + tabName ) == 6 )			Execute /Q/Z "NMMenuBuild" + tabName + "()"		endif			endfor		BuildMenu "NeuroMatic"End // NMMenuBuild//****************************************************************//****************************************************************Function /S NMMenuProceduresList( select )	String select	String allList = "", tabList = "", modelList = "", clampList = "", paperList = ""	Execute /Z "SetIgorOption IndependentModuleDev = ?"		Variable saveIMD = NumVarOrDefault( "V_Flag", NaN )		Execute /Z "SetIgorOption IndependentModuleDev = 1" // unhide procedures		allList = SortList( WinList( "NM_*", ";", "WIN:128" ), ";", 16 )	tabList = SortList( WinList( "NM_*Tab*", ";", "WIN:128" ) )	clampList = SortList( WinList( "NM_Clamp*", ";", "WIN:128" ), ";", 16 )	modelList = SortList( WinList( "NM_Model*", ";", "WIN:128" ), ";", 16 )	paperList = SortList( WinList( "NM_Paper*", ";", "WIN:128" ), ";", 16 )		Execute /Z "SetIgorOption IndependentModuleDev = " + num2istr( saveIMD )		tabList = RemoveFromList( modelList, tabList )	tabList = RemoveFromList( clampList, tabList )		allList = RemoveFromList( tabList, allList )	allList = RemoveFromList( modelList, allList )	allList = RemoveFromList( clampList, allList )	allList = RemoveFromList( paperList, allList )		strswitch( select )			case "misc":			return allList					case "tabs":			return tabList			case "clamp":			return clampList					case "model":			return modelList					case "paper":			return paperList		endswitchEnd // NMMenuProceduresList//****************************************************************//****************************************************************Function NMMenuOnToggle()	if ( IsNMon() )		NMon( 0 )	else		NMon( 1 )	endif	End // NMMenuOnToggle//****************************************************************//****************************************************************Function /S AboutNM() // executes every time NM menu is accessed	CheckNMVersion()		return ""	//return "About NeuroMatic"	End // AboutNM//****************************************************************//****************************************************************Function NMCall( fxn )	String fxn		String setList = NMSetsDisplayList()		strswitch( fxn )					case "Stability":		case "Stationarity":			Execute "NMStabilityCall0()"			return 0				case "KSTest":			Execute "NMKSTestCall()" // NM_Kolmogorov.ipf			return 0					case "Convert Gauss Width":			return NMGaussWidthConvertCall()					case "Print Output Wave List":			NMOutputWaveList( history = 1 )			return 0					case "Print Output Window List":			NMOutputWinList( history = 1 )			return 0			case "Update":			return ResetNM( 0, quiet = 0, history = 1 )			case "Add Tab":			return NMTabAddCall()					case "Remove Tab":			return NMTabRemoveCall()					case "Kill Tab":			return NMTabKillCall()					case "Progress XY":			return NMProgressXYPanel()			//case "History":		//	return NMHistoryCall()					//case "CmdHistory":		//	return NMCmdHistoryCall()					case "Panel":		case "Main Panel":		case "NM Panel":			return MakeNMPanel( history = 1 )					case "NM Panel Save Position":			return NMPanelSaveXY()					case "Reposition Command Window":			return NMCommandWindowReposition()					case "Graphs On":		case "Chan Graphs On":			return NMChannelGraphSet( channel = -2, on = 1, history = 1 )					case "Graphs Reset":		case "Chan Graphs Reset":		case "Chan Graphs Reposition":			return NMChannelGraphSet( channel = -2, reposition = 1, history = 1 )					case "Reset Cascade":			return NMSet( winCascade = 0, history = 1 )					case "Next":		case "Next Wave":			return NMNextWave( +1, history = 0 )					case "Last":		case "Previous":		case "Previous Wave":			return NMNextWave( -1, history = 0 )				case "Set0 Toggle":			return NMSetsToggleCall( StringFromList( 0, setList ) )				case "Set1 Toggle":			return NMSetsToggleCall( StringFromList( 1, setList ) )				case "Set2 Toggle":			return NMSetsToggleCall( StringFromList( 2, setList ) )					case "Off":			return NMOn( 0 )					case "On":			return NMOn( 1 )					case "Webpage":			return NMWebpage()					case "Contact":			return NMContact()					case "About":			return NMAbout()					case "Demo":			return NMDemoAnalysisCall()					case "Hide Procedures":			return NMProceduresHide( 1 )					case "Unhide Procedures":			return NMProceduresHide( 0 )					case "Kill Procedures":			return NMProceduresKill()					case "Find Deprecated":			NMDeprecationFindCall()			return 0					case "Notes Table":			NMNotesTable( 1 )			return 0					case "Print Notes":			return NMNotesPrint()					default:			NMDoAlert( "NMCall: unrecognized function call " + NMQuotes( fxn ) )		endswitch		return -1End // NMCall//****************************************************************//****************************************************************Function NMConfigCall( select )	String select	strswitch( select )			case "Edit":			return NMConfigEditCall( "" )					case "Kill":		case "Update":		case "Reset":			return NMConfigResetCall( "" )				case "Open":			return NMConfigOpen( "", history = 1 )				case "Save":			return NMReturnStr2Num( NMConfigSaveCall( "" ) )					case "Turn Auto Configs On":			return NMConfigsHowToSaveToPackages()				endswitchEnd // NMConfigCall//****************************************************************//****************************************************************