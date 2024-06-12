package net.wg.gui.lobby.techtree.helpers
{
   import flash.display.CapsStyle;
   import flash.display.Graphics;
   import flash.display.JointStyle;
   import flash.display.LineScaleMode;
   import flash.geom.Point;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.techtree.constants.LineStyle;
   
   public class DrawHelper
   {
      
      private static var _instance:DrawHelper = null;
       
      
      public const DASHED_STEP:uint = 4;
      
      public function DrawHelper()
      {
         App.utils.asserter.assertNull(_instance,"Class instance" + Errors.ALREADY_REGISTERED);
         super();
         _instance = this;
      }
      
      public static function get instance() : DrawHelper
      {
         if(_instance == null)
         {
            new DrawHelper();
         }
         return _instance;
      }
      
      public function drawLine(param1:Graphics, param2:Point, param3:Point, param4:Number, param5:uint = 0, param6:Number = 1.0, param7:uint = 0) : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         param1.lineStyle(param4,param5,param6,false,LineScaleMode.NORMAL,CapsStyle.SQUARE,JointStyle.BEVEL);
         param1.moveTo(param2.x,param2.y);
         switch(param7)
         {
            case LineStyle.DASHED:
               if(param2.y == param3.y)
               {
                  _loc8_ = param2.x;
                  _loc9_ = param3.x - this.DASHED_STEP - param4;
                  while(_loc8_ < _loc9_)
                  {
                     _loc8_ += this.DASHED_STEP - param4;
                     param1.lineTo(_loc8_,param3.y);
                     _loc8_ += this.DASHED_STEP + param4;
                     param1.moveTo(_loc8_,param3.y);
                  }
               }
         }
         param1.lineTo(param3.x,param3.y);
      }
   }
}
