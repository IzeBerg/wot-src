package net.wg.gui.battle.pveBase.views.postmortemPanel
{
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.views.postmortemPanel.BasePostmortemPanel;
   import net.wg.infrastructure.base.meta.IPvePostmortemPanelMeta;
   import net.wg.infrastructure.base.meta.impl.PvePostmortemPanelMeta;
   import net.wg.utils.StageSizeBoundaries;
   
   public class PvePostmortemPanel extends PvePostmortemPanelMeta implements IPvePostmortemPanelMeta
   {
      
      public static const CHANGED_EVENT:String = "PvePostmortemPanel:CHANGED_EVENT";
      
      private static const OBSERVER_X:int = -41;
      
      private static const OBSERVER_X_BIG:int = -190;
      
      private static const MOUSE_ICON_X_BIG:int = 230;
      
      private static const BG_SIZE_BIG:int = 500;
      
      private static const BG_SIZE_SMALL:int = 250;
      
      private static const MOUSE_ICON_X_SMALL:int = 81;
      
      private static const TITLE_DEFAULT_Y:int = -204;
      
      private static const TITLE_EXIT_Y:int = -174;
      
      private static const INVALID_POSTMORTEM_STATE:int = 1 << 12;
      
      private static const DEAD_REASON_TF_Y:int = -447;
      
      private static const DEAD_REASON_BG_Y:int = -405;
      
      private static const DEAD_REASON_BACK_Y:int = -449;
      
      private static const VEHICLE_PANEL_Y:int = -406;
      
      private static const OFFSET:int = 30;
       
      
      public var timer:PvePostmortemTimer = null;
      
      public var hintTitleTF:TextField = null;
      
      public var hintDescTF:TextField = null;
      
      public var hintDescBigTF:TextField = null;
      
      public var observerModeTitleTF:TextField = null;
      
      public var observerModeDescTF:TextField = null;
      
      public var exitToHangarTitleTF:TextField = null;
      
      public var exitToHangarDescTF:TextField = null;
      
      public var bg:BattleAtlasSprite = null;
      
      public var bgPanel:Sprite = null;
      
      public var mouseIcon:Sprite = null;
      
      public var escIcon:Sprite = null;
      
      private var _canExit:Boolean = false;
      
      private var _hideHintPanel:Boolean = false;
      
      private var _w:int;
      
      private var _h:int;
      
      private var _textFields:Vector.<TextField>;
      
      public function PvePostmortemPanel()
      {
         super();
         this._textFields = new <TextField>[this.hintTitleTF,this.hintDescTF,this.hintDescBigTF,playerInfoTF,deadReasonTF];
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.observerModeTitleTF.blendMode = this.exitToHangarTitleTF.blendMode = BlendMode.SCREEN;
      }
      
      override protected function createPostmortemPanelElements() : void
      {
         this.bg.imageName = BATTLEATLAS.POSTMORTEM_TIPS_BG;
         this.observerModeTitleTF.text = INGAME_GUI.POSTMORTEM_TIPS_OBSERVERMODE_LABEL;
         this.observerModeDescTF.text = INGAME_GUI.POSTMORTEM_TIPS_OBSERVERMODE_TEXT;
         this.exitToHangarTitleTF.text = INGAME_GUI.POSTMORTEM_TIPS_EXITHANGAR_LABEL;
         this.exitToHangarDescTF.text = INGAME_GUI.POSTMORTEM_TIPS_EXITHANGAR_TEXT;
      }
      
      override protected function onDispose() : void
      {
         this.timer.dispose();
         this.timer = null;
         this.hintTitleTF = null;
         this.hintDescBigTF = null;
         this.hintDescTF = null;
         this.observerModeTitleTF = null;
         this.observerModeDescTF = null;
         this.exitToHangarTitleTF = null;
         this.exitToHangarDescTF = null;
         this.bg = null;
         this.bgPanel = null;
         this.escIcon = null;
         this.mouseIcon = null;
         this._textFields.length = 0;
         this._textFields = null;
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
            this.observerModeTitleTF.visible = true;
            this.observerModeDescTF.visible = true;
            this.exitToHangarTitleTF.visible = this._canExit;
            this.exitToHangarDescTF.visible = this._canExit;
            this.timer.visible = !this._canExit;
            this.hintTitleTF.y = !!this._canExit ? Number(TITLE_EXIT_Y) : Number(TITLE_DEFAULT_Y);
            this.hintDescTF.visible = !this._canExit;
            this.hintDescBigTF.visible = this._canExit;
            this.escIcon.visible = this._canExit;
            if(this._canExit)
            {
               this.mouseIcon.x = -MOUSE_ICON_X_BIG;
               this.bgPanel.width = BG_SIZE_BIG;
               this.observerModeDescTF.x = this.observerModeTitleTF.x = OBSERVER_X_BIG;
            }
            else
            {
               this.mouseIcon.x = -MOUSE_ICON_X_SMALL;
               this.bgPanel.width = BG_SIZE_SMALL;
               this.bg.imageName = BATTLEATLAS.POSTMORTEM_TIPS_EVENT_BG;
               this.observerModeDescTF.x = this.observerModeTitleTF.x = OBSERVER_X;
            }
            if(this._hideHintPanel)
            {
               this.bgPanel.visible = false;
               this.escIcon.visible = false;
               this.mouseIcon.visible = false;
               this.observerModeTitleTF.visible = false;
               this.observerModeDescTF.visible = false;
               this.exitToHangarTitleTF.visible = false;
               this.exitToHangarDescTF.visible = false;
            }
         }
         if(isInvalid(INVALID_VEHICLE_PANEL))
         {
            deadReasonBG.visible = false;
            nicknameKillerBG.visible = false;
            this.bg.visible = false;
            deadReasonBack.visible = _deadReason != Values.EMPTY_STR;
            this.updateDeadReasonPosition();
         }
         if(isInvalid(INVALID_PLAYER_INFO))
         {
            deadReasonBack.visible = false;
         }
         if(isInvalid(INVALID_HIDE_COMPONENTS))
         {
            deadReasonBack.visible = deadReasonTF.visible = _deadReason == Values.EMPTY_STR;
         }
         if(isInvalid(INVALID_DEAD_REASON_VISIBILITY))
         {
            deadReasonBack.visible = deadReasonTF.visible = _deadReason != Values.EMPTY_STR;
            deadReasonBG.visible = false;
         }
         dispatchEvent(new Event(CHANGED_EVENT,true));
      }
      
      private function updateDeadReasonPosition() : void
      {
         var _loc1_:Boolean = this._w <= StageSizeBoundaries.WIDTH_1366 || this._h <= StageSizeBoundaries.HEIGHT_768;
         var _loc2_:int = !!_loc1_ ? int(OFFSET) : int(0);
         deadReasonTF.y = DEAD_REASON_TF_Y + _loc2_;
         deadReasonBG.y = DEAD_REASON_BG_Y + _loc2_;
         deadReasonBack.y = DEAD_REASON_BACK_Y + _loc2_;
         vehiclePanel.y = VEHICLE_PANEL_Y + _loc2_;
      }
      
      override public function updateStage(param1:int, param2:int) : void
      {
         this._w = param1;
         this._h = param2;
         this.updateDeadReasonPosition();
      }
      
      override protected function showPostmortemPanel(param1:Boolean) : void
      {
         if(this._hideHintPanel)
         {
            return;
         }
         this.bg.visible = false;
         this.observerModeTitleTF.visible = param1;
         this.observerModeDescTF.visible = param1;
         this.exitToHangarTitleTF.visible = param1 && this._canExit;
         this.exitToHangarDescTF.visible = param1 && this._canExit;
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
         invalidate();
      }
      
      public function as_setHintTitle(param1:String) : void
      {
         this.hintTitleTF.text = param1;
         invalidate();
      }
      
      public function as_setTimer(param1:int, param2:Number) : void
      {
         this.timer.visible = param1 > 0;
         if(this.timer.visible)
         {
            this.timer.setLockedState(false);
            this.timer.updateRadialTimer(param1,param2);
         }
         else
         {
            this.timer.stopTimer();
         }
      }
      
      public function as_showLockedLives() : void
      {
         this.timer.setLockedState(true);
         this.timer.visible = true;
      }
      
      public function getMinimapAvailableWidth() : Number
      {
         var _loc2_:TextField = null;
         var _loc1_:Number = 0;
         for each(_loc2_ in this._textFields)
         {
            if(_loc2_.visible)
            {
               _loc1_ = Math.max(_loc1_,_loc2_.textWidth);
            }
         }
         _loc1_ = Math.max(_loc1_,this.bgPanel.width);
         _loc1_ = Math.max(_loc1_,this.timer.width);
         return App.appWidth - x - _loc1_ / 2;
      }
      
      public function as_hidePanel() : void
      {
         this._hideHintPanel = true;
         invalidate(INVALID_POSTMORTEM_STATE);
      }
   }
}
