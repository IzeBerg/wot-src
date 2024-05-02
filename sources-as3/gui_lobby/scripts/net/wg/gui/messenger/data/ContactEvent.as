package net.wg.gui.messenger.data
{
   import flash.events.Event;
   
   public class ContactEvent extends Event
   {
      
      public static const CREATE_NOTE:String = "createNote";
      
      public static const EDIT_NOTE:String = "editNote";
       
      
      public var contactName:String;
      
      public var contactId:int;
      
      public function ContactEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc1_:ContactEvent = new ContactEvent(type,bubbles,cancelable);
         _loc1_.contactName = this.contactName;
         _loc1_.contactId = this.contactId;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return formatToString("ContactEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
