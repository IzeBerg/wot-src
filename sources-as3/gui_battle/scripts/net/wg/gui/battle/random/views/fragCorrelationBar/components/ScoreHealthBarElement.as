package net.wg.gui.battle.random.views.fragCorrelationBar.components
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class ScoreHealthBarElement extends BattleUIComponent
   {
      
      private static const ALLY_DEFAULT_SCHEME:String = "ally";
      
      private static const ENEMY_COLORBLIND_SCHEME:String = "enemy_colorblind";
      
      private static const ENEMY_DEFAULT_SCHEME:String = "enemy";
      
      private static const POSTFIX_BG:String = "_bg";
      
      private static const SCHEME_TO_BAR:Object = {
         "ally":"green_bar",
         "enemy_colorblind":"purple_bar",
         "enemy":"red_bar"
      };
       
      
      public var hpBar:MovieClip = null;
      
      public var fillLayer:MovieClip = null;
      
      public var fillLayerBG:MovieClip = null;
      
      private var _currentState:String = "";
      
      private var _bitMapDataBar:BitmapData = null;
      
      private var _bitMapDataBarBG:BitmapData = null;
      
      private var _actualHealthBarPercentage:Number = 1.0;
      
      private var _wholeElementWidth:int = 0;
      
      private var _originalHPBarX:int = 0;
      
      public function ScoreHealthBarElement()
      {
         super();
         this._originalHPBarX = this.hpBar.x;
      }
      
      override protected function onDispose() : void
      {
         this.hpBar = null;
         this.fillLayer = null;
         this._bitMapDataBar = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.hpBar.x = this._originalHPBarX + this._actualHealthBarPercentage * this._wholeElementWidth;
            this.drawGraphic(this._actualHealthBarPercentage);
         }
      }
      
      public function setColor(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = ALLY_DEFAULT_SCHEME;
         if(param1)
         {
            _loc3_ = !!param2 ? ENEMY_COLORBLIND_SCHEME : ENEMY_DEFAULT_SCHEME;
         }
         if(_loc3_ == this._currentState)
         {
            return;
         }
         var _loc4_:String = SCHEME_TO_BAR[_loc3_];
         this._bitMapDataBar = App.utils.classFactory.getObject(_loc4_) as BitmapData;
         var _loc5_:String = SCHEME_TO_BAR[_loc3_] + POSTFIX_BG;
         this._bitMapDataBarBG = App.utils.classFactory.getObject(_loc5_) as BitmapData;
         this._currentState = _loc3_;
         gotoAndStop(this._currentState);
         invalidateData();
      }
      
      public function setWidth(param1:int) : void
      {
         this._wholeElementWidth = param1;
         invalidateData();
      }
      
      public function setHealth(param1:int) : void
      {
         this._actualHealthBarPercentage = Math.max(0,Math.min(param1 * 0.01,1));
         invalidateData();
      }
      
      private function drawGraphic(param1:Number) : void
      {
         if(!this._bitMapDataBar)
         {
            return;
         }
         var _loc2_:Graphics = this.fillLayer.graphics;
         _loc2_.clear();
         _loc2_.beginBitmapFill(this._bitMapDataBar);
         _loc2_.drawRect(0,0,param1 * this._wholeElementWidth,this._bitMapDataBar.height);
         _loc2_.endFill();
         if(!this._bitMapDataBarBG)
         {
            return;
         }
         var _loc3_:Graphics = this.fillLayerBG.graphics;
         _loc3_.clear();
         _loc3_.beginBitmapFill(this._bitMapDataBarBG);
         _loc3_.drawRect(0,0,this._wholeElementWidth,this._bitMapDataBarBG.height);
         _loc3_.endFill();
      }
   }
}
