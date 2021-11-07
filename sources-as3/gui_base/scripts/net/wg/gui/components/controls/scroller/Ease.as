package net.wg.gui.components.controls.scroller
{
   import flash.errors.IllegalOperationError;
   
   public class Ease
   {
      
      private static var _instance:Ease;
       
      
      public function Ease()
      {
         super();
         App.instance.utils.asserter.assert(_instance == null,"Singleton error!",IllegalOperationError);
      }
      
      public static function get instance() : Ease
      {
         return _instance = _instance || new Ease();
      }
      
      public function easeOut(param1:Number) : Number
      {
         var _loc2_:Number = param1 - 1;
         return _loc2_ * _loc2_ * _loc2_ + 1;
      }
   }
}
