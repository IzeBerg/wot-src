package net.wg.gui.battle.tutorial.views.tutorial.components.progressBar
{
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.gfx.TextFieldEx;
   
   public class BattleProgressItemLabel extends BattleUIComponent
   {
      
      public static const WHITE_COLOR:int = 16777215;
      
      public static const BLACK_COLOR:int = 0;
      
      public static const PHASE_DONE_ALPHA:Number = 0.4;
      
      private static const INVALID_LABEL_STR:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const INVALID_ITEM_VIEW:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
       
      
      public var label:TextField = null;
      
      public var bg:Sprite = null;
      
      private var _labelStr:String = "";
      
      private var _whiteDropShadowFilter:DropShadowFilter;
      
      private var _blackDropShadowFilter:DropShadowFilter;
      
      private var _currentPhase:int = -1;
      
      public function BattleProgressItemLabel()
      {
         this._whiteDropShadowFilter = new DropShadowFilter();
         this._blackDropShadowFilter = new DropShadowFilter();
         super();
         this._whiteDropShadowFilter.distance = 0;
         this._whiteDropShadowFilter.angle = 0;
         this._whiteDropShadowFilter.color = WHITE_COLOR;
         this._whiteDropShadowFilter.alpha = 1;
         this._whiteDropShadowFilter.blurX = 3;
         this._whiteDropShadowFilter.blurY = 3;
         this._whiteDropShadowFilter.strength = 1;
         this._whiteDropShadowFilter.quality = BitmapFilterQuality.MEDIUM;
         this._whiteDropShadowFilter.knockout = false;
         this._whiteDropShadowFilter.inner = false;
         this._whiteDropShadowFilter.hideObject = false;
         this._blackDropShadowFilter.distance = 0;
         this._blackDropShadowFilter.angle = 45;
         this._blackDropShadowFilter.color = BLACK_COLOR;
         this._blackDropShadowFilter.alpha = 1;
         this._blackDropShadowFilter.blurX = 14;
         this._blackDropShadowFilter.blurY = 14;
         this._blackDropShadowFilter.strength = 1;
         this._blackDropShadowFilter.quality = BitmapFilterQuality.MEDIUM;
         this._blackDropShadowFilter.knockout = false;
         this._blackDropShadowFilter.inner = false;
         this._blackDropShadowFilter.hideObject = false;
         TextFieldEx.setNoTranslate(this.label,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_LABEL_STR))
         {
            this.label.text = this._labelStr;
         }
         if(isInvalid(INVALID_ITEM_VIEW))
         {
            if(this._currentPhase == BattleTutorialProgressBar.PHASE_NONE_ID || this._currentPhase == BattleTutorialProgressBar.PHASE_DEFAULT_ID)
            {
               this.bg.visible = true;
               this.label.filters = [this._whiteDropShadowFilter];
               this.label.textColor = BLACK_COLOR;
               alpha = Values.DEFAULT_ALPHA;
               blendMode = BlendMode.NORMAL;
            }
            else if(this._currentPhase == BattleTutorialProgressBar.PHASE_FAIL_ID)
            {
               this.bg.visible = true;
               this.label.filters = [this._blackDropShadowFilter];
               this.label.textColor = BLACK_COLOR;
               alpha = Values.DEFAULT_ALPHA;
               blendMode = BlendMode.NORMAL;
            }
            else if(this._currentPhase == BattleTutorialProgressBar.PHASE_DONE_ID)
            {
               this.bg.visible = false;
               this.label.filters = [this._blackDropShadowFilter];
               this.label.textColor = WHITE_COLOR;
               alpha = PHASE_DONE_ALPHA;
               blendMode = BlendMode.ADD;
            }
            else if(this._currentPhase == BattleTutorialProgressBar.PHASE_CURRENT_ID)
            {
               this.bg.visible = false;
               this.label.filters = [this._blackDropShadowFilter];
               this.label.textColor = WHITE_COLOR;
               alpha = Values.DEFAULT_ALPHA;
               blendMode = BlendMode.ADD;
            }
         }
      }
      
      public function setPhase(param1:int) : void
      {
         if(this._currentPhase != param1)
         {
            this._currentPhase = param1;
            invalidate(INVALID_ITEM_VIEW);
         }
      }
      
      public function updateLabelText(param1:String) : void
      {
         if(param1 != this._labelStr)
         {
            this._labelStr = param1;
            invalidate(INVALID_LABEL_STR);
         }
      }
      
      override protected function onDispose() : void
      {
         this.label.filters = null;
         this.label = null;
         this.bg = null;
         this._whiteDropShadowFilter = null;
         this._blackDropShadowFilter = null;
         super.onDispose();
      }
   }
}
