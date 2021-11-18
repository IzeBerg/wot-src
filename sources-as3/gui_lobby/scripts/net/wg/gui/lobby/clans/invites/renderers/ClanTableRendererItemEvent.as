package net.wg.gui.lobby.clans.invites.renderers
{
   import flash.events.Event;
   
   public class ClanTableRendererItemEvent extends Event
   {
      
      public static const ACCEPT_CLICKED:String = "acceptClicked";
      
      public static const DECLINE_CLICKED:String = "declineClicked";
      
      public static const INVITE_CLICKED:String = "inviteClicked";
      
      public static const SHOW_MORE_CLICKED:String = "showMoreClicked";
      
      public static const ITEM_CHECKED:String = "itemChecked";
      
      public static const ITEM_UNCHECKED:String = "itemUnchecked";
       
      
      private var _dbID:Number;
      
      public function ClanTableRendererItemEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function get dbID() : Number
      {
         return this._dbID;
      }
      
      public function set dbID(param1:Number) : void
      {
         this._dbID = param1;
      }
   }
}
