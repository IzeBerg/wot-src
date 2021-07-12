package net.wg.gui.lobby.colorSettings.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ColorSettingsUpdateVO extends DAAPIDataClass
   {
       
      
      public var COLOR_GRADING_TECHNIQUE:int = 0;
      
      public var colorFilterIntensity:int = 0;
      
      public var brightnessCorrection:int = 0;
      
      public var saturationCorrection:int = 0;
      
      public var contrastCorrection:int = 0;
      
      public function ColorSettingsUpdateVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
