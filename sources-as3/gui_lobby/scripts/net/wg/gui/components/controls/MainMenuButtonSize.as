package net.wg.gui.components.controls
{
   import flash.utils.Dictionary;
   
   public class MainMenuButtonSize
   {
      
      public static const SMALL:uint = 0;
      
      public static const REGULAR:uint = 1;
      
      public static const TEXT_SIZE:Dictionary = new Dictionary();
      
      public static const LAYOUT_LABEL:Dictionary = new Dictionary();
      
      public static const ICON_Y:Dictionary = new Dictionary();
      
      public static const HEIGHT_PADDING:Dictionary = new Dictionary();
      
      {
         TEXT_SIZE[MainMenuButtonSize.SMALL] = 15;
         TEXT_SIZE[MainMenuButtonSize.REGULAR] = 18;
         LAYOUT_LABEL[MainMenuButtonSize.SMALL] = "small";
         LAYOUT_LABEL[MainMenuButtonSize.REGULAR] = "medium";
         ICON_Y[MainMenuButtonSize.SMALL] = 6;
         ICON_Y[MainMenuButtonSize.REGULAR] = 7;
         HEIGHT_PADDING[MainMenuButtonSize.SMALL] = 0;
         HEIGHT_PADDING[MainMenuButtonSize.REGULAR] = 2;
      }
      
      public function MainMenuButtonSize()
      {
         super();
      }
   }
}
