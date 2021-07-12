package net.wg.gui.bootcamp.messageWindow.rewardAnimation
{
   import fl.transitions.easing.Regular;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Point;
   import net.wg.gui.bootcamp.BCHighlightsBase;
   import net.wg.gui.bootcamp.messageWindow.events.MessageViewEvent;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class RewardAnimation extends Sprite implements IDisposable
   {
      
      private static const PATH_LINKAGE:String = "RewardPathAnimationUI";
      
      private static const ICON_TIME:int = 500;
      
      private static const PATH_ALPHA_TIME:int = 500;
      
      private static const MAX_DISTANCE:int = 300;
      
      private static const DEGREE_180:int = 180;
      
      private static const DEGREE_360:int = 360;
      
      private static const DOT_DELIMITER:String = ".";
      
      private static const COMPONENT_DELIMITER:String = ":";
      
      private static const EQUAL_DELIMITER:String = "=";
      
      private static const DATA_FIELD:String = "data";
      
      private static const DIGIT:RegExp = new RegExp(/^\d+$/);
       
      
      private var _iconReward:Image;
      
      private var _iconRewardPath:RewardPathAnimation = null;
      
      private var _targetRewardIcon:DisplayObject = null;
      
      private var _iconTween:Tween = null;
      
      private var _pathAlphaTween:Tween = null;
      
      public function RewardAnimation(param1:String, param2:String, param3:String)
      {
         this._iconReward = new Image();
         super();
         this.setup(param1,param2,param3);
      }
      
      private static function getComponent(param1:String) : DisplayObject
      {
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc2_:Array = param1.split(COMPONENT_DELIMITER);
         var _loc3_:DisplayObjectContainer = BCHighlightsBase.seekView(_loc2_[0]);
         var _loc4_:String = _loc2_[1];
         var _loc5_:Array = _loc4_.split(DOT_DELIMITER);
         var _loc6_:DisplayObject = _loc3_;
         var _loc7_:DisplayObject = null;
         var _loc8_:Object = null;
         var _loc9_:uint = _loc5_.length;
         var _loc10_:uint = 0;
         while(_loc10_ < _loc9_)
         {
            if(!(_loc6_ is DisplayObjectContainer))
            {
               return null;
            }
            _loc11_ = _loc5_[_loc10_];
            DIGIT.lastIndex = 0;
            if(_loc11_.match(DIGIT))
            {
               _loc6_ = (_loc6_ as DisplayObjectContainer).getChildAt(int(_loc11_)) as DisplayObject;
            }
            else if(_loc11_.indexOf(EQUAL_DELIMITER) != -1)
            {
               _loc12_ = _loc11_.split(EQUAL_DELIMITER);
               _loc13_ = (_loc6_ as DisplayObjectContainer).numChildren;
               _loc14_ = 0;
               while(_loc14_ < _loc13_)
               {
                  _loc7_ = (_loc6_ as DisplayObjectContainer).getChildAt(_loc14_);
                  if(_loc7_.hasOwnProperty(DATA_FIELD))
                  {
                     _loc8_ = _loc7_[DATA_FIELD];
                     if(_loc8_[_loc12_[0]] == _loc12_[1])
                     {
                        _loc6_ = _loc7_;
                        break;
                     }
                  }
                  _loc14_++;
               }
            }
            else
            {
               _loc6_ = (_loc6_ as DisplayObjectContainer).getChildByName(_loc5_[_loc10_]) as DisplayObject;
            }
            _loc10_++;
         }
         return _loc6_;
      }
      
      private function setup(param1:String, param2:String, param3:String) : void
      {
         this._iconReward.source = param1;
         this._iconReward.visible = false;
         this._iconRewardPath = RewardPathAnimation(App.utils.classFactory.getComponent(PATH_LINKAGE,RewardPathAnimation));
         this._iconRewardPath.visible = false;
         addChild(this._iconRewardPath);
         addChild(this._iconReward);
         this._iconRewardPath.setup(param2);
         this._targetRewardIcon = getComponent(param3);
      }
      
      public function startAnimation() : void
      {
         if(this._targetRewardIcon == null)
         {
            dispatchEvent(new MessageViewEvent(MessageViewEvent.REWARD_ANIMATION_COMPLETE));
            return;
         }
         this._iconReward.x = -this._iconReward.width >> 1;
         this._iconReward.y = -this._iconReward.height >> 1;
         var _loc1_:Point = this._targetRewardIcon.localToGlobal(new Point(0,0));
         var _loc2_:Point = globalToLocal(_loc1_);
         var _loc3_:Number = this._targetRewardIcon.width / this._iconReward.width;
         this.clearIconTween();
         this._iconTween = new Tween(ICON_TIME,this._iconReward,{
            "x":_loc2_.x,
            "y":_loc2_.y,
            "scaleX":_loc3_,
            "scaleY":_loc3_
         },{
            "ease":Regular.easeIn,
            "onChange":this.onAnimationChange,
            "onComplete":this.stopAnimation
         });
         this._iconReward.visible = true;
      }
      
      private function onAnimationChange() : void
      {
         this.calcRewardPath(this._iconReward.x + (this._iconReward.width >> 1),this._iconReward.y + (this._iconReward.height >> 1));
      }
      
      private function stopAnimation() : void
      {
         this._iconReward.visible = false;
         this._iconRewardPath.disappear();
         this.clearPathTween();
         this._pathAlphaTween = new Tween(PATH_ALPHA_TIME,this._iconRewardPath,{"alpha":0});
      }
      
      public final function dispose() : void
      {
         this.clearIconTween();
         this.clearPathTween();
         this._targetRewardIcon = null;
         this._iconReward.dispose();
         this._iconReward = null;
         this._iconRewardPath.dispose();
         this._iconRewardPath = null;
      }
      
      private function calcRewardPath(param1:Number, param2:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc3_:Number = Math.sqrt(param1 * param1 + param2 * param2);
         if(_loc3_ > 0)
         {
            if(_loc3_ > MAX_DISTANCE)
            {
               _loc3_ = MAX_DISTANCE;
            }
            _loc4_ = -Math.atan2(0 - param1,0 - param2) * DEGREE_180 / Math.PI;
            if(_loc4_ > this._iconRewardPath.rotation + DEGREE_180)
            {
               _loc4_ -= DEGREE_360;
            }
            if(_loc4_ < this._iconRewardPath.rotation - DEGREE_180)
            {
               _loc4_ += DEGREE_360;
            }
            this._iconRewardPath.setDistance(_loc3_);
            this._iconRewardPath.rotation = _loc4_;
            this._iconRewardPath.x = param1;
            this._iconRewardPath.y = param2;
            this._iconRewardPath.visible = true;
         }
         else
         {
            this._iconRewardPath.visible = false;
         }
      }
      
      private function clearIconTween() : void
      {
         if(this._iconTween)
         {
            this._iconTween.paused = true;
            this._iconTween.dispose();
            this._iconTween = null;
         }
      }
      
      private function clearPathTween() : void
      {
         if(this._pathAlphaTween)
         {
            this._pathAlphaTween.paused = true;
            this._pathAlphaTween.dispose();
            this._pathAlphaTween = null;
         }
      }
   }
}
