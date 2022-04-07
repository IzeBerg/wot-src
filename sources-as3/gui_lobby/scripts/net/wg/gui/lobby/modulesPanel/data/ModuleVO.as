package net.wg.gui.lobby.modulesPanel.data
{
   public class ModuleVO extends DeviceVO
   {
       
      
      public var level:int = -1;
      
      public var paramValues:String = "";
      
      public var paramNames:String = "";
      
      public var extraModuleInfo:String = "";
      
      public var count:String = "";
      
      public var highlightedParameterIdx:int = -1;
      
      public function ModuleVO(param1:Object)
      {
         super(param1);
      }
   }
}
