package net.wg.gui.components.ribbon.data
{
   public class DamageSourceSetting
   {
       
      
      private var _iconPath:String = "";
      
      public function DamageSourceSetting(param1:String)
      {
         super();
         this._iconPath = param1;
      }
      
      public function getCurrentIcon(param1:String) : String
      {
         return this._iconPath;
      }
   }
}
