@echo off 
%~d0
cd %~sdp0
:: 不同的引擎版本 Engine version
set EVs=PluginsCenter_4_26 PluginsCenter_4_27 PluginsCenter_5
:: 共享的插件代码
set Plugins=Unworld UnworldEditor UWSocket UWArtTools UWPreviz
:: 遍历执行mklink
for %%e in (%EVs%) do ( 
	for %%p in (%Plugins%) do ( 
		
	  mklink /D %%e\Plugins\%%p\Source %~dp0\PluginsSource\%%p\Source
	)
)


pause


