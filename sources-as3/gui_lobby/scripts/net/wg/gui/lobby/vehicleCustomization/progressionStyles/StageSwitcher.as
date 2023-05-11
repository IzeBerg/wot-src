package net.wg.gui.lobby.vehicleCustomization.progressionStyles
{
   import net.wg.infrastructure.base.meta.IStageSwitcherMeta;
   import net.wg.infrastructure.base.meta.impl.StageSwitcherMeta;
   
   public class StageSwitcher extends StageSwitcherMeta implements IStageSwitcherMeta
   {
      
      private static const OFFSET:int = 1;
      
      private static const WIDTH:uint = 390 + 2 * OFFSET;
      
      private static const HEIGHT:uint = 151 + 2 * OFFSET;
       
      
      public function StageSwitcher()
      {
         super();
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
   }
}
