package net.wg.gui.lobby.modulesPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ParamsItemVO extends DAAPIDataClass
   {
       
      
      public var paramValue:String = "";
      
      public var paramName:String = "";
      
      public function ParamsItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
