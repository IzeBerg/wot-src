package net.wg.gui.lobby.colorSettings.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ColorSettingsRendererVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var label:String = "";
      
      public var id:int = -1;
      
      public function ColorSettingsRendererVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
