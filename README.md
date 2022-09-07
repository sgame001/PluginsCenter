# PluginsCenter

该工程里包含UE4.26/UE4.27/UE5工程.插件代码共享`PluginsSource`中的源码.

右键管理员身份运行`LinkSource.bat`批处理文件自动关联.

```powershell
@echo off 
%~d0
cd %~sdp0
:: 不同的引擎版本 Engine version
set EVs=PluginsCenter_4_26 PluginsCenter_4_27 PluginsCenter_5
:: 共享的插件代码
set Plugins=Unworld UnworldEditor UWSocket UWArtTools
:: 遍历执行mklink
for %%e in (%EVs%) do ( 
	for %%p in (%Plugins%) do ( 
	  mklink /D %%e\Plugins\%%p\Source %~dp0\PluginsSource\%%p\Source
	)
)
pause
```

由于不同版本之间共享源码，在开发过程中要考虑到同的版本API的变化，使用如下标签判断。

.cpp/.h

```c++
#if ENGINE_MAJOR_VERSION == 4 && ENGINE_MINOR_VERSION == 26

#elif ENGINE_MAJOR_VERSION == 5

#else
	
#endif
```

Build.cs

```
if (Target.Version.MajorVersion == 5)
{
  
}
```

截图

## Dashboard

### 大纲

![关卡列表](Images/关卡列表.png)

### 放置

![放置工具](Images/放置工具.png)

### 预览

![预览](Images/预览.png)

### 常用设置

![常用设置](Images/常用设置.png)

### 安卓打包

![安卓打包](Images/安卓打包.png)

### Windows打包

![Windows打包](Images/Windows打包.png)

## 常用设置

### Actor

![常用设置-Actor](Images/常用设置-Actor.png)

### Sequencer

![常用设置-Sequencer](Images/常用设置-Sequencer.png)

### Settings

![常用设置-Settings](Images/常用设置-Settings.png)

## 材质修改

### 原始资产

![材质修改-原始资产](Images/材质修改-原始资产.png)

### 替换父项

![材质修改-替换父项](Images/材质修改-替换父项.png)

### 设置属性

![材质修改-设置属性](Images/材质修改-设置属性.png)

### Niagara

![材质修改-Niagara](Images/材质修改-Niagara.png)

### 替换材质

![材质修改-替换材质球](Images/材质修改-替换材质球.png)

### 材质函数

![材质修改-材质函数](Images/材质修改-材质函数.png)

### 材质内部

![材质修改-材质内部](Images/材质修改-材质内部.png)

## 选择物体

### 选择对象

![选择物体-选择对象](Images/选择物体-选择对象.png)

### 操作Actor

![选择物体-操作Actor](Images/选择物体-操作Actor.png)

### 操作Uobject

![选择物体-操作Uobject](Images/选择物体-操作Uobject.png)

## 资产操作

### 重命名

![资产操作-重命名](Images/资产操作-重命名.png)

### 替换引用

![资产操作-替换引用](Images/资产操作-替换引用.png)

### 整理资产

![资产操作-整理资产](Images/资产操作-整理资产.png)

## Stat

![stat-command](Images/stat-command.png)



