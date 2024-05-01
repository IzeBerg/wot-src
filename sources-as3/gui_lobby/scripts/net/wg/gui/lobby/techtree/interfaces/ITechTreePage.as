package net.wg.gui.lobby.techtree.interfaces
{
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.infrastructure.base.meta.IResearchViewMeta;
   import net.wg.infrastructure.base.meta.ITechTreeMeta;
   
   public interface ITechTreePage extends ITechTreeMeta, IResearchViewMeta
   {
       
      
      function getScrollBar() : ScrollBar;
      
      function getVScrollBar() : ScrollBar;
   }
}
