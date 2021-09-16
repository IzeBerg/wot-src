package net.wg.infrastructure.managers.utils.impl
{
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import net.wg.utils.IStyleSheetManager;
   
   public class StyleSheetManager implements IStyleSheetManager
   {
      
      public static const LINK_COLOR_NORMAL:String = "#C9C9B6";
      
      public static const LINK_COLOR_HOVER:String = "#EE7000";
      
      public static const LINK_COLOR_PRESS:String = "#EE7000";
      
      public static const LINK_COLOR_VISITED:String = "#C9C9B6";
      
      public static const WHITE_LINK_COLOR_NORMAL:String = "#8C8C7E";
      
      public static const UNDERLINE:String = "underline";
       
      
      public function StyleSheetManager()
      {
         super();
      }
      
      public function setForceFocusedStyle(param1:String) : String
      {
         return "<forceFocused>" + param1 + "</forceFocused>";
      }
      
      public function setLinkStyle(param1:TextField) : void
      {
         var _loc2_:StyleSheet = param1.styleSheet;
         if(_loc2_ == null)
         {
            _loc2_ = new StyleSheet();
         }
         _loc2_.setStyle("a:link",{
            "color":LINK_COLOR_NORMAL,
            "textDecoration":UNDERLINE
         });
         _loc2_.setStyle("a:hover",{
            "color":LINK_COLOR_HOVER,
            "textDecoration":UNDERLINE
         });
         _loc2_.setStyle("a:active",{
            "color":LINK_COLOR_PRESS,
            "textDecoration":UNDERLINE
         });
         _loc2_.setStyle("a:visited",{
            "color":LINK_COLOR_VISITED,
            "textDecoration":UNDERLINE
         });
         _loc2_.setStyle("forceFocused",{"color":LINK_COLOR_HOVER});
         param1.styleSheet = _loc2_;
      }
      
      public function setWhiteLinkStyle(param1:TextField) : void
      {
         var _loc2_:StyleSheet = param1.styleSheet;
         if(_loc2_ == null)
         {
            _loc2_ = new StyleSheet();
         }
         _loc2_.setStyle("a:link",{
            "color":WHITE_LINK_COLOR_NORMAL,
            "fontSize":"12px"
         });
         _loc2_.setStyle("a:hover",{
            "color":WHITE_LINK_COLOR_NORMAL,
            "textDecoration":UNDERLINE,
            "fontSize":"12px"
         });
         _loc2_.setStyle("a:active",{
            "color":WHITE_LINK_COLOR_NORMAL,
            "textDecoration":UNDERLINE,
            "fontSize":"12px"
         });
         param1.styleSheet = _loc2_;
      }
   }
}
