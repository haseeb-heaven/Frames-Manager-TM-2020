auto Log = Logger::g_Logger;      // Typedef logger for ease.

void Main()
{
    scriptTitle = OpUtils::Meta::GetScriptTitle(Icons::ClockO);
    Log.AddLogInfo("Starting: '" + scriptTitle + "'....");
    auto tmApp = TmUtils::Trackmania::GetTmApp();

    while (true)
    {
        yield();
        isGameScene = TmUtils::MetaNotPersistent::GetScene() !is null;
        if (!Setting_ShowPlugin && Setting_InGameFPS)
            OpUtils::UI::ShowCheckedNotification("Please Enable FPS Manager", Setting_InGameFPS);
    }
    Log.AddLogInfo("Exiting: '" + scriptTitle + "'....");
}

string GetFPSPerformance(float fps)
{
    string fpsPerformance = "None";

    if (fps > 0 && fps < 30)
    {
        fpsPerformance = "Poor";
        Setting_TextColorHex = "#FF0D00";
    }
    else if (fps >= 30 && fps <= 60)
    {
        fpsPerformance = "Good";
        Setting_TextColorHex = "#85FF99";
    }
    else if (fps >= 70 && fps <= 120)
    {
        fpsPerformance = "Excelent";
        Setting_TextColorHex = "##FBFF00";
    }
    else if (fps > 120)
    {
        fpsPerformance = "Turbo";
        Setting_TextColorHex = "##00FFFB";
    }
    return fpsPerformance;
}

void UpdateFpsInfoText()
{
    if (Setting_ShowPlugin || Setting_ShowText)
    {
        TmUtils::System::SetSystemConfigDisplay_MaxFps(maxFps);
        TmUtils::Hms::SetViewport_TargetFps(targetFps);
        float avgFps = TmUtils::Hms::GetViewport().AverageFps;

        fpsInfoText = "Average: " + avgFps + " FPS" + "\n";
        fpsInfoText += "Target: " + TmUtils::Hms::GetViewport().TargetFps + " FPS" + "\n";
        fpsInfoText += "Max: " + TmUtils::System::GetSystemConfigDisplay().MaxFps + " FPS" + "\n";
        
        if (TmUtils::MetaNotPersistent::GetScene() !is null)
        {
            fpsInfoText += "Performance: " + GetFPSPerformance(avgFps) + "\n";
            if(Setting_InGameFPS)
            fpsInfoText += "Game Mode: " + TmUtils::Game::GetGameModeStatus() + "" + "\n";
        }
    }
}

void RenderMenu()
{
    if (UI::MenuItem(scriptTitle, "", Setting_ShowPlugin))
    {
        Setting_ShowPlugin = !Setting_ShowPlugin;
    }
}

void Render()
{
    if (Setting_ShowPlugin || Setting_ShowText)
    {
        if (Setting_ShowPlugin)
        {
            UI::Begin(scriptTitle, UI::WindowFlags::NoCollapse | UI::WindowFlags::NoResize);
            if (UI::IsItemHovered())
            {
                Setting_ViewPos = UI::GetWindowPos();
            }
            UI::SetWindowPos(Setting_ViewPos);
            UI::SetWindowSize(Setting_ViewSize);
            UI::SameLine();
            UI::Text(fpsInfoText);
            maxFps = UI::InputInt("Max", maxFps);
            targetFps = UI::InputInt("Target", targetFps);
            UI::End();
            if (Setting_InGameFPS && !isGameScene)
                return;
        }
        UpdateFpsInfoText();

        if (Setting_ShowText)
        {
            // Draw RoundedRect as Frame.
            if (Setting_ShowTextFrame)
            {
                float rectW = Setting_FontSize * 15;
                float rectH = rectW >= 180 ? (rectW - 180) : 120;
                nvg::BeginPath();
                nvg::RoundedRect(Setting_TextX * Draw::GetWidth() - 210, Setting_TextY * Draw::GetHeight() - 25, rectW, rectH, 10);
                nvg::FillColor(Text::ParseHexColor("#256654"));
                //nvg::FillPaint(nvg::LinearGradient(vec2(500, 100), vec2(500, 600),Text::ParseHexColor("#256654"), Text::ParseHexColor("#85ffdc")));
                nvg::Fill();
                nvg::ClosePath();
            }

            Setting_TextColorRGB = Text::ParseHexColor(Setting_TextColorHex);
            // Add Text into Frame.
            nvg::FontSize(Setting_FontSize);
            nvg::TextAlign(nvg::Align::Center | nvg::Align::Baseline);
            nvg::FillColor(Setting_TextColorRGB);
            nvg::TextBox(Setting_TextX * Draw::GetWidth() - 210, Setting_TextY * Draw::GetHeight(), 300, fpsInfoText);
        }
        nvg::Reset();
    }
}

bool OnKeyPress(bool down, VirtualKey key)
{
    if (key == Setting_ShowUiKey && down)
        Setting_ShowPlugin = !Setting_ShowPlugin;
    if (key == Setting_ShowTextKey && down)
        Setting_ShowText = !Setting_ShowText;
    return false;
}