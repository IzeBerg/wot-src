package net.wg.gui.messenger.data
{
   import net.wg.data.managers.impl.ToolTipParams;
   
   public class ContactsShared
   {
      
      public static const BOTTOM_CTRLS_PADDING:uint = 10;
      
      public static const CONTROLS_PADDING:uint = 10;
      
      public static const SCROLL_LIST_GAP:uint = 10;
      
      public static const SCROLL_SIDE_PADDING:uint = 10;
      
      public static const INFO_VIEW_PADDING:uint = 40;
      
      public static const CONTACT_RENDERER_HEIGHT:uint = 25;
      
      public static const CATEGORY_EMPTY_ITEM_COLOR:int = 5855312;
      
      public static const GROUP_EMPTY_ITEM_COLOR:int = 9211006;
      
      public static const INVITE_PROMPT_DEFAULT_TEXT_COLOR:uint = 5855568;
      
      public static const INVITE_INPUT_TEXT_COLOR:uint = 9803143;
       
      
      public function ContactsShared()
      {
         super();
      }
      
      public static function searchTextValid(param1:String, param2:uint) : Boolean
      {
         return param1.length >= param2;
      }
      
      public static function showSearchInputTextValidTooltip(param1:uint, param2:uint) : void
      {
         App.toolTipMgr.showComplexWithParams(MESSENGER.CONTACTS_SEARCHVIEW_TOOLTIPS_SEARCHCREDENTIALS,new ToolTipParams(null,{
            "minChars":param1.toString(),
            "maxChars":param2.toString()
         }));
      }
      
      public static function hideSearchInputTextValidTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      public static function trim(param1:String) : String
      {
         return param1.replace(/^\s*/,"").replace(/\s*$/,"");
      }
   }
}
