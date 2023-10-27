package net.wg.gui.lobby.profile.components
{
   import net.wg.gui.lobby.profile.data.ProfileUserVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ProfileFooter extends UIComponentEx
   {
       
      
      private var _data:ProfileUserVO = null;
      
      public function ProfileFooter()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            this.applyDataChanges();
         }
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         super.onDispose();
      }
      
      public function setUserData(param1:ProfileUserVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      protected function applyDataChanges() : void
      {
      }
      
      public function get data() : ProfileUserVO
      {
         return this._data;
      }
   }
}
