package net.wg.gui.battle.views.personalReservesTab
{
   import net.wg.infrastructure.base.meta.IPersonalReservesTabMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalReservesTabMeta;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   
   public class PersonalReservesTab extends PersonalReservesTabMeta implements IPersonalReservesTabMeta, IDisplayableComponent
   {
      
      private static const WIDTH:int = 920;
      
      private static const HEIGHT:int = 594;
       
      
      public function PersonalReservesTab()
      {
         super();
         setManageSize(true);
         setSize(WIDTH,HEIGHT);
      }
      
      public function isCompVisible() : Boolean
      {
         return visible;
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
      }
   }
}
