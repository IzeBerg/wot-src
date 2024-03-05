package net.wg.gui.battle.views.newbieHint.containers
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.battleHint.vo.BattleHintVO;
   import net.wg.gui.battle.views.newbieHint.constants.HINT_LABELS;
   
   public class HintContainer extends MovieClip
   {
       
      
      public var icon:HintIconContainer = null;
      
      public var txt:HintTextContainer = null;
      
      public var backgroundIcon:HintComponentContainer = null;
      
      public var backgroundTxt:HintComponentContainer = null;
      
      public var hintMask:HintComponentContainer = null;
      
      private var _initialWidth:int;
      
      private var _initialTextMargin:int;
      
      private const BG_TXT_MARGIN_RIGHT:uint = 60;
      
      private const BG_TXT_MARTIN_HEIGHT:uint = 60;
      
      private const BACKGROUND_MIN_HEIGHT:uint = 130;
      
      public function HintContainer()
      {
         super();
         this._initialWidth = this.backgroundIcon.width + this.backgroundTxt.width;
         this._initialTextMargin = this.backgroundTxt.height - this.txt.height >> 1;
      }
      
      public final function dispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.txt.dispose();
         this.txt = null;
         this.backgroundIcon.dispose();
         this.backgroundIcon = null;
         this.backgroundTxt.dispose();
         this.backgroundTxt = null;
         this.hintMask.dispose();
         this.hintMask = null;
      }
      
      public function hideHint() : void
      {
         gotoAndPlay(HINT_LABELS.HIDE_LABEL);
      }
      
      public function showHint(param1:BattleHintVO) : void
      {
         gotoAndPlay(HINT_LABELS.SHOW_LABEL);
         this.icon.setHintData(param1.iconSource);
         this.txt.setHintData(param1.message);
         this.updateSize();
      }
      
      public function stopHint() : void
      {
         gotoAndStop(1);
         this.txt.clear();
         this.icon.clear();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.txt.updateStage(param1,param2);
         this.updateSize();
      }
      
      private function updateSize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = Math.max(this.BACKGROUND_MIN_HEIGHT,this.txt.height + this.BG_TXT_MARTIN_HEIGHT) | 0;
         this.backgroundTxt.setSize(this.txt.getWidth() + this.BG_TXT_MARGIN_RIGHT | 0,_loc3_);
         this.backgroundIcon.setSize(this.backgroundIcon.width,_loc3_);
         _loc1_ = this.backgroundIcon.width + this.backgroundTxt.width;
         _loc2_ = this._initialWidth - _loc1_ >> 1;
         this.hintMask.setSize(_loc1_,this.backgroundIcon.height);
         this.backgroundTxt.setOffset(_loc2_);
         this.backgroundIcon.setOffset(_loc2_);
         this.icon.setOffset(_loc2_);
         this.txt.setOffset(_loc2_,(this.backgroundTxt.height - this.txt.height >> 1) - this._initialTextMargin);
         this.icon.setVisibleArea(this.backgroundIcon.width,this.backgroundIcon.height);
         this.hintMask.setOffset(_loc2_);
      }
   }
}
