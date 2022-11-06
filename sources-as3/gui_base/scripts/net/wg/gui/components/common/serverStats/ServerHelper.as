package net.wg.gui.components.common.serverStats
{
   import flash.text.TextField;
   
   public class ServerHelper
   {
       
      
      public function ServerHelper()
      {
         super();
      }
      
      public static function truncateTextFieldText(param1:TextField, param2:String, param3:Boolean = true) : String
      {
         var _loc4_:String = "..";
         var _loc5_:uint = 4;
         var _loc6_:uint = param2.length;
         var _loc7_:int = !!param3 ? int(param1.width / param1.scaleX) : int(param1.height / param1.scaleY);
         param1.text = param2;
         if(param3)
         {
            while(_loc6_ > 0 && param1.textWidth + _loc5_ > _loc7_)
            {
               _loc6_--;
               param1.text = param2.substring(0,_loc6_) + _loc4_;
            }
         }
         else
         {
            while(_loc6_ > 0 && param1.textHeight + _loc5_ > _loc7_)
            {
               _loc6_--;
               param1.text = param2.substring(0,_loc6_) + _loc4_;
            }
         }
         return param1.text;
      }
   }
}
