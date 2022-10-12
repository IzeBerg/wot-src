package net.wg.gui.lobby.techtree.controls
{
   import fl.motion.easing.Linear;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.Linkages;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.utils.Constraints;
   
   public class LevelDelimiter extends UIComponentEx
   {
      
      private static const DELIMETER_W:int = 38;
      
      private static const LEVEL_W:int = 32;
      
      private static const INV_DELIMETERS:String = "invDelimeters";
      
      private static const CONTENT_NAME:String = "content";
      
      private static const DEFAULT_LEVEL_ALPHA:Number = 0.25;
      
      private static const HIGHLIGHT_LEVEL_ALPHA:Number = 1;
      
      private static const SHOW_TWEEN_DUR:int = 200;
      
      private static const HIDE_TWEEN_DUR:int = 300;
       
      
      public var level:MovieClip;
      
      private var _content:Sprite;
      
      private var _levelNumber:int = 1;
      
      private var _delimetersContainer:Sprite;
      
      private var _showDelimeters:Boolean = true;
      
      private var _showHighlightTween:Tween = null;
      
      private var _hideHighlightTween:Tween = null;
      
      public function LevelDelimiter()
      {
         this._content = new Sprite();
         this._delimetersContainer = new Sprite();
         super();
         this._delimetersContainer.x = this.level.x + LEVEL_W;
         this._content.name = CONTENT_NAME;
         this._content.addChild(this._delimetersContainer);
         this._content.addChild(this.level);
         this.level.alpha = DEFAULT_LEVEL_ALPHA;
         addChild(this._content);
      }
      
      private static function clearTween(param1:Tween) : void
      {
         if(param1)
         {
            param1.paused = true;
            param1.dispose();
         }
      }
      
      override protected function configUI() : void
      {
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement(this._content.name,this._content,Constraints.CENTER_H);
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         clearTween(this._showHighlightTween);
         this._showHighlightTween = null;
         clearTween(this._hideHighlightTween);
         this._hideHighlightTween = null;
         this.level = null;
         this._content = null;
         this._delimetersContainer = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.level != null && isInvalid(InvalidationType.DATA))
         {
            this.level.gotoAndStop(this._levelNumber);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
            invalidate(INV_DELIMETERS);
         }
         if(isInvalid(INV_DELIMETERS))
         {
            this.updateDelimeters();
         }
      }
      
      public function hideLevelHighlight() : void
      {
         if(this._hideHighlightTween && !this._hideHighlightTween.paused)
         {
            return;
         }
         if(this.level.alpha != DEFAULT_LEVEL_ALPHA)
         {
            clearTween(this._hideHighlightTween);
            this._hideHighlightTween = new Tween(HIDE_TWEEN_DUR,this.level,{"alpha":DEFAULT_LEVEL_ALPHA},{"ease":Linear.easeNone});
         }
      }
      
      public function showLevelHighlight() : void
      {
         if(this._showHighlightTween && !this._showHighlightTween.paused)
         {
            return;
         }
         if(this.level.alpha != HIGHLIGHT_LEVEL_ALPHA)
         {
            clearTween(this._showHighlightTween);
            this._showHighlightTween = new Tween(SHOW_TWEEN_DUR,this.level,{"alpha":HIGHLIGHT_LEVEL_ALPHA},{"ease":Linear.easeNone});
         }
      }
      
      private function updateDelimeters() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         var _loc1_:int = this._delimetersContainer.numChildren;
         var _loc2_:int = !!this._showDelimeters ? int(_width / DELIMETER_W) : int(0);
         while(_loc2_ < _loc1_)
         {
            _loc1_--;
            this._delimetersContainer.removeChildAt(_loc1_);
         }
         if(_loc2_ > _loc1_)
         {
            _loc4_ = App.utils.classFactory.getClass(Linkages.NATION_TREE_LEVELS_DELIMETER);
            while(_loc2_ > _loc1_)
            {
               _loc3_ = new _loc4_();
               _loc3_.x = _loc1_ * DELIMETER_W;
               this._delimetersContainer.addChild(_loc3_);
               _loc1_++;
            }
         }
      }
      
      public function get levelNumber() : int
      {
         return this._levelNumber;
      }
      
      public function set levelNumber(param1:int) : void
      {
         if(this._levelNumber == param1)
         {
            return;
         }
         this._levelNumber = param1;
         invalidateData();
      }
      
      public function get showDelimeters() : Boolean
      {
         return this._showDelimeters;
      }
      
      public function set showDelimeters(param1:Boolean) : void
      {
         if(this._showDelimeters == param1)
         {
            return;
         }
         this._showDelimeters = param1;
         invalidate(INV_DELIMETERS);
      }
   }
}
