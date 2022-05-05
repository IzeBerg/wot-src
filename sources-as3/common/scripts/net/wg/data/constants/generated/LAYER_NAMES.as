package net.wg.data.constants.generated
{
   public class LAYER_NAMES
   {
      
      public static const UNDEFINED:String = "";
      
      public static const ROOT:String = "root";
      
      public static const MARKER:String = "marker";
      
      public static const VIEWS:String = "view";
      
      public static const SUBVIEW:String = "subView";
      
      public static const TOP_SUB_VIEW:String = "topSubView";
      
      public static const WINDOWS:String = "window";
      
      public static const FULLSCREEN_WINDOWS:String = "fullscreenWindow";
      
      public static const IME:String = "ime";
      
      public static const SYSTEM_MESSAGES:String = "systemMessages";
      
      public static const DIALOGS:String = "topWindow";
      
      public static const SERVICE_LAYOUT:String = "serviceLayout";
      
      public static const HIDDEN_SERVICE_LAYOUT:String = "hiddenServiceLayout";
      
      public static const OVERLAY:String = "overlay";
      
      public static const TOOL_TIPS:String = "toolTips";
      
      public static const WAITING:String = "waiting";
      
      public static const CURSOR:String = "cursor";
      
      public static const LAYER_ORDER:Array = [UNDEFINED,ROOT,HIDDEN_SERVICE_LAYOUT,MARKER,VIEWS,SUBVIEW,TOP_SUB_VIEW,WINDOWS,FULLSCREEN_WINDOWS,SYSTEM_MESSAGES,DIALOGS,OVERLAY,IME,SERVICE_LAYOUT,TOOL_TIPS,CURSOR,WAITING];
      
      public static const FOCUS_ORDER:Array = [WAITING,SERVICE_LAYOUT,OVERLAY,DIALOGS,FULLSCREEN_WINDOWS,WINDOWS,TOP_SUB_VIEW,SUBVIEW,VIEWS,MARKER];
       
      
      public function LAYER_NAMES()
      {
         super();
      }
   }
}
