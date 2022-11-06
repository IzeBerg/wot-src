package net.wg.gui.prebattle.invites
{
   import flash.events.Event;
   
   public class SendInvitesEvent extends Event
   {
      
      public static const INIT_COMPONENT:String = "initComponent";
      
      public static const SEARCH_TOKEN:String = "searchToken";
      
      public static const LIST_DOUBLE_CLICK:String = "listItemDoubleClick";
      
      public static const SHOW_CONTEXT_MENU:String = "showContextMenu";
       
      
      public var searchString:String;
      
      public var initItem:Object;
      
      public function SendInvitesEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
