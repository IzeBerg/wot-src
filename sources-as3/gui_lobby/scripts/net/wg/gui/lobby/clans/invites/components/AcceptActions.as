package net.wg.gui.lobby.clans.invites.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.lobby.clans.invites.VOs.AcceptActionsVO;
   import net.wg.gui.lobby.clans.invites.renderers.ClanTableRendererItemEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AcceptActions extends Sprite implements IDisposable
   {
      
      private static const TOOLTIP_MAX_WIDTH:int = 255;
       
      
      public var acceptButton:IButtonIconLoader = null;
      
      public var declineButton:IButtonIconLoader = null;
      
      private var _model:AcceptActionsVO = null;
      
      private var _dbID:Number = -1;
      
      private var _disposed:Boolean = false;
      
      public function AcceptActions()
      {
         super();
         this.declineButton.iconSource = RES_ICONS.MAPS_ICONS_CLANS_INVITESWINDOW_CROSS;
         this.acceptButton.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_OKICON;
         this.acceptButton.addEventListener(MouseEvent.ROLL_OVER,this.onAcceptButtonRollOverHandler);
         this.acceptButton.addEventListener(MouseEvent.ROLL_OUT,this.onAcceptButtonRollOutHandler);
         this.acceptButton.addEventListener(MouseEvent.CLICK,this.onAcceptButtonClickHandler);
         this.declineButton.addEventListener(MouseEvent.CLICK,this.onDeclineButtonClickHandler);
         this.acceptButton.visible = false;
         this.declineButton.visible = false;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.acceptButton.removeEventListener(MouseEvent.ROLL_OVER,this.onAcceptButtonRollOverHandler);
         this.acceptButton.removeEventListener(MouseEvent.ROLL_OUT,this.onAcceptButtonRollOutHandler);
         this.acceptButton.removeEventListener(MouseEvent.CLICK,this.onAcceptButtonClickHandler);
         this.declineButton.removeEventListener(MouseEvent.CLICK,this.onDeclineButtonClickHandler);
         this.acceptButton.dispose();
         this.acceptButton = null;
         this.declineButton.dispose();
         this.declineButton = null;
         this._model = null;
      }
      
      public function setModel(param1:AcceptActionsVO, param2:Number) : void
      {
         this._model = param1;
         this._dbID = param2;
         if(this._model != null)
         {
            this.acceptButton.visible = this._model.acceptButtonVisible;
            this.declineButton.visible = this._model.declineButtonVisible;
            this.acceptButton.enabled = this._model.acceptButtonEnabled;
            this.declineButton.enabled = this._model.declineButtonEnabled;
            this.acceptButton.mouseEnabledOnDisabled = true;
         }
      }
      
      protected function dispatchEventWithType(param1:String) : void
      {
         var _loc2_:ClanTableRendererItemEvent = new ClanTableRendererItemEvent(param1,true);
         _loc2_.dbID = this._dbID;
         dispatchEvent(_loc2_);
      }
      
      private function onAcceptButtonRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onAcceptButtonRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ITooltipProps = null;
         if(this._model != null)
         {
            _loc2_ = new TooltipProps(BaseTooltips.TYPE_INFO,0,0,TOOLTIP_MAX_WIDTH);
            App.toolTipMgr.showComplex(this._model.acceptButtonTooltip,_loc2_);
         }
      }
      
      private function onAcceptButtonClickHandler(param1:MouseEvent) : void
      {
         if(this.acceptButton.enabled)
         {
            this.dispatchEventWithType(ClanTableRendererItemEvent.ACCEPT_CLICKED);
         }
      }
      
      private function onDeclineButtonClickHandler(param1:MouseEvent) : void
      {
         this.dispatchEventWithType(ClanTableRendererItemEvent.DECLINE_CLICKED);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
