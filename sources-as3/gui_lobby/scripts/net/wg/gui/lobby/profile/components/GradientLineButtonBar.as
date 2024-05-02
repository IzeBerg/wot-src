package net.wg.gui.lobby.profile.components
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import flash.display.SpreadMethod;
   import flash.geom.Matrix;
   import net.wg.data.constants.Errors;
   
   public class GradientLineButtonBar extends LineButtonBar
   {
      
      private static var color:uint = 3749680;
       
      
      public function GradientLineButtonBar()
      {
         super();
      }
      
      override protected function drawLine() : void
      {
         var _loc1_:Number = 1;
         var _loc2_:DisplayObject = _renderers[selectedIndex] as DisplayObject;
         App.utils.asserter.assertNotNull(_loc2_,"selItem" + Errors.CANT_NULL);
         var _loc3_:Graphics = line.graphics;
         var _loc4_:uint = _loc2_.x;
         _loc3_.clear();
         if(_loc4_ > 0)
         {
            _loc3_.beginFill(color,1);
            _loc3_.drawRect(0,0,_loc4_,_loc1_);
            _loc3_.endFill();
         }
         this.drawGradientLine(_loc3_,_loc4_ + _loc2_.width,0,width,_loc1_,[1,0.1],[color,color]);
         line.y = this.actualHeight - line.height;
         var _loc5_:DisplayObjectContainer = line.parent;
         if(_loc5_)
         {
            _loc5_.setChildIndex(line,_loc5_.numChildren - 1);
         }
      }
      
      private function drawGradientLine(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number, param6:Array, param7:Array) : void
      {
         var _loc8_:String = GradientType.LINEAR;
         var _loc9_:Array = [125,255];
         var _loc10_:Matrix = new Matrix();
         var _loc11_:Number = 0;
         _loc10_.createGradientBox(param4,param5,_loc11_,0,0);
         param1.beginGradientFill(_loc8_,param7,param6,_loc9_,_loc10_,SpreadMethod.PAD);
         param1.drawRect(param2,param3,param4,param5);
         param1.endFill();
      }
   }
}
