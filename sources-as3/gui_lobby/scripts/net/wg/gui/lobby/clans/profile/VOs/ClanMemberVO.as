package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.VO.UserVO;
   import net.wg.gui.messenger.data.ContactItemVO;
   
   public class ClanMemberVO extends UserVO
   {
      
      private static const CONTACT_ITEM:String = "contactItem";
       
      
      public var post:String = "";
      
      public var personalRating:String = "";
      
      public var battlesCount:String = "";
      
      public var wins:String = "";
      
      public var awgExp:String = "";
      
      public var daysInClan:String = "";
      
      public var postIcon:String = "";
      
      public var canShowContextMenu:Boolean = false;
      
      public var contactItem:ContactItemVO = null;
      
      public function ClanMemberVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.contactItem.dispose();
         this.contactItem = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == CONTACT_ITEM)
         {
            this.contactItem = new ContactItemVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
