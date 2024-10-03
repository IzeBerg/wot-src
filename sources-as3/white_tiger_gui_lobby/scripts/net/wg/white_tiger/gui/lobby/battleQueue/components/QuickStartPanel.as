package net.wg.white_tiger.gui.lobby.battleQueue.components
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.white_tiger.data.constants.generated.WHITE_TIGER_BATTLES_CONSTS;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.QuickStartPanelVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class QuickStartPanel extends UIComponentEx
   {
      
      private static const STATE_SHOWN:String = "shownState";
      
      private static const STATE_HIDDEN:String = "hiddenState";
      
      private static const HIDDEN_Y:int = 200;
      
      private static const TWEEN_DURATION:int = 300;
      
      private static const HEIGHT_BIG:int = 202;
      
      private static const HEIGHT_SMALL:int = 184;
      
      private static const BONUS_OFFSET_Y:int = 40;
       
      
      public var bossContent:QuickStartBossContent = null;
      
      public var hunterContent:QuickStartHunterContent = null;
      
      public var bonusText:TextField = null;
      
      private var _animContainer:Sprite;
      
      private var _isSmall:Boolean = false;
      
      private var _dataToShow:QuickStartPanelVO = null;
      
      private var _tween:Tween = null;
      
      private var _state:String = "hiddenState";
      
      private var _marginTop:int = -1;
      
      public function QuickStartPanel()
      {
         this._animContainer = new Sprite();
         super();
         addChild(this._animContainer);
         this._animContainer.addChild(this.bossContent);
         this._animContainer.addChild(this.hunterContent);
         this._animContainer.addChild(this.bonusText);
      }
      
      override protected function onDispose() : void
      {
         this._animContainer.removeChild(this.bossContent);
         this._animContainer.removeChild(this.hunterContent);
         this._animContainer.removeChild(this.bonusText);
         removeChild(this._animContainer);
         this._animContainer = null;
         this.bossContent.dispose();
         this.bossContent = null;
         this.hunterContent.dispose();
         this.hunterContent = null;
         this._dataToShow = null;
         this.bonusText = null;
         this.clearTween();
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bossContent.visible = this.hunterContent.visible = false;
         this._animContainer.y = HIDDEN_Y;
         this._animContainer.alpha = 0;
         this.bonusText.text = EVENT.BATTLEQUEUE_WIDGET_BONUSDESCR;
         App.utils.commons.updateTextFieldSize(this.bonusText);
         this.bonusText.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.bossContent.x = -(this.bossContent.width >> 1);
            this.hunterContent.x = -(this.hunterContent.width >> 1);
            this.bonusText.x = -(this.bonusText.textWidth >> 1);
            this.bonusText.y = -(this.bossContent.y + this._marginTop - BONUS_OFFSET_Y >> 1);
         }
      }
      
      public function hide() : void
      {
         this._dataToShow = null;
         this.hidePanel();
      }
      
      public function setAverageTime(param1:String, param2:String) : void
      {
         this.hunterContent.setAverageTime(param1,param2);
         this.bossContent.setAverageTime(param1,param2);
      }
      
      public function setData(param1:QuickStartPanelVO) : void
      {
         this._dataToShow = param1;
         if(this._state == STATE_SHOWN)
         {
            this.hidePanel();
         }
         else
         {
            this.showPanel();
         }
      }
      
      public function setInfoText(param1:String) : void
      {
         this.hunterContent.setInfoText(param1);
         this.bossContent.setInfoText(param1);
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function hidePanel() : void
      {
         this._state = STATE_HIDDEN;
         this.clearTween();
         this._tween = new Tween(TWEEN_DURATION,this._animContainer,{
            "alpha":0,
            "y":HIDDEN_Y
         },{
            "ease":Cubic.easeIn,
            "onComplete":this.onHidePanelComplete
         });
      }
      
      private function onHidePanelComplete(param1:Tween) : void
      {
         if(this._dataToShow)
         {
            this.showPanel();
         }
      }
      
      private function showPanel() : void
      {
         this._state = STATE_SHOWN;
         this.clearTween();
         this.applyData();
         this._tween = new Tween(TWEEN_DURATION,this._animContainer,{
            "alpha":1,
            "y":0
         },{"ease":Cubic.easeIn});
      }
      
      private function applyData() : void
      {
         App.utils.asserter.assertNotNull(this._dataToShow,"data" + Errors.CANT_NULL);
         if(this._dataToShow.type == WHITE_TIGER_BATTLES_CONSTS.BOSS_QUICK_START_PANEL)
         {
            this.bossContent.setData(this._dataToShow);
            this.bossContent.visible = true;
            this.hunterContent.visible = false;
            this.bonusText.visible = this.bossContent.isBonus;
         }
         else if(this._dataToShow.type == WHITE_TIGER_BATTLES_CONSTS.HUNTER_QUICK_START_PANEL)
         {
            this.hunterContent.setData(this._dataToShow);
            this.hunterContent.visible = true;
            this.bossContent.visible = false;
            this.bonusText.visible = false;
         }
         this._dataToShow = null;
      }
      
      override public function get height() : Number
      {
         return !!this._isSmall ? Number(HEIGHT_SMALL) : Number(HEIGHT_BIG);
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         if(param1 != this._isSmall)
         {
            this._isSmall = this.hunterContent.isSmall = this.bossContent.isSmall = param1;
            invalidateSize();
         }
      }
      
      public function set marginTop(param1:Number) : void
      {
         this._marginTop = param1;
         invalidateSize();
      }
   }
}
