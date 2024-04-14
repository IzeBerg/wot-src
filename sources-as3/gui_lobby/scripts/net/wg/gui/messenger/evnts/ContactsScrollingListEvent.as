package net.wg.gui.messenger.evnts
{
   import flash.events.Event;
   
   public class ContactsScrollingListEvent extends Event
   {
      
      public static const DATA_POPULATED:String = "scListDataPopulated";
       
      
      public function ContactsScrollingListEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ContactsScrollingListEvent(type,bubbles,cancelable);
      }
   }
}
