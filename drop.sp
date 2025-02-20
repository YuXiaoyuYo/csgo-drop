#pragma semicolon 1
#include <cstrike>
#include <sourcemod>
#include <sdktools>
public Plugin:myinfo = {
    name = "Drop",
    author = "YuXiaoyu",
    description = "CS:GO Drop Knife For Teammate",
    version = "1.0",
    url = "https://yu.nm.cn"
};

bool g_Dropped[MAXPLAYERS + 1];

public OnPluginStart() {
    RegConsoleCmd("sm_drop", Cmd_drop, "Drop your knife");
    HookEvent("round_start", Event_RoundStart);
}

public Action:Cmd_drop(client, args) {
    if(g_Dropped[client])
        return Plugin_Handled;
    for(int i = 0;i < GetTeamClientCount(GetClientTeam(client));i++)
        GivePlayerItem(client, "weapon_knife");
    g_Dropped[client] = true;
    return Plugin_Handled;
}

public Action:Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    for(int i = 0; i < MAXPLAYERS; i++)
        g_Dropped[i] = false;
    return Plugin_Handled;  
}