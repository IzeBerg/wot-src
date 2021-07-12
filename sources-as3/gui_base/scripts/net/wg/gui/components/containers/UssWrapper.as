package net.wg.gui.components.containers
{
   public class UssWrapper extends BaseContainerWrapper
   {
      
      private static const USS_WRAPPER_NAME:String = "UssWrapper";
       
      
      public function UssWrapper()
      {
         super();
         name = USS_WRAPPER_NAME;
      }
      
      public static function createWrapper() : UssWrapper
      {
         return new UssWrapper();
      }
   }
}
