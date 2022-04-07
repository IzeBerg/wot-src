package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.IRtsWarningWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.RtsWarningWidgetMeta;
   
   public class RtsWarningWidget extends RtsWarningWidgetMeta implements IRtsWarningWidgetMeta
   {
      
      private static const WIDTH:int = 768;
      
      private static const HEIGHT:int = 112;
       
      
      public function RtsWarningWidget()
      {
         super();
         setSize(WIDTH,HEIGHT);
      }
   }
}
