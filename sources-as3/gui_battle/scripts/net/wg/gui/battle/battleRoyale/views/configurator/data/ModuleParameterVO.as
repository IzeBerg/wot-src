package net.wg.gui.battle.battleRoyale.views.configurator.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ModuleParameterVO extends DAAPIDataClass
   {
       
      
      public var value:String = "";
      
      public var description:String = "";
      
      public function ModuleParameterVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
