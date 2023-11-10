package net.wg.gui.lobby.components.interfaces
{
   import net.wg.gui.components.advanced.interfaces.ICooldownSlot;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public interface IBoosterSlot extends ICooldownSlot, IUpdatable
   {
       
      
      function get boosterId() : Number;
   }
}
