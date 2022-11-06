package net.wg.mock.utils
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenConstructionHandler;
   import net.wg.utils.IAnimBuilder;
   import net.wg.utils.animation.ITweenConstruction;
   
   public class MockAnimBuilder implements IAnimBuilder
   {
       
      
      public function MockAnimBuilder()
      {
         super();
      }
      
      public function addFadeIn(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = null) : ITweenConstruction
      {
         return null;
      }
      
      public function addFadeOut(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = null) : ITweenConstruction
      {
         return null;
      }
      
      public function addGlowIn(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = null) : ITweenConstruction
      {
         return null;
      }
      
      public function addGlowOut(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = null) : ITweenConstruction
      {
         return null;
      }
      
      public function addHalfTurn(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = null) : ITweenConstruction
      {
         return null;
      }
      
      public function addMoveDown(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = null) : ITweenConstruction
      {
         return null;
      }
      
      public function addMoveUp(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = null) : ITweenConstruction
      {
         return null;
      }
      
      public function addShadowIn(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = null) : ITweenConstruction
      {
         return null;
      }
      
      public function addShadowOut(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = null) : ITweenConstruction
      {
         return null;
      }
      
      public function addTween(param1:String, param2:int, param3:ITween, param4:DisplayObject, param5:ITweenConstructionHandler) : ITweenConstruction
      {
         return null;
      }
   }
}
