package net.wg.gui.lobby.clans.profile.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public interface IClanProfileSummaryBlock extends IUIComponentEx, IUpdatable
   {
       
      
      function getDynHeight() : int;
   }
}
