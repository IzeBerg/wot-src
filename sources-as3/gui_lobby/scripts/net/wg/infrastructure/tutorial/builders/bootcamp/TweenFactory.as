package net.wg.infrastructure.tutorial.builders.bootcamp
{
   import fl.motion.easing.Cubic;
   import flash.display.DisplayObject;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TWEEN_EFFECT_TYPES;
   import net.wg.gui.components.advanced.vo.TutorialTweenEffectVO;
   import scaleform.clik.motion.Tween;
   
   public class TweenFactory
   {
      
      private static const TWEEN_DURATION_APPEAR:int = 500;
       
      
      public function TweenFactory()
      {
         super();
      }
      
      public function getTweeForComponent(param1:DisplayObject, param2:TutorialTweenEffectVO) : Tween
      {
         var _loc3_:int = param2.flags;
         var _loc4_:Object = {};
         var _loc5_:DisplayObject = param1;
         if(_loc3_ & TWEEN_EFFECT_TYPES.TOP)
         {
            _loc4_.y = _loc5_.y;
            _loc5_.y -= _loc5_.height;
         }
         else if(_loc3_ & TWEEN_EFFECT_TYPES.BOTTOM)
         {
            _loc4_.y = _loc5_.y;
            _loc5_.y += _loc5_.height;
         }
         else if(_loc3_ & TWEEN_EFFECT_TYPES.RIGHT)
         {
            _loc4_.x = _loc5_.x;
            _loc5_.x += _loc5_.width;
         }
         else if(_loc3_ & TWEEN_EFFECT_TYPES.LEFT)
         {
            _loc4_.x = _loc5_.x;
            _loc5_.x -= _loc5_.width;
         }
         if(_loc3_ & TWEEN_EFFECT_TYPES.ALPHA)
         {
            _loc4_.alpha = 1;
            _loc5_.alpha = 0;
         }
         var _loc6_:Tween = new Tween(TWEEN_DURATION_APPEAR,_loc5_,_loc4_,{
            "paused":false,
            "ease":Cubic.easeOut,
            "delay":(param2.delay != Values.DEFAULT_INT ? param2.delay : 0)
         });
         _loc6_.fastTransform = false;
         return _loc6_;
      }
   }
}
