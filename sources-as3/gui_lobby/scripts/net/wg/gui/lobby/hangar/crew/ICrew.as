package net.wg.gui.lobby.hangar.crew
{
   import net.wg.infrastructure.base.meta.ICrewMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   
   public interface ICrew extends IHelpLayoutComponent, ICrewMeta, IDAAPIModule
   {
       
      
      function updateSize(param1:Number) : void;
   }
}
