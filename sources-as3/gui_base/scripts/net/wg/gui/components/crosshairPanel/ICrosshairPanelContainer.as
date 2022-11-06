package net.wg.gui.components.crosshairPanel
{
   import net.wg.infrastructure.base.meta.ICrosshairPanelContainerMeta;
   import net.wg.infrastructure.interfaces.IRootAppMainContent;
   
   public interface ICrosshairPanelContainer extends ICrosshairPanelContainerMeta, IRootAppMainContent
   {
       
      
      function init() : void;
   }
}
