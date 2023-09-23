package net.wg.gui.lobby.vehicleCompare.interfaces
{
   import net.wg.gui.components.advanced.interfaces.IBackButton;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.interfaces.IUpdatableComponent;
   
   public interface IVehCompareViewHeader extends IUpdatableComponent
   {
       
      
      function get backBtn() : IBackButton;
      
      function get closeBtn() : ISoundButtonEx;
   }
}
