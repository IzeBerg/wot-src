package net.wg.gui.lobby.settings.vo.base
{
   public class SettingsDataIncomeVo extends SettingsDataVo
   {
       
      
      public function SettingsDataIncomeVo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:SettingsDataVo = null;
         keys.push(param1);
         _loc3_ = new SettingsDataVo();
         _loc3_.keys = Vector.<String>(param2.keys);
         _loc3_.values = Vector.<Object>(param2.values);
         values.push(_loc3_);
         return false;
      }
   }
}
