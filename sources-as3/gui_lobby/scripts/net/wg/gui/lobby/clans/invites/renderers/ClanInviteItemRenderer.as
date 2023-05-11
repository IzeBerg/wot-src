package net.wg.gui.lobby.clans.invites.renderers
{
   import flash.text.TextField;
   import net.wg.gui.lobby.clans.invites.VOs.ClanInviteVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class ClanInviteItemRenderer extends UserAbstractTableItemRenderer
   {
       
      
      public var sentTF:TextField = null;
      
      private var _rendererVO:ClanInviteVO = null;
      
      public function ClanInviteItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._rendererVO = ClanInviteVO(param1);
      }
      
      override protected function onDispose() : void
      {
         this._rendererVO = null;
         this.sentTF = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._rendererVO != null;
            _loc2_ = _loc1_ && this._rendererVO.hasShowMoreButton;
            this.sentTF.visible = _loc1_ && !_loc2_;
            if(_loc1_ && !_loc2_)
            {
               this.sentTF.htmlText = this._rendererVO.sent;
            }
         }
      }
   }
}
