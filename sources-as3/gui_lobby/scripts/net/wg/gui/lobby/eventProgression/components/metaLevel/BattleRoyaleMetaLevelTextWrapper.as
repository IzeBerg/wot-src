package net.wg.gui.lobby.eventProgression.components.metaLevel
{
   import flash.display.MovieClip;
   import flash.filters.DropShadowFilter;
   import scaleform.clik.constants.InvalidationType;
   
   public class BattleRoyaleMetaLevelTextWrapper extends MetaLevelTextWrapper
   {
      
      private static const START_LEVEL_ID:int = 1;
      
      private static const FINAL_LEVEL_ID:int = 4;
      
      private static const FINAL_LEVEL_COLOR:int = 2293760;
      
      private static const DEFAULT_COLOR:int = 0;
      
      private static const PATTERN_ALPHA_START_LEVEL:Number = 0.8;
      
      private static const PATTERN_ALPHA_DEFAULT:Number = 0.4;
      
      private static const GRADIENT_ALPHA_START_LEVEL:Number = 0.7;
      
      private static const GRADIENT_ALPHA_DEFAULT:Number = 0.6;
      
      private static const FILTER_ANGLE:int = 90;
      
      private static const FILTER_STRENGTH:Number = 1.7;
      
      private static const FILTER_BLUR:Object = {};
      
      private static const FILTER_DISTANCE:Object = {};
      
      {
         FILTER_BLUR[BaseMetaLevel.EXTRA_SMALL] = 6;
         FILTER_BLUR[BaseMetaLevel.SMALL] = 8;
         FILTER_BLUR[BaseMetaLevel.MEDIUM] = 10;
         FILTER_BLUR[BaseMetaLevel.LARGE] = 12;
         FILTER_BLUR[BaseMetaLevel.EXTRA_LARGE] = 12;
         FILTER_DISTANCE[BaseMetaLevel.EXTRA_SMALL] = 1;
         FILTER_DISTANCE[BaseMetaLevel.SMALL] = 1;
         FILTER_DISTANCE[BaseMetaLevel.MEDIUM] = 1;
         FILTER_DISTANCE[BaseMetaLevel.LARGE] = 2;
         FILTER_DISTANCE[BaseMetaLevel.EXTRA_LARGE] = 3;
      }
      
      public var pattern:MovieClip;
      
      public var gradient:MovieClip;
      
      private var _size:String = null;
      
      private var _bgId:int = -1;
      
      private var _filter:DropShadowFilter = null;
      
      private var _isTextReady:Boolean = false;
      
      public function BattleRoyaleMetaLevelTextWrapper()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._filter = new DropShadowFilter();
         this._filter.angle = FILTER_ANGLE;
         this._filter.strength = FILTER_STRENGTH;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._isTextReady && this._bgId > -1 && this._size != null && isInvalid(InvalidationType.DATA))
         {
            if(this._bgId == START_LEVEL_ID)
            {
               this.pattern.alpha = PATTERN_ALPHA_START_LEVEL;
               this.gradient.alpha = GRADIENT_ALPHA_START_LEVEL;
            }
            else
            {
               this.pattern.alpha = PATTERN_ALPHA_DEFAULT;
               this.gradient.alpha = GRADIENT_ALPHA_DEFAULT;
            }
            this._filter.blurX = FILTER_BLUR[this._size];
            this._filter.blurY = FILTER_BLUR[this._size];
            this._filter.distance = FILTER_DISTANCE[this._size];
            if(this._bgId == FINAL_LEVEL_ID)
            {
               this._filter.color = FINAL_LEVEL_COLOR;
            }
            else
            {
               this._filter.color = DEFAULT_COLOR;
            }
            overlay.tf.filters = [this._filter];
         }
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         this.gradient.width = tf.width;
         this.gradient.height = tf.height;
         this._isTextReady = true;
      }
      
      override protected function onDispose() : void
      {
         this.pattern = null;
         this.gradient = null;
         this._filter = null;
         super.onDispose();
      }
      
      public function set size(param1:String) : void
      {
         if(this._size != param1)
         {
            this._size = param1;
            invalidateData();
         }
      }
      
      public function set bgId(param1:int) : void
      {
         if(this._bgId != param1)
         {
            this._bgId = param1;
            invalidateData();
         }
      }
   }
}
