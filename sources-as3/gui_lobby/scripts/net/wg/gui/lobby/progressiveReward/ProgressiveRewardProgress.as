package net.wg.gui.lobby.progressiveReward
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.progressiveReward.data.ProgressiveRewardStepVO;
   import net.wg.gui.lobby.progressiveReward.data.ProgressiveRewardVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ProgressiveRewardProgress extends UIComponentEx
   {
      
      private static const GAP:int = 20;
       
      
      private var _stepRenderers:Vector.<MovieClip> = null;
      
      private var _progressiveData:ProgressiveRewardVO = null;
      
      public function ProgressiveRewardProgress()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._stepRenderers)
         {
            this._stepRenderers.splice(0,this._stepRenderers.length);
            this._stepRenderers = null;
         }
         this._progressiveData = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Vector.<ProgressiveRewardStepVO> = null;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:ProgressiveRewardStepVO = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:MovieClip = null;
         var _loc10_:Class = null;
         var _loc11_:Vector.<MovieClip> = null;
         super.draw();
         if(this._progressiveData && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._progressiveData.getSteps();
            _loc2_ = _loc1_.length;
            if(!this._stepRenderers)
            {
               this._stepRenderers = new Vector.<MovieClip>();
            }
            _loc4_ = _loc2_ - this._stepRenderers.length;
            if(_loc4_ > 0)
            {
               while(_loc4_ > 0)
               {
                  _loc10_ = App.utils.classFactory.getClass(Linkages.PROGRESSIVE_REWARD_GIFT_UI);
                  _loc3_ = new _loc10_();
                  addChild(_loc3_);
                  this._stepRenderers.push(_loc3_);
                  _loc4_--;
               }
            }
            else if(_loc4_ < 0)
            {
               _loc11_ = this._stepRenderers.splice(-_loc4_,_loc4_);
               for each(_loc3_ in _loc11_)
               {
                  removeChild(_loc3_);
               }
            }
            _loc5_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc2_)
            {
               _loc3_ = this._stepRenderers[_loc8_];
               _loc7_ = _loc1_[_loc8_].stepState;
               App.utils.asserter.assertFrameExists(_loc7_,_loc3_);
               _loc3_.gotoAndStop(_loc7_);
               _loc3_.x = _loc5_;
               addChild(_loc3_);
               _loc5_ += GAP;
               _loc8_++;
            }
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      public function update(param1:ProgressiveRewardVO) : void
      {
         if(param1 && this._progressiveData != param1)
         {
            this._progressiveData = param1;
            invalidateData();
         }
      }
   }
}
