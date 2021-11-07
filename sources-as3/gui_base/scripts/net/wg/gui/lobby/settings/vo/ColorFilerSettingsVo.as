package net.wg.gui.lobby.settings.vo
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ColorFilerSettingsVo implements IDisposable
   {
       
      
      public var colorFilterName:String;
      
      public var colorFilterImage:String;
      
      public var colorFilterChanged:Boolean = true;
      
      public function ColorFilerSettingsVo()
      {
         super();
         this.colorFilterName = SETTINGS.GRAPHICSSETTINGSOPTIONS_NONE;
         this.colorFilterImage = RES_ICONS.MAPS_ICONS_SETTINGS_COLOR_GRADING_TECHNIQUE_NONE;
      }
      
      public function dispose() : void
      {
      }
   }
}
