package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.data.TweenConstraintsVO;
   import net.wg.data.constants.TweenTypes;
   import net.wg.infrastructure.managers.ITweenManagerHelper;
   
   public class TweenManagerHelper implements ITweenManagerHelper
   {
      
      private static const NOT_INIT:String = "Initialize TweenManagerHelper before using.";
       
      
      private var data:TweenConstraintsVO;
      
      private var durationByType:Vector.<Object>;
      
      public function TweenManagerHelper(param1:TweenConstraintsVO)
      {
         super();
         this.data = param1;
         this.durationByType = new <Object>[{
            "types":TweenTypes.FADE_TYPES,
            "duration":param1.fadeDuration
         },{
            "types":TweenTypes.BLINKING_TYPES,
            "duration":param1.blinkingDuration
         },{
            "types":TweenTypes.MOVE_TYPES,
            "duration":param1.moveDuration
         },{
            "types":TweenTypes.GLOW_TYPES,
            "duration":param1.glowDuration
         },{
            "types":TweenTypes.SHADOW_TYPES,
            "duration":param1.shadowDuration
         },{
            "types":TweenTypes.TURN_TYPES,
            "duration":param1.halfTurnDuration
         }];
      }
      
      public function getFadeDuration() : int
      {
         return this.data.fadeDuration;
      }
      
      public function getFadeDurationSlow() : int
      {
         return this.data.fadeDuration << 1;
      }
      
      public function getFadeDurationFast() : int
      {
         return this.data.fadeDuration >> 1;
      }
      
      public function getMoveDuration() : int
      {
         return this.data.moveDuration;
      }
      
      public function getMoveDurationSlow() : int
      {
         return this.data.moveDuration << 1;
      }
      
      public function getMoveDurationFast() : int
      {
         return this.data.moveDuration >> 1;
      }
      
      public function getGlowDuration() : int
      {
         return this.data.glowDuration;
      }
      
      public function getGlowDurationSlow() : int
      {
         return this.data.glowDuration << 1;
      }
      
      public function getGlowDurationFast() : int
      {
         return this.data.glowDuration >> 1;
      }
      
      public function getShadowDuration() : int
      {
         return this.data.shadowDuration;
      }
      
      public function getShadowDurationFast() : int
      {
         return this.data.shadowDuration << 1;
      }
      
      public function getShadowDurationSlow() : int
      {
         return this.data.shadowDuration >> 1;
      }
      
      public function getBlinkingDuration() : int
      {
         return this.data.blinkingDuration;
      }
      
      public function getTranslationLength() : int
      {
         return this.data.translationLength;
      }
      
      public function getFadeAlphaMax() : int
      {
         return this.data.fadeAlphaMax;
      }
      
      public function getFadeAlphaMin() : int
      {
         return this.data.fadeAlphaMin;
      }
      
      public function getHalfTurnDuration() : int
      {
         return this.data.halfTurnDuration;
      }
      
      public function getHalfTurnDelay() : int
      {
         return this.data.halfTurnDelay;
      }
      
      public function getSimilarTypes(param1:String) : Vector.<String>
      {
         var _loc3_:Vector.<String> = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.durationByType.length)
         {
            _loc3_ = this.durationByType[_loc2_].types;
            if(_loc3_.indexOf(param1) >= 0)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return new Vector.<String>(0);
      }
      
      public function dispose() : void
      {
         this.data = null;
         this.durationByType.splice(0,this.durationByType.length);
         this.durationByType = null;
      }
   }
}
