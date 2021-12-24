string fpsInfoText = "FPS", scriptTitle = "";
uint maxFps = 150, targetFps = 80;
bool isGameScene = false;

[Setting category="General" name="In Game FPS Only"] 
bool Setting_InGameFPS = false;

[Setting category="General" name="Show Frames Manager"] 
bool Setting_ShowPlugin = false;

[Setting category="General" name="Show Text UI"] 
bool Setting_ShowText = false;

[Setting category="Window" name="Window Size" drag min=100 max=1920] 
vec2 Setting_ViewSize(200, 230);

[Setting category="Window" name="Window Position" drag min=0 max=1920] 
vec2 Setting_ViewPos(0, 420);

[Setting category="Shortcuts" name="Show/Hide Frames Manager Key"] 
VirtualKey Setting_ShowUiKey = VirtualKey::F5;

[Setting category="Shortcuts" name="Show/Hide Text UI Key"] 
VirtualKey Setting_ShowTextKey = VirtualKey::F6;

[Setting category="UI" name="X position" min=0 max=1]
float Setting_TextX = 0.514;

[Setting category="UI" name="Y position" min=0 max=1]
float Setting_TextY = 0.047;

[Setting category="UI" name="Font size" min=15 max=30]
int Setting_FontSize = 20;

[Setting category="UI" name="Color RGB" min=0 max=1]
vec4 Setting_TextColorRGB(0,1,0,1);

[Setting category="UI" name="Color Hex" min=0 max=255]
string Setting_TextColorHex = "#85FF99";

[Setting category="UI" name="Show Text Frame"] 
bool Setting_ShowTextFrame = false;