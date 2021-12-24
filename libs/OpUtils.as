namespace OpUtils
{
    // Public Properties and methods for Openplanet [Time API]. - Docs: https://openplanet.nl/docs/group/Time
    namespace Time
    {
        enum TIME_TYPE
        {
            TIME,
            MACHINE_TIME
        };

        Time::Info GetTimeInfo(TIME_TYPE timeType)
        {
            uint64 timeStamp = (timeType == TIME_TYPE::TIME) ? Time::get_Now() : Time::get_Stamp();
            Time::Info timeInfo = Time::Parse(timeStamp);
            return timeInfo;
        }

        string GetTimeFormatted(TIME_TYPE timeType, bool utcTime = false)
        {
            uint64 timeStamp = (timeType == TIME_TYPE::TIME) ? Time::get_Now() : Time::get_Stamp();
            string timeFormatted = Time::FormatString("%H:%M:%S", timeStamp);
            return timeFormatted;
        }

        string GetSystemTime(bool utcTime = false)
        {
            return GetTimeFormatted(TIME_TYPE::MACHINE_TIME, utcTime);
        }

        string GetGameTime(bool utcTime = false)
        {
            return GetTimeFormatted(TIME_TYPE::TIME, utcTime);
        }
    }

    // Public Properties and methods for Openplanet [UI API]. - Docs: https://openplanet.nl/docs/group/UI
    namespace UI
    {
        void ShowCheckedNotification(string notificationMsg, bool &out checked)
        {
            if (checked)
            {
                UI::ShowNotification(scriptTitle, notificationMsg);
                checked = false;
            }
        }
    }
    // Public Properties and methods for Openplanet [Meta API]. - Docs: https://openplanet.nl/docs/group/Meta
    namespace Meta
    {
        string GetScriptTitle(string icon = "")
        {
            string title = Meta::ExecutingPlugin().Name.Length == 0 ? "UNKNOWN-PLUGIN" : Meta::ExecutingPlugin().Name;
            string titleIcon = "\\$c6f" + icon + "\\$z " + title;
            return titleIcon;
        }
    }
}