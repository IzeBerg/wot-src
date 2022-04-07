package net.wg.gui.lobby.clans.invites.renderers
{
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.ButtonIconTextTransparent;
   import net.wg.gui.lobby.clans.invites.VOs.ClanRequestVO;
   import net.wg.gui.lobby.clans.invites.components.AcceptActions;
   import scaleform.clik.constants.InvalidationType;
   
   [Event(name="inviteClicked",type="net.wg.gui.lobby.clans.invites.renderers.ClanTableRendererItemEvent")]
   public class ClanRequestItemRenderer extends UserAbstractTableItemRenderer
   {
       
      
      public var inviteButton:ButtonIconTextTransparent = null;
      
      public var accept:AcceptActions = null;
      
      private var _rendererVO:ClanRequestVO = null;
      
      public function ClanRequestItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._rendererVO = ClanRequestVO(param1);
      }
      
      override protected function onDispose() : void
      {
         this.inviteButton.removeEventListener(MouseEvent.CLICK,this.onInviteButtonClickHandler);
         this.inviteButton.dispose();
         this.inviteButton = null;
         this._rendererVO = null;
         this.accept.dispose();
         this.accept = null;
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
            this.inviteButton.visible = _loc1_ && !_loc2_;
            this.accept.visible = _loc1_ && !_loc2_;
            if(_loc1_ && !_loc2_)
            {
               this.inviteButton.label = this._rendererVO.actions.inviteButtonText;
               this.inviteButton.visible = this._rendererVO.actions.inviteButtonVisible;
               this.inviteButton.enabled = this._rendererVO.actions.inviteButtonEnabled;
               this.inviteButton.mouseEnabledOnDisabled = true;
               this.accept.setModel(this._rendererVO.actions,this._rendererVO.dbID);
            }
         }
      }
      
      override protected function onConfigUI() : void
      {
         super.onConfigUI();
         addRollOverComponent(this.inviteButton);
         this.inviteButton.addEventListener(MouseEvent.CLICK,this.onInviteButtonClickHandler);
         this.inviteButton.visible = false;
      }
      
      override protected function onComponentRollOverHandlerImpl(param1:IEventDispatcher) : void
      {
         super.onComponentRollOverHandlerImpl(param1);
         if(this._rendererVO != null)
         {
            if(param1 == this.inviteButton)
            {
               showComplexTooltip(this._rendererVO.actions.inviteButtonTooltip);
            }
         }
      }
      
      private function onInviteButtonClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:ClanTableRendererItemEvent = null;
         if(this.inviteButton.enabled)
         {
            _loc2_ = new ClanTableRendererItemEvent(ClanTableRendererItemEvent.INVITE_CLICKED,true);
            _loc2_.dbID = this._rendererVO.dbID;
            dispatchEvent(_loc2_);
         }
      }
   }
}
