package net.wg.gui.messenger.data
{
   import flash.events.Event;
   
   public class ContactsGroupEvent extends Event
   {
      
      public static const EDIT_GROUP:String = "editGroup";
      
      public static const REMOVE_GROUP:String = "removeGroup";
      
      public static const CONTACT_CHANGE_GROUP:String = "contactChangeGroup";
      
      public static const GROUP_CLICKED:String = "contactGroupClicked";
      
      public static const CONTACT_COPY_GROUP:String = "contactCopyGroup";
       
      
      public var targetGroup:ITreeItemInfo;
      
      public var excludeGroup:ITreeItemInfo;
      
      public var contactID:Number;
      
      public var contactName:String;
      
      public function ContactsGroupEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc1_:ContactsGroupEvent = new ContactsGroupEvent(type,bubbles,cancelable);
         _loc1_.contactID = this.contactID;
         _loc1_.contactName = this.contactName;
         _loc1_.targetGroup = this.targetGroup;
         _loc1_.excludeGroup = this.excludeGroup;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return formatToString("ContactsGroupEvent","type","name","bubbles","cancelable","eventPhase");
      }
   }
}
