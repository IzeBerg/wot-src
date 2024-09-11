package net.wg.gui.components.common
{
   import flash.display.MovieClip;
   
   public class DeprecatedLibraryItem extends MovieClip
   {
       
      
      public function DeprecatedLibraryItem()
      {
         super();
         DebugUtils.LOG_ERROR("This component is not used." + "It is temporarily present in the library " + "in case it is created dynamically from the code. " + new Error().getStackTrace());
      }
   }
}
