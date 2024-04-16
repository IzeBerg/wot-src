package net.wg.gui.messenger.evnts
{
   import flash.events.Event;
   
   public class ContactsTreeEvent extends Event
   {
      
      public static const MODE_CHANGED:String = "modeChanged";
      
      public static const TOP_LEVEL_LIST_CHANGED:String = "topLvlListChanged";
      
      public static const TOP_LEVEL_LIST_SELECTED_INDEX_CHANGED:String = "topLvlListSelIndChanged";
      
      public static const TOP_LEVEL_LIST_DOUBLE_CLICK:String = "topLvlDoubleClick";
      
      public static const EXTERNAL_SEARCH_LIST_CHANGED:String = "extListChanged";
      
      public static const EXTERNAL_SEARCH_LIST_SELECTED_INDEX_CHANGED:String = "extListSelIndChanged";
      
      public static const EXTERNAL_SEARCH_LIST_DOUBLE_CLICK:String = "extListDoubleClick";
      
      public static const EXTERNAL_SEARCH_VALID_CHANGED:String = "extSearchValidChanged";
      
      public static const CONTACT_DRAG_START:String = "cDtagStart";
      
      public static const CONTACT_DRAG_END:String = "cDragEnd";
       
      
      public var data:Object;
      
      public function ContactsTreeEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc1_:ContactsTreeEvent = new ContactsTreeEvent(type,bubbles,cancelable);
         _loc1_.data = this.data;
         return _loc1_;
      }
   }
}
