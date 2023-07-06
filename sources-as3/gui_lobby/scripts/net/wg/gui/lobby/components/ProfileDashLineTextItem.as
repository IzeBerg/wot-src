package net.wg.gui.lobby.components
{
   import net.wg.gui.components.advanced.DashLineTextItem;
   
   public class ProfileDashLineTextItem extends DashLineTextItem
   {
       
      
      public function ProfileDashLineTextItem()
      {
         super();
      }
      
      private static function makeHtmlText(param1:String, param2:uint) : String
      {
         return "<font color=\'#" + param2.toString(16) + "\'>" + param1 + "</font>";
      }
      
      public function receiveAndSetValue(param1:*, param2:uint, param3:Function = null) : void
      {
         var _loc4_:String = null;
         if(param1 != -1)
         {
            this.enabled = true;
            _loc4_ = param3 != null ? param3() : param1.toString();
            this.value = makeHtmlText(_loc4_,param2);
         }
         else
         {
            this.enabled = false;
         }
      }
   }
}
