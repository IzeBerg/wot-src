package net.wg.gui.lobby.confirmModuleWindow
{
   import net.wg.gui.lobby.window.ConfirmItemWindowVO;
   
   public class ModuleInfoVo extends ConfirmItemWindowVO
   {
       
      
      public var level:int = -1;
      
      public var moduleLabel:String = "";
      
      public var extraModuleInfo:String = "";
      
      public var highlightType:String = "";
      
      public var overlayType:String = "";
      
      public function ModuleInfoVo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
   }
}
