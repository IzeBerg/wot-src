package net.wg.gui.messenger.data
{
   import net.wg.data.VO.ExtendedUserVO;
   
   public class ContactVO extends ExtendedUserVO
   {
       
      
      private var _isOnline:Boolean = false;
      
      public function ContactVO(param1:Object)
      {
         super(param1);
      }
      
      public function get isOnline() : Boolean
      {
         return this._isOnline;
      }
      
      public function set isOnline(param1:Boolean) : void
      {
         this._isOnline = param1;
      }
   }
}
