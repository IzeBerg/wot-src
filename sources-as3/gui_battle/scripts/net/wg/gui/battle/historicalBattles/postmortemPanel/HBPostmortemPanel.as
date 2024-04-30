package net.wg.gui.battle.historicalBattles.postmortemPanel
{
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.InvalidationType;
   import net.wg.infrastructure.base.meta.IHBPostmortemPanelMeta;
   import net.wg.infrastructure.base.meta.impl.HBPostmortemPanelMeta;
   
   public class HBPostmortemPanel extends HBPostmortemPanelMeta implements IHBPostmortemPanelMeta
   {
      
      private static const TITLE_DEFAULT_Y:int = -204;
      
      private static const TITLE_EXIT_Y:int = -174;
      
      private static const INVALID_POSTMORTEM_STATE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const PLAYER_INFO_DELTA_Y:int = -250;
       
      
      public var timer:HBPostmortemTimer = null;
      
      public var hintTitleTF:TextField = null;
      
      public var hintDescTF:TextField = null;
      
      public var hintDescBigTF:TextField = null;
      
      public var bgPanel:Sprite = null;
      
      public var escIcon:Sprite = null;
      
      private var _canExit:Boolean = false;
      
      private var _isLocked:Boolean = false;
      
      public function HBPostmortemPanel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         observerModeTitleTF.visible = observerModeDescTF.visible = false;
         this.bgPanel.visible = false;
         bg.visible = false;
         exitToHangarTitleTF.blendMode = BlendMode.SCREEN;
      }
      
      override protected function onDispose() : void
      {
         this.timer.dispose();
         this.timer = null;
         this.hintTitleTF = null;
         this.hintDescBigTF = null;
         this.hintDescTF = null;
         this.bgPanel = null;
         this.escIcon = null;
         super.onDispose();
      }
      
      override protected function setDeadReasonInfo(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:String, param7:UserVO) : void
      {
         super.setDeadReasonInfo(param1,param2,param3,param4,param5,param6,null);
      }
      
      override protected function updatePlayerInfoPosition() : void
      {
         playerInfoTF.y = PLAYER_INFO_DELTA_Y - (App.appHeight >> 1);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_POSTMORTEM_STATE))
         {
            this.hintTitleTF.y = !!this._canExit ? Number(TITLE_EXIT_Y) : Number(TITLE_DEFAULT_Y);
            this.hintDescTF.visible = !this._canExit;
            this.hintDescBigTF.visible = this._canExit;
            invalidate(INVALID_VEHICLE_PANEL);
         }
         if(isInvalid(INVALID_VEHICLE_PANEL))
         {
            this.showSpectatorPanel(true);
            deadReasonBG.visible = false;
            nicknameKillerBG.visible = false;
         }
      }
      
      override protected function showSpectatorPanel(param1:Boolean) : void
      {
         exitToHangarTitleTF.visible = param1 && this._canExit;
         exitToHangarDescTF.visible = param1 && this._canExit;
         this.escIcon.visible = param1 && this._canExit;
         this.bgPanel.visible = param1 && this._canExit;
      }
      
      public function as_setCanExit(param1:Boolean) : void
      {
         if(this._canExit == param1)
         {
            return;
         }
         this._canExit = param1;
         invalidate(INVALID_POSTMORTEM_STATE);
      }
      
      public function as_setHintDescr(param1:String) : void
      {
         this.hintDescTF.text = param1;
         this.hintDescBigTF.text = param1;
      }
      
      public function as_setHintTitle(param1:String) : void
      {
         this.hintTitleTF.text = param1;
      }
      
      public function as_setIsLocked(param1:Boolean) : void
      {
         if(this._isLocked == param1)
         {
            return;
         }
         this._isLocked = param1;
         this.timer.setIsLocked(this._isLocked);
      }
      
      public function as_setTimer(param1:int) : void
      {
         if(param1 > 0)
         {
            this.as_setIsLocked(false);
            this.timer.updateRadialTimer(param1,0);
         }
         else
         {
            this.timer.stopTimer();
         }
      }
   }
}
