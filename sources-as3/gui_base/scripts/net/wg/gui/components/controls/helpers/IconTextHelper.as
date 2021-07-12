package net.wg.gui.components.controls.helpers
{
   import net.wg.data.constants.generated.ICON_TEXT_FRAMES;
   import org.idmedia.as3commons.util.StringUtils;
   
   public final class IconTextHelper
   {
      
      private static var instance:IconTextHelper = null;
       
      
      public function IconTextHelper()
      {
         super();
         instance = this;
      }
      
      public static function getInstance() : IconTextHelper
      {
         if(instance == null)
         {
            instance = new IconTextHelper();
         }
         return instance;
      }
      
      public function isIconClipVisible(param1:String) : Boolean
      {
         return StringUtils.isNotEmpty(param1) && param1 != ICON_TEXT_FRAMES.EMPTY;
      }
   }
}
