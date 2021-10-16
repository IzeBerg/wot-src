package net.wg.mock.utils
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import net.wg.utils.ITweenAnimator;
   
   public class MockTweenAnimator implements ITweenAnimator
   {
       
      
      public function MockTweenAnimator()
      {
         super();
      }
      
      public function addFadeInAnim(param1:DisplayObject, param2:ITweenAnimatorHandler) : void
      {
      }
      
      public function addFadeInAnimEx(param1:DisplayObject) : ITween
      {
         return null;
      }
      
      public function addFadeOutAnim(param1:DisplayObject, param2:ITweenAnimatorHandler) : void
      {
      }
      
      public function addFadeOutAnimEx(param1:DisplayObject) : ITween
      {
         return null;
      }
      
      public function addHalfTurnAnim(param1:DisplayObject) : void
      {
      }
      
      public function addHalfTurnAnimEx(param1:DisplayObject) : ITween
      {
         return null;
      }
      
      public function addMoveDownAnim(param1:DisplayObject, param2:Number, param3:ITweenAnimatorHandler) : void
      {
      }
      
      public function addMoveDownAnimEx(param1:DisplayObject, param2:Number) : ITween
      {
         return null;
      }
      
      public function addMoveUpAnim(param1:DisplayObject, param2:Number, param3:ITweenAnimatorHandler) : void
      {
      }
      
      public function addMoveUpAnimEx(param1:DisplayObject, param2:Number) : ITween
      {
         return null;
      }
      
      public function blinkInfinity(param1:DisplayObject) : void
      {
      }
      
      public function createPropsForAlpha(param1:DisplayObject, param2:uint, param3:Number, param4:uint = 0) : ITweenPropertiesVO
      {
         return null;
      }
      
      public function createPropsForFrameBasedAnim(param1:DisplayObject, param2:int, param3:int) : ITweenPropertiesVO
      {
         return null;
      }
      
      public function dispose() : void
      {
      }
      
      public function onComplete(param1:ITween) : void
      {
      }
      
      public function onStart(param1:ITween) : void
      {
      }
      
      public function removeAnims(param1:DisplayObject) : void
      {
      }
   }
}
