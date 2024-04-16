package net.wg.gui.lobby.clans.profile
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.interfaces.ISoundButtonEx;
   
   public class ClanProfileMainWindowHeader extends ClanProfileMainWindowBaseHeader
   {
       
      
      public var topTF:TextField = null;
      
      public var middleTF:TextField = null;
      
      public var iconBtn:IButtonIconLoader = null;
      
      public var actionBtn:ISoundButtonEx = null;
      
      public function ClanProfileMainWindowHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.actionBtn.addEventListener(MouseEvent.CLICK,this.onActionBtnClickHandler);
         this.actionBtn.addEventListener(MouseEvent.ROLL_OVER,this.onActionBtnRollOverHandler);
         this.actionBtn.addEventListener(MouseEvent.ROLL_OUT,this.onActionBtnRollOutHandler);
         this.iconBtn.addEventListener(MouseEvent.CLICK,this.onIconBtnClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.actionBtn.removeEventListener(MouseEvent.CLICK,this.onActionBtnClickHandler);
         this.actionBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onActionBtnRollOverHandler);
         this.actionBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onActionBtnRollOutHandler);
         this.actionBtn.dispose();
         this.actionBtn = null;
         this.iconBtn.removeEventListener(MouseEvent.CLICK,this.onIconBtnClickHandler);
         this.iconBtn.dispose();
         this.iconBtn = null;
         this.topTF = null;
         this.middleTF = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(INV_HEADER_STATE))
         {
            if(_headerStateData)
            {
               this.topTF.htmlText = _headerStateData.topTF;
               this.topTF.visible = _headerStateData.topTFVisible;
               this.actionBtn.label = _headerStateData.actionBtnLabel;
               this.actionBtn.visible = _headerStateData.actionBtnVisible;
               _loc1_ = _headerStateData.iconBtnVisible;
               this.iconBtn.visible = _loc1_;
               if(_loc1_)
               {
                  this.iconBtn.iconSource = _headerStateData.iconBtnIcon;
               }
               this.middleTF.visible = _headerStateData.middleTFVisible;
               this.middleTF.htmlText = _headerStateData.middleTF;
            }
            else
            {
               this.middleTF.visible = false;
               this.topTF.visible = false;
               this.actionBtn.visible = false;
               this.iconBtn.visible = false;
            }
         }
      }
      
      private function onActionBtnRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onActionBtnRollOverHandler(param1:MouseEvent) : void
      {
         if(_headerStateData && _headerStateData.actionBtnTooltip)
         {
            App.toolTipMgr.showComplex(_headerStateData.actionBtnTooltip);
         }
      }
      
      private function onIconBtnClickHandler(param1:MouseEvent) : void
      {
         sendActionEvent(_headerStateData.actionId);
      }
      
      private function onActionBtnClickHandler(param1:MouseEvent) : void
      {
         sendActionEvent(_headerStateData.actionId);
      }
   }
}
