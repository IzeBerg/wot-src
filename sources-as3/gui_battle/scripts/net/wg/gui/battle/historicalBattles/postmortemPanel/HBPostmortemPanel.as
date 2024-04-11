package net.wg.gui.battle.historicalBattles.postmortemPanel
{
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.views.postmortemPanel.BasePostmortemPanel;
   import net.wg.infrastructure.base.meta.IHBPostmortemPanelMeta;
   import net.wg.infrastructure.base.meta.impl.HBPostmortemPanelMeta;
   
   public class HBPostmortemPanel extends HBPostmortemPanelMeta implements IHBPostmortemPanelMeta
   {
      
      private static const OBSERVER_X:int = -41;
      
      private static const OBSERVER_X_BIG:int = -190;
      
      private static const MOUSE_ICON_X_BIG:int = 230;
      
      private static const BG_SIZE_BIG:int = 500;
      
      private static const BG_SIZE_SMALL:int = 250;
      
      private static const MOUSE_ICON_X_SMALL:int = 81;
      
      private static const TITLE_DEFAULT_Y:int = -204;
      
      private static const TITLE_EXIT_Y:int = -174;
      
      private static const INVALID_POSTMORTEM_STATE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
       
      
      public var timer:HBPostmortemTimer = null;
      
      public var hintTitleTF:TextField = null;
      
      public var hintDescTF:TextField = null;
      
      public var hintDescBigTF:TextField = null;
      
      public var bgPanel:Sprite = null;
      
      public var mouseIcon:Sprite = null;
      
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
         observerModeTitleTF.blendMode = exitToHangarTitleTF.blendMode = BlendMode.SCREEN;
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
         this.mouseIcon = null;
         super.onDispose();
      }
      
      override protected function setDeadReasonInfo(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:String, param7:UserVO) : void
      {
         super.setDeadReasonInfo(param1,param2,param3,param4,param5,param6,null);
      }
      
      override protected function updatePlayerInfoPosition() : void
      {
         playerInfoTF.y = -BasePostmortemPanel.PLAYER_INFO_DELTA_Y - (App.appHeight >> 1);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_POSTMORTEM_STATE))
         {
            exitToHangarTitleTF.visible = this._canExit;
            exitToHangarDescTF.visible = this._canExit;
            this.hintTitleTF.y = !!this._canExit ? Number(TITLE_EXIT_Y) : Number(TITLE_DEFAULT_Y);
            this.hintDescTF.visible = !this._canExit;
            this.hintDescBigTF.visible = this._canExit;
            this.escIcon.visible = this._canExit;
            if(this._canExit)
            {
               this.mouseIcon.x = -MOUSE_ICON_X_BIG;
               this.bgPanel.width = BG_SIZE_BIG;
               observerModeDescTF.x = observerModeTitleTF.x = OBSERVER_X_BIG;
            }
            else
            {
               this.mouseIcon.x = -MOUSE_ICON_X_SMALL;
               this.bgPanel.width = BG_SIZE_SMALL;
               bg.imageName = BATTLEATLAS.POSTMORTEM_TIPS_EVENT_BG;
               observerModeDescTF.x = observerModeTitleTF.x = OBSERVER_X;
            }
         }
         if(isInvalid(INVALID_VEHICLE_PANEL))
         {
            this.showSpectatorPanel(true);
            deadReasonBG.visible = false;
            nicknameKillerBG.visible = false;
            bg.visible = false;
         }
      }
      
      override protected function showSpectatorPanel(param1:Boolean) : void
      {
         bg.visible = false;
         observerModeTitleTF.visible = param1;
         observerModeDescTF.visible = param1;
         exitToHangarTitleTF.visible = param1 && this._canExit;
         exitToHangarDescTF.visible = param1 && this._canExit;
      }
      
      public function as_setCanExit(param1:Boolean) : void
      {
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
      
      public function as_setIsLocked(param1:Boolean) : void
      {
         if(this._isLocked == param1)
         {
            return;
         }
         this._isLocked = param1;
         this.timer.setIsLocked(this._isLocked);
      }
   }
}
